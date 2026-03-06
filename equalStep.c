#include <stdio.h>
#include <stdlib.h>
#include <math.h>

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
void equalStep(unsigned short* imStack, int nsteps, int M, int N, double* wrappedPhase, double* mod){

    // allocate sin and cos values
    double* sin_k = (double*)malloc(nsteps * sizeof(double));
    double* cos_k = (double*)malloc(nsteps * sizeof(double));

    // precompute sin and cos values
    for (int k = 0; k < nsteps; k++){
        sin_k[k] = sin(2 * M_PI * k / nsteps);
        cos_k[k] = cos(2 * M_PI * k / nsteps);
    }

    // for each pixel, compute wrapped phase and modulation
    for (int i = 0; i < M; i++){
        for (int j = 0; j < N; j++){
            double Phi_t1 = 0;
            double Phi_t2 = 0;
            for (int k = 0; k < nsteps; k++){
                
                int index = k * (M * N) + i * N + j;
                Phi_t1 += imStack[index] * sin_k[k];
                Phi_t2 += imStack[index] * cos_k[k];
            }
            wrappedPhase[i * N + j] = atan2(Phi_t1, Phi_t2);
            mod[i * N + j] = sqrt(Phi_t1 * Phi_t1 + Phi_t2 * Phi_t2);
        }
    }

    // free allocated sin and cos arrays
    free(sin_k);
    free(cos_k);
}

int main(){

}
