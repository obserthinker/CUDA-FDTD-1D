#pragma once
#ifndef SRC_CUH
#define SRC_CUH

void src_init();
void src_checkout();
__global__ void src_cmp_kernel(int current_timestep, float dt, float* dev_Ex, int size_space);

#endif