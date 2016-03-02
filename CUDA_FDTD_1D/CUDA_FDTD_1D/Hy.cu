#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>

using namespace std;

//host
extern float *Hy, coe_Hy, dt, dz;
extern int size_space, size_Hy;
const float PI = 3.141592653589793f;
const float mu = (4 * PI)*1e-7f;

//device
extern float *dev_Hy, *dev_Ex;

void Hy_init_malloc(int );
void Hy_init_assignValue(int );
void Hy_checkout();
void Hy_transfer_host_device();
void Hy_transfer_device_host();

void Hy_init(int space_size)
{
	size_Hy = space_size;
	Hy_init_malloc(size_Hy);
	Hy_init_assignValue(size_Hy);
}

void Hy_init_malloc(int size)
{
	//host
	Hy = (float *)malloc(size * sizeof(float));
	//device
	cudaMalloc(&dev_Hy, size * sizeof(float));
}

void Hy_init_assignValue(int size)
{
	int i;
	for ( i = 0; i < size; i++){
		Hy[i] = 0.f;
	}
	
	coe_Hy = dt / (mu * dz);
}

void Hy_checkout(int size)
{
	cout << "Hy: size = " << size << endl;
	cout << "coe_Hy = " << coe_Hy;
	cout << "Hy: ";
	for (int i = 0; i < size; i++)
	{
		cout << Hy[i] << "\t";
	}
	cout << endl;
}

void Hy_transfer_host_device(int size_Hy)
{
	cudaMemcpy(dev_Hy, Hy, size_Hy * sizeof(float), cudaMemcpyHostToDevice);
}

void Hy_transfer_device_host(int size_Hy)
{
	cudaMemcpy(Hy, dev_Hy, size_Hy * sizeof(float), cudaMemcpyDeviceToHost);
}

__global__ void Hy_cmp_kernel(float* dev_Hy, float * dev_Ex, float coe_Hy, int size_space)
{
	int i;
	for (i = 0; i < size_space; i++){
		dev_Hy[i] = dev_Hy[i] - (coe_Hy)*(dev_Ex[i + 1] - dev_Ex[i]);
		//test
		//dev_Hy[i] = i*10.0;
	}
}