#include "../include/equalStep_baseline.h"

/*
* imStack is an nsteps x M x N array of images
* nsteps is the number of images in the stack
* M is the number of rows in each image
* N is the number of columns in each image
* Returns an M X N image with the same dimensions as the images in imStack
* where each pixel is the wrapped phase of the pixels in the stack
*/


void equalStep_baseline(
    hls::stream<pixel_chunk_t>& imStack,    //16 bit pictures
    phase_t wrappedPhase[M*N], 
    mod_t mod[M*N]
) {
    #pragma HLS INTERFACE axis      port=imStack
    #pragma HLS INTERFACE bram      port=wrappedPhase
    #pragma HLS INTERFACE bram      port=mod
    #pragma HLS INTERFACE s_axilite port=return

    
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

    // for each pixel, compute wrapped phase and modulation
    wrap_loop: for (size_t i = 0; i < M*N; i++) {
        #pragma HLS PIPELINE II=1
        pixel_chunk_t pixel_data = imStack.read(); // Get next chunk of pixels from the data stream
        accum_t Phi_t1 = 0; accum_t Phi_t2 = 0;
        phi_loop: for (size_t j = 0; j < NSTEPS; j++) {
            #pragma HLS UNROLL
            Phi_t1 += pixel_data[j] * sin_k[j];
            Phi_t2 += pixel_data[j] * cos_k[j];
        }
        
        wrappedPhase[i] = hls::atan2(Phi_t1, Phi_t2);
        mod[i] = hls::sqrt(Phi_t1 * Phi_t1 + Phi_t2 * Phi_t2);
    }
}
