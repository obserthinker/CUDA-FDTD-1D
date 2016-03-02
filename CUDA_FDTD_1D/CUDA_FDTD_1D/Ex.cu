#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>

using namespace std;

extern float *Ex, *dev_Ex, coe_Ex, dt, dz;
extern int size_space, size_Ex;
const float epsilon = 8.85e-12;

void Ex_init_allocate(int size_Ex)
{
	Ex = (float *)malloc(size_Ex* sizeof(float));
	cudaMalloc(&dev_Ex, size_Ex* sizeof(float));
}

void Ex_init_assignValue(int size_Ex)
{
	for (int i = 0; i < size_Ex; i++){
		Ex[i] = 0.f;
	}

	coe_Ex = dt / (epsilon * dz);
}

void Ex_transfer_host_device(int size_Ex)
{
	cudaMemcpy(dev_Ex, Ex, size_Ex * sizeof(float), cudaMemcpyHostToDevice);
}

void Ex_transfer_device_host(int size_Ex)
{
	cudaMemcpy(Ex, dev_Ex, size_Ex * sizeof(float), cudaMemcpyDeviceToHost);
}

__global__ void Ex_cmp_kernel(float* dev_Hy, float * dev_Ex, float coe_Ex, int step_space)
{
	for (int i = 1; i < step_space; i++){
		dev_Ex[i] = dev_Ex[i] - coe_Ex * (dev_Hy[i] - dev_Hy[i - 1]);
		//test
		//dev_Ex[i] = i / 10.0;
	}
}

void Ex_checkout(int size)
{
	cout << "Ex: size = " << size << endl;
	cout << "coe_Ex = " << coe_Ex;
	cout << "Ex: ";
	for (int i = 0; i < size; i++)
	{
		cout << Ex[i] << "\t";
	}
	cout << endl;
}

void Ex_init(int size_space)
{
	size_Ex = size_space + 1;
	Ex_init_allocate(size_Ex);
	Ex_init_assignValue(size_Ex);
}

__global__ void Ex_boundary_PEC_kernel(float* dev_Ex, int size_space)
{
	dev_Ex[size_space] = 0.f;
}