#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include <cmath>

using namespace std;

extern float dz, dt;
extern int size_space, size_time;
const float C = 3e8f;

void src_init()
{
	dz = 0.015;
	dt = dz / (2 * C);
}

void src_checkout()
{
	cout << "dz: " << dz << endl;
	cout << "dt: " << dt << endl;
}

__global__ void src_cmp_kernel(int current_timestep, float dt, float* dev_Ex, int size_space)
{
	float T, T0, vt, val_src, time;

	time = current_timestep * dt;

	T = 5e-10f;
	T0 = 3 * T;
	vt = (time - T0) / T;

	val_src = expf(-powf(vt, 2.0f));

	dev_Ex[0] = val_src;
}