#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "Ex.cuh"

using namespace std;

extern float *Ex, *Hy;
extern int step_space, step_time;
extern float *coe_Ex, dt,dz;
const float epsilon = 8.85e-12;
//
extern float *dev_Ex, *dev_Hy, *dev_coe_Ex;

void Ex_init()
{
	int i;
	int step_space_Ex;

	step_space_Ex = step_space + 1;
	//allocate memory for host
	Ex = (float *)malloc(step_space_Ex * sizeof(float));
	coe_Ex = (float *)malloc(sizeof(float));
	//allocate memory for device
	cudaMalloc(&dev_Ex, step_space_Ex * sizeof(float));
	cudaMalloc(&dev_coe_Ex, sizeof(float));

	for (i = 0; i < step_space_Ex; i++){
		Ex[i] = 0.f;
	}

	*coe_Ex = dt / (epsilon * dz);
}

void Ex_cmp()
{
	int i;
	for (i = 1; i < step_space; i++){
		Ex[i] = Ex[i] - (*coe_Ex)*(Hy[i] - Hy[i - 1]);
	}
}