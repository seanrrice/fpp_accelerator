//#pragma once
#ifndef EQUALSTEP_BASELINE_H_
#define EQUALSTEP_BASELINE_H_

#include <cstdint>
#include "hls_stream.h"
#include "hls_vector.h"
#include "ap_fixed.h"
#include "hls_math.h"

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define NSTEPS 5
//#define M 1080
//#define N 1920
#define M 64        //small test size for co-sim
#define N 64

typedef hls::vector<uint16_t, NSTEPS> pixel_chunk_t;

typedef ap_fixed<32,18> accum_t;
typedef ap_fixed<18,2> coeff_t;
typedef ap_fixed<20,4> phase_t;
typedef ap_fixed<24,18> mod_t;

void equalStep_baseline(
    hls::stream<pixel_chunk_t>& imStack,
    phase_t wrappedPhase[M*N],
    mod_t mod[M*N]
);

#endif