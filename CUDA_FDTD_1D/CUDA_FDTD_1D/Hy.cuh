#pragma once
#ifndef HY_CUH
#define HY_CUH

void Hy_init(int size_space);
void Hy_checkout(int size_Hy);
void Hy_transfer_host_device(int size_Hy);
void Hy_transfer_device_host(int size_Hy);
__global__ void Hy_cmp_kernel(float* dev_Hy, float * dev_Ex, float coe_Hy, int size_space);

#endif