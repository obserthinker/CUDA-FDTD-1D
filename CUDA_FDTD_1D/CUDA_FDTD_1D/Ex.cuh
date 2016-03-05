#pragma once
#ifndef EX_CUH
#define EX_CUH

void Ex_init(int size_space);
__global__ void Ex_cmp_kernel(float* dev_Hy, float * dev_Ex, float coe_Ex, int size_space);
void Ex_transfer_device_host(int size_Ex);
void Ex_transfer_host_device(int size_Ex);
void Ex_checkout(int size_Ex);
__global__ void Ex_boundary_PEC_kernel(float* dev_Ex, int size_space);
__global__ void Ex_boundary_MUR_kernek(float *dev_Ex, int size_space, float *dev_Ex_bd, float *dev_Ex_nbd, float coe_MUR);

#endif