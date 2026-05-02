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
#define MAX_PIXELS 0x400000
#define MAX_WORDS ((MAX_PIXELS + LANES - 1) / LANES)

// add a lane parameter
#define LANES 4

constexpr int next_pow2(int n) {
    int p = 1;
    while (p < n) p <<= 1;
    return p;
}
constexpr int CHUNK_SIZE = next_pow2(NSTEPS);

typedef hls::vector<uint16_t, CHUNK_SIZE> pixel_chunk_t;

// One input stream word now holds LANES pixels
typedef hls::vector<pixel_chunk_t, LANES> input_lane_t;
typedef ap_uint<64> one_pixel_out_t;
typedef hls::vector<one_pixel_out_t, LANES> output_lane_t;


typedef ap_uint<12> pixel_12_t;
typedef ap_fixed<28,16> mod_12_t;
typedef ap_fixed<29,17> accum_t;
typedef ap_fixed<58,34> square_t;
typedef ap_fixed<59,35> square_sum_t;
typedef ap_fixed<14,2> coeff_t;
typedef ap_fixed<18,3> phase_t;
typedef ap_fixed<36,20> mod_t;


typedef hls::axis<input_lane_t,0,0,0> in_t;
typedef hls::axis<output_lane_t,0,0,0> out_t;


void equalStep_baseline(
    hls::stream<in_t>& imStack,
    hls::stream<out_t>& out,
    uint32_t num_pixels
);

#endif