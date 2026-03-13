#include "../include/equalStep_baseline.h"
#include <cmath>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

/*
* imStack is an nsteps x M x N array of images
* nsteps is the number of images in the stack
* M is the number of rows in each image
* N is the number of columns in each image
* Returns an M X N image with the same dimensions as the images in imStack
* where each pixel is the wrapped phase of the pixels in the stack
*/


void equalStep_baseline(
    uint16_t imStack[NSTEPS*M*N],    //16 or 8 bit pictures?
    double wrappedPhase[M*N], 
    double mod[M*N]
) {
    
    double sin_k[NSTEPS];
    double cos_k[NSTEPS];
    
    #pragma HLS ARRAY_PARTITION variable=sin_k type=complete
    #pragma HLS ARRAY_PARTITION variable=cos_k type=complete

    // precompute sin and cos values
    sin_loop: for (size_t k = 0; k < NSTEPS; k++) {
        #pragma HLS UNROLL
        sin_k[k] = std::sin(2.0 * M_PI * k / NSTEPS);
        cos_k[k] = std::cos(2.0 * M_PI * k / NSTEPS);
    }

    // for each pixel, compute wrapped phase and modulation
    wrap_loop: for (int i = 0; i < M*N; i++) {
        #pragma HLS PIPELINE II=NSTEPS
        uint16_t* pixel_data = &imStack[i*NSTEPS];
        double Phi_t1 = pixel_data[0] * sin_k[0] + pixel_data[1] * sin_k[1] + pixel_data[2] * sin_k[2] + pixel_data[3] * sin_k[3] + pixel_data[4] * sin_k[4];
        double Phi_t2 = pixel_data[0] * cos_k[0] + pixel_data[1] * cos_k[1] + pixel_data[2] * cos_k[2] + pixel_data[3] * cos_k[3] + pixel_data[4] * cos_k[4];
        
        wrappedPhase[i] = std::atan2(Phi_t1, Phi_t2);
        mod[i] = std::sqrt(Phi_t1 * Phi_t1 + Phi_t2 * Phi_t2);
    }
}
