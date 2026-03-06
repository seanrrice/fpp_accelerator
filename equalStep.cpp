#include <cstdint>
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

#define NSTEPS 5
#define M 4600
#define N 5320

void equalStep_baseline(
    const uint16_t imStack[NSTEPS][M][N],    //16 or 8 bit pictures?
    int nsteps, int nRows, int nCols, 
    double wrappedPhase[M][N], double mod[M][N]
) {

    double sin_k[NSTEPS];
    double cos_k[NSTEPS];

    // precompute sin and cos values
    for (int k = 0; k < nsteps; k++) {
        sin_k[k] = std::sin(2.0 * M_PI * k / nsteps);
        cos_k[k] = std::cos(2.0 * M_PI * k / nsteps);
    }

    // for each pixel, compute wrapped phase and modulation
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            double Phi_t1 = 0.0;
            double Phi_t2 = 0.0;
            for (int k = 0; k < nsteps; k++) {

                double val = (double)imStack[k][i][j];
                Phi_t1 += val * sin_k[k];
                Phi_t2 += val * cos_k[k];

            }
            wrappedPhase[i][j] = std::atan2(Phi_t1, Phi_t2);
            mod[i][j] = std::sqrt(Phi_t1 * Phi_t1 + Phi_t2 * Phi_t2);
        }
    }

}

int main() {

}
