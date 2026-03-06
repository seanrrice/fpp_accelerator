#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

void equalStep_baseline(const unsigned short* imStack, int M, int N, double* wrappedPhase, double* mode);

static inline double wrapToPi(double x) {
	while (x > M_PI) x -= 2.0 * M_PI;
	while (x < -M_PI) x += 2.0 * M_PI;
	return x;
}

//
//loads 16 bit or 8 bit images, converts to unsigned short if 8-bit
//
bool load_png_grayscale_u16(const std::string& filename,
    std::vector<unsigned short>& out,
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
            out[i] = static_cast<unsigned short>(img[i]);
        }
        stbi_image_free(img);
    }

    width = w;
    height = h;
    return true;
}

bool load_csv_double(const std::string& filename, std::vector<double>& out, int& rows, int& cols)
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
    constexpr int NSTEPS = 5;
    constexpr int NDATASETS = 6;

    const std::string data_dir = "./TestData";

    //Global error accumulators
    double global_max_phase = 0.0;
    double global_max_mod = 0.0;
    double global_phase_sse = 0.0;  // "sse = sum of squared errors"
    double global_mod_sse = 0.0;
    size_t global_pixels = 0;

    //Dataset loop
    for (int ds = 0; ds < NDATASETS; ds++) {
        std::cout << "\n==== Dataset: " << ds << "====\n";

        //Load first image to determine dimensions
        int width = 0, height = 0;
        std::vector<unsigned short> first_img;

        std::string first_name = data_dir + "/stack_" + std::to_string(ds) + "_0.png";
        if (!load_png_grayscale_u16(first_name, first_img, width, height)) {
            return 1;
        }

        //Convert image dimansions to matrix dimensions
        const int M = height;
        const int N = width;
        const size_t MN = static_cast<size_t>(M) * static_cast<size_t>(N);

        std::cout << "Image size: " << M << " X " << N << "\n";

        //Allocate image stack
        std::vector<unsigned short> imStack(static_cast<size_t>(NSTEPS) * MN);

        //Copy first image to stack
        for (size_t p = 0; p < MN; p++) {
            imStack[p] = first_img[p];
        }
        //Load remaining images to stack
        for (int k = 1; k < NSTEPS; k++) {
            std::vector<unsigned short> img;
            int w = 0, h = 0;

            std::string fname = data_dir + "/stack_" + std::to_string(ds) + "_" + std::to_string(k) + ".png";
            if (!load_png_grayscale_u16(fname, img, w, h)) {
                return 1;
            }
            if (w != N || h != M) {
                std::cerr << "Dimension mismatch in " << fname << "\n";
                return 1;
            }
            //Copy current image into its slot in the flattened stack
            for (size_t p = 0; p < MN; p++) {
                imStack[static_cast<size_t>(k) * MN + p] = img[p];
            }

        }

        //Load reference CSV outputs
        std::vector<double> phi_ref, mod_ref;

        int phi_rows = 0, phi_cols = 0;
        int mod_rows = 0, mod_cols = 0;

        std::string phi_name = data_dir + "/phi_" + std::to_string(ds) + ".csv";
        std::string mod_name = data_dir + "/mod_" + std::to_string(ds) + ".csv";

        if (!load_csv_double(phi_name, phi_ref, phi_rows, phi_cols)) {
            return 1;
        }
        if (!load_csv_double(mod_name, mod_ref, mod_rows, mod_cols)) {
            return 1;
        }

        //Verify reference dimensions
        if (phi_rows != M || phi_cols != N) {
            std::cerr << "Phi CSV dimensions do not match image size.\n";
            return 1;
        }

        if (mod_rows != M || mod_cols != N) {
            std::cerr << "Mod CSV dimensions do not match image size.\n";
            return 1;
        }

        //Allocate HLS outputs
        std::vector<double> phi_out(MN), mod_out(MN);

        //Run the HLS function
        equalStep_baseline(imStack.data(), M, N, phi_out.data(), mod_out.data());

        //Initialize per-dataset error metrics
        double max_phase_error = 0.0;
        double max_mod_error = 0.0;
        double sse_phase = 0.0;         //sum of squared phase errors
        double sse_mod = 0.0;

        //Compare HLS output to reference
        for (size_t p = 0; p < MN; p++) {
            double e_phase = wrapToPi(phi_out[p] - phi_ref[p]);
            double e_mod = mod_out[p] - mod_ref[p];

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
