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
    hls::stream<in_t>& imStack,    //16 bit pictures
    hls::stream<out_t>& out
) {
    #pragma HLS INTERFACE axis      port=imStack
    #pragma HLS INTERFACE axis      port=out register_mode=both
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
        pixel_chunk_t pixel_data = imStack.read().data; // Get next chunk of pixels from the data stream
        accum_t Phi_t1 = 0; accum_t Phi_t2 = 0;
        phi_loop: for (size_t j = 0; j < NSTEPS; j++) {
            #pragma HLS UNROLL
            Phi_t1 += pixel_data[j] * sin_k[j];
            Phi_t2 += pixel_data[j] * cos_k[j];
        }
        
        phase_t p = hls::atan2(Phi_t1, Phi_t2);
        float sum_sq_f =(float)((Phi_t1 * Phi_t1) + (Phi_t2 * Phi_t2));
        float m_sqrt = hls::sqrtf(sum_sq_f);
        mod_t m = (mod_t) m_sqrt;
        out_data_t packed = 0;
        packed(19,0) = p.range(19,0);
        packed(51,20) = m.range(31,0);
        ap_ufixed<46,40> sum_sq = (Phi_t1 * Phi_t1) + (Phi_t2 * Phi_t2);
        packed(63,52) = sum_sq.range(11,0);
        out_t o;
        o.data = packed;
        o.last = (i==M*N - 1); o.keep = -1; o.strb = -1;
        
        out.write(o);
    }
}
