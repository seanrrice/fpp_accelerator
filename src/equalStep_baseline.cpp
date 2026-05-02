#include "../include/equalStep_baseline.h"

/*
* imStack is an nsteps x M x N array of images
* nsteps is the number of images in the stack
* M is the number of rows in each image
* N is the number of columns in each image
* Returns an M X N image with the same dimensions as the images in imStack
* where each pixel is the wrapped phase of the pixels in the stack
*/

//add a helper funciton for one pixel
static one_pixel_out_t compute_one_pixel(
    pixel_chunk_t pixel_data,
    coeff_t sin_k[NSTEPS],
    coeff_t cos_k[NSTEPS]
) {
    #pragma HLS inline

    accum_t Phi_t1 = 0;
    accum_t Phi_t2 = 0;

    phi_loop: for (size_t j = 0; j < NSTEPS; j++){
        #pragma HLS UNROLL
        
        pixel_12_t pix = pixel_data[j] >> 4;
        Phi_t1 += pix * sin_k[j];
        Phi_t2 += pix * cos_k[j]; 
    }

    phase_t p = hls::atan2(Phi_t1, Phi_t2);

    square_t sq1 = Phi_t1 * Phi_t1;
    square_t sq2 = Phi_t2 * Phi_t2;
    square_sum_t sum_sq = sq1 + sq2;
    mod_12_t m_sqrt = hls::sqrt(sum_sq);
    mod_t m = m_sqrt << 4;

    one_pixel_out_t packed = 0;
    packed(17,0) = p.range(17,0);
    packed(53, 18) = m.range(35,0);

    return packed;
}


void equalStep_baseline(
    hls::stream<in_t>& imStack,    //16 bit pictures
    hls::stream<out_t>& out,
    uint32_t num_pixels
) {
    #pragma HLS INTERFACE axis      port=imStack
    #pragma HLS INTERFACE axis      port=out register_mode=both
    #pragma HLS INTERFACE s_axilite port=num_pixels
    #pragma HLS INTERFACE s_axilite port=return

    #pragma HLS ALLOCATION function instances=compute_one_pixel limit=4
    
    coeff_t sin_k[NSTEPS];
    coeff_t cos_k[NSTEPS];
    
    #pragma HLS ARRAY_PARTITION variable=sin_k type=complete
    #pragma HLS ARRAY_PARTITION variable=cos_k type=complete

    // precompute sin and cos values
    sin_loop: for (size_t k = 0; k < NSTEPS; k++) {
        #pragma HLS UNROLL
        sin_k[k] = std::sin(2.0 * M_PI * k / NSTEPS);
        cos_k[k] = std::cos(2.0 * M_PI * k / NSTEPS);
    }

    uint32_t num_words = (num_pixels + LANES - 1) / LANES;

    // for each pixel, compute wrapped phase and modulation
    wrap_loop: for (size_t i = 0; i < num_words; i++) {
        #pragma HLS PIPELINE II=1
        #pragma HLS LOOP_TRIPCOUNT min=1 max=MAX_WORDS

        in_t in_word = imStack.read();
        input_lane_t pixels = in_word.data;

        output_lane_t packed_out;

        lane_loop: for (int lane = 0; lane < LANES; lane++) {
            #pragma HLS UNROLL

            uint32_t pixel_idx = i * LANES + lane;

            if (pixel_idx < num_pixels) {
                packed_out[lane] = compute_one_pixel(pixels[lane], sin_k, cos_k);
            } else {
                packed_out[lane] = 0;
            }
        }   
        

        out_t o;
        o.data = packed_out;
        o.last = (i == num_words - 1);
        o.keep = -1;
        o.strb = -1;

        out.write(o);
    }
        
}

