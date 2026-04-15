//#pragma once
#ifndef EQUALSTEP_BASELINE_H_
#define EQUALSTEP_BASELINE_H_

#include <cstdint>
#include "hls_stream.h"
#include "hls_vector.h"
#include "ap_fixed.h"
#include "hls_math.h"
#include "ap_axi_sdata.h"

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define NSTEPS 5
#define M 1080
#define N 1920
// #define M 64        //small test size for co-sim
// #define N 64

constexpr int next_pow2(int n) {
    int p = 1;
    while (p < n) p <<= 1;
    return p;
}
constexpr int CHUNK_SIZE = next_pow2(NSTEPS);

typedef hls::vector<uint16_t, CHUNK_SIZE> pixel_chunk_t;

// typedef ap_fixed<32,18> accum_t;
// typedef ap_fixed<18,2> coeff_t;
// typedef ap_fixed<20,4> phase_t;
// typedef ap_fixed<24,18> mod_t;

typedef ap_fixed<40,22> accum_t;
typedef ap_fixed<18,2> coeff_t;
typedef ap_fixed<20,4> phase_t;
typedef ap_fixed<32,22> mod_t;

struct phase_mod_t {
    phase_t wrappedPhase;  // ap_fixed<20,4>
    mod_t   mod;           // ap_fixed<24,18>
};

// typedef hls::axis<phase_mod_t,0,0,0> out_t;
typedef ap_uint<64> out_data_t;
typedef hls::axis<out_data_t,0,0,0> out_t;
typedef hls::axis<pixel_chunk_t,0,0,0> in_t;

void equalStep_baseline(
    hls::stream<in_t>& imStack,
    hls::stream<out_t>& out
);

#endif