#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "Hy.cuh"

extern float *Ex, *Hy;
extern int step_space, step_time;
extern float *coe_Hy, dt, dz;
extern const float mu;
//
extern float *dev_Ex, *dev_Hy, *dev_coe_Hy;

void Hy_transfer_Host_Device(int size)
{
	cudaMemcpy(dev_Hy, Hy, size * sizeof(float), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_coe_Hy, coe_Hy, sizeof(float), cudaMemcpyHostToDevice);
}

void Hy_init()
{
	int i, step_space_Hy;
	step_space_Hy = step_space;

	//Allocate memory for Host
	Hy = (float *)malloc(step_space_Hy * sizeof(float));
	coe_Hy = (float *)malloc(sizeof(float));
	//Allocate memory for device
	cudaMalloc(&dev_coe_Hy, step_space_Hy * sizeof(float));
	cudaMalloc(&dev_coe_Hy, sizeof(float));

	for (i = 0; i < step_space_Hy; i++)	{
		Hy[i] = 0.f;
	}

	*coe_Hy = dt / (mu*dz);

	Hy_transfer_Host_Device(step_space_Hy);
}

void Hy_cmp()
{
	int i;
	for (i = 0; i < step_space; i++){
		Hy[i] = Hy[i] - (*coe_Hy)*(Ex[i + 1] - Ex[i]);
	}
}