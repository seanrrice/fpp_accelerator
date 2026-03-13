//#pragma once
#ifndef EQUALSTEP_BASELINE_H_
#define EQUALSTEP_BASELINE_H_

#include <cstdint>

#define NSTEPS 5
//#define M 1080
//#define N 1920
#define M 64        //small test size for co-sim
#define N 64

void equalStep_baseline(
    uint16_t imStack[NSTEPS*M*N],
    double wrappedPhase[M*N],
    double mod[M*N]
);

#endif