#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>

#define STBI_NO_SIMD                 //to avoid cosim compilation errors
#define STB_IMAGE_IMPLEMENTATION
#include "../include/stb_image.h"
#include "../include/equalStep_baseline.h"


constexpr int M = 64;
constexpr int N = 64;
constexpr int MN = M * N;



static inline double wrapToPi(double x) {
	while (x > M_PI) x -= 2.0 * M_PI;
	while (x < -M_PI) x += 2.0 * M_PI;
	return x;
}

//
//Loads 16 bit or 8 bit images, converts to uint16_t if 8-bit
//
bool load_png_grayscale_u16(const std::string& filename,
    std::vector<uint16_t>& out,
    int& width, int& height)
{
    int w = 0, h = 0, channels = 0;

    if (stbi_is_16_bit(filename.c_str())) {
        uint16_t* img = stbi_load_16(filename.c_str(), &w, &h, &channels, 1);
        if (!img) {
            std::cerr << "Failed to load 16-bit PNG: " << filename << "\n";
            return false;
        }

        out.assign(img, img + static_cast<size_t>(w) * static_cast<size_t>(h));
        stbi_image_free(img);
    }
    else {
        unsigned char* img = stbi_load(filename.c_str(), &w, &h, &channels, 1);
        if (!img) {
            std::cerr << "Failed to load 8-bit PNG: " << filename << "\n";
            return false;
        }

        out.resize(static_cast<size_t>(w) * static_cast<size_t>(h));
        for (size_t i = 0; i < out.size(); i++) {
            out[i] = static_cast<uint16_t>(img[i]);
        }
        stbi_image_free(img);
    }

    width = w;
    height = h;
    return true;
}
// 
// Load CSV into flat double vector
// 
bool load_csv_fixed(const std::string& filename, std::vector<phase_t>& out, int& rows, int& cols)
{
    std::ifstream fin(filename);
    if (!fin.is_open()) {
        std::cerr << "Failed to open CSV: " << filename << "\n";
        return false;
    }

    out.clear();
    rows = 0;
    cols = -1;

    std::string line;
    while (std::getline(fin, line)) {
        if (line.empty()) continue;

        std::stringstream ss(line);
        std::string cell;
        int current_cols = 0;

        while (std::getline(ss, cell, ',')) { 
            if (!cell.empty() && (cell.back() == '\r' || cell.back() == '\n')) {
                cell.pop_back();
            }
            //convert cell to double, append out[]
            out.push_back(std::stod(cell));
            current_cols++;
        }

        if (cols == -1) {
            cols = current_cols;
        }
        else if (current_cols != cols) {
            std::cerr << "Inconsistent column count in CSV: " << filename << "\n";
            return false;
        }

        rows++;
    }

    if (rows == 0 || cols <= 0) {
        std::cerr << "Empty or invalid CSV: " << filename << "\n";
        return false;
    }

    return true;
}

int main() {
    constexpr int NDATASETS = 1;   // use 1 for cosim testing on TestData_small, use 6 for full dataset testing

    // You may need to adjust this path depending on csim working directory
    const std::string data_dir = "./TestData_small";

    const uint32_t num_pixels = static_cast<uint32_t>(MN);
    const uint32_t num_words = (num_pixels + LANES - 1) / LANES;



    //Global error accumulators
    double global_max_phase = 0.0;
    double global_max_mod = 0.0;
    double global_phase_sse = 0.0;  // "sse = sum of squared errors"
    double global_mod_sse = 0.0;
    size_t global_pixels = 0;

// ========================================================
// IMPORTANT:
// Use static arrays that match the HLS top function 
// ========================================================
    static uint16_t imStack_hw[NSTEPS*M*N];
    static phase_t phi_out[M*N];
    static mod_t mod_out[M*N];

    //Dataset loop
    for (int ds = 0; ds < NDATASETS; ds++) {
        std::cout << "\n==== Dataset: " << ds << "====\n";

        //Load first image to determine dimensions
        int width = 0, height = 0;
        std::vector<uint16_t> first_img;

        std::string first_name = data_dir + "/stack_" + std::to_string(ds) + "_0.png";
        if (!load_png_grayscale_u16(first_name, first_img, width, height)) {
            std::cout << "Error 1 occurred \n";
            return 1;
        }

        //Convert image dimensions to matrix dimensions
        const int nRows = height;
        const int nCols = width;
        const size_t MN = static_cast<size_t>(nRows) * static_cast<size_t>(nCols);

        std::cout << "Image size: " << nRows << " x " << nCols << "\n";

       // Check that runtime image size matches compile-time HLS size
        if (nRows != M || nCols != N) {
            std::cerr << "ERROR: Input image dimensions do not match HLS dimensions.\n";
            std::cerr << "Expected: " << M << " x " << N << "\n";
            std::cerr << "Got:      " << nRows << " x " << nCols << "\n";
            return 1;
        }

        //Copy first image into HLS input array
        for (size_t i = 0; i < MN; i++) {
            imStack_hw[i*NSTEPS] = first_img[i];
        }

        //Load remaining images to stack
        for (int k = 1; k < NSTEPS; k++) {
            std::vector<uint16_t> img;
            int w = 0, h = 0;

            std::string fname = data_dir + "/stack_" + std::to_string(ds) + "_" + std::to_string(k) + ".png";
            if (!load_png_grayscale_u16(fname, img, w, h)) {
                std::cout << "Error 2 occurred. \n";
                return 1;
            }
            if (w != nCols || h != nRows) {
                std::cerr << "Dimension mismatch in " << fname << "\n";
                return 1;
            }
           
            for (size_t i = 0; i < MN; i++) {
                imStack_hw[i*NSTEPS + k] = img[i];
            }
        }

        //Load reference CSV outputs
        std::vector<phase_t> phi_ref, mod_ref;

        int phi_rows = 0, phi_cols = 0;
        int mod_rows = 0, mod_cols = 0;

        std::string phi_name = data_dir + "/phi_" + std::to_string(ds) + ".csv";
        std::string mod_name = data_dir + "/mod_" + std::to_string(ds) + ".csv";

        if (!load_csv_fixed(phi_name, phi_ref, phi_rows, phi_cols)) {
            std::cout << "Error 3 occurred. \n";
            return 1;
        }
        if (!load_csv_fixed(mod_name, mod_ref, mod_rows, mod_cols)) {
            std::cout << "Error 4 occurred. \n";
            return 1;
        }

        //Verify reference dimensions
        if (phi_rows != nRows || phi_cols != nCols) {
            std::cerr << "Phi CSV dimensions do not match image size.\n";
            return 1;
        }

        if (mod_rows != nRows || mod_cols != nCols) {
            std::cerr << "Mod CSV dimensions do not match image size.\n";
            return 1;
        }
        hls::stream<in_t> imStack_stream;
     
        //Pack LANES pixels per input stream word
        for (uint32_t word = 0; word < num_words; word++){
            in_t beat;

            for (int lane = 0; lane < LANES; lane++){
                uint32_t pixel_idx = word * LANES + lane;

                for (int k= 0; k < CHUNK_SIZE; k++){
                    if (pixel_idx < num_pixels && k < NSTEPS){
                        beat.data[lane][k] = imStack_hw[pixel_idx * NSTEPS + k];
                    } else {
                        beat.data[lane][k] = 0;
                    }
                }

            }

            beat.last = (word == num_words - 1);
            beat.keep = -1;
            beat.strb = -1;

            imStack_stream.write(beat);
        }

        hls::stream<out_t> out;

        //Run the HLS function
        equalStep_baseline(imStack_stream, out, num_pixels);

        // Unpack LANES pixels per output stream word
        for (uint32_t word = 0; word < num_words; word++){
            out_t o = out.read();

            for (int lane = 0; lane < LANES; lane++){
                uint32_t pixel_idx = word * LANES + lane;

                if (pixel_idx < num_pixels){
                    one_pixel_out_t d = o.data[lane];

                    phi_out[pixel_idx].range(17, 0) = d(17, 0);
                    mod_out[pixel_idx].range(35, 0) = d(53, 18);
                }
            }
        }

        //Initialize per-dataset error metrics
        double max_phase_error = 0.0;
        double max_mod_error = 0.0;
        double sse_phase = 0.0;         //sum of squared phase errors
        double sse_mod = 0.0;

        //Compare HLS output to reference
        for (size_t i = 0; i < MN; i++) {
            double e_phase = wrapToPi(phi_out[i] - phi_ref[i]);
            double e_mod = mod_out[i] - mod_ref[i];

            max_phase_error = std::max(max_phase_error, std::abs(e_phase));
            max_mod_error = std::max(max_mod_error, std::abs(e_mod));

            sse_phase += e_phase * e_phase;
            sse_mod += e_mod * e_mod;
        }
        
        double rmse_phase = std::sqrt(sse_phase / static_cast<double> (MN));
        double rmse_mod = std::sqrt(sse_mod / static_cast<double> (MN));

        //Print per-dataset results
        std::cout << "Dataset " << ds << " results: " << "\n";

        std::cout << "Max phase error (rad) : " << max_phase_error << "\n";
        std::cout << "RMS phase error (rad) : " << rmse_phase << "\n";

        std::cout << "Max mod error: " << max_mod_error << "\n";
        std::cout << "RMS mod error: " << rmse_mod << "\n";

        //Update global totals
        global_max_phase = std::max(global_max_phase, max_phase_error);
        global_max_mod = std::max(global_max_mod, max_mod_error);
        global_phase_sse += sse_phase;
        global_mod_sse += sse_mod;
        global_pixels += MN;
    }

    //Print overall summary
    std::cout << "\n=== Overall Results ===\n";
    std::cout << "Global phase max err: " << global_max_phase << "\n";
    std::cout << "Global phase RMSE:    "
        << std::sqrt(global_phase_sse / static_cast<double>(global_pixels)) << "\n";
    std::cout << "Global mod max err:   " << global_max_mod << "\n";
    std::cout << "Global mod RMSE:      "
        << std::sqrt(global_mod_sse / static_cast<double>(global_pixels)) << "\n";

    return 0;

}
