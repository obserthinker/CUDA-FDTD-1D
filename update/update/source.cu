#include <iostream>
#include <cmath>
#include "source.cuh"

extern float dz, dt;
extern float *Ex;
const float C = 3e8;

void	src_init()
{
	dz = 0.015;
	dt = dz / (2 * C);
}

void src_cmp(int current_timestep)
{
	float T, T0, vt, val_src, time;

	time = current_timestep * dt;
	T = 5e-10;
	T0 = 3 * T;
	vt = (time - T0) / T;

	val_src = exp(-pow(vt, 2));

	Ex[0] = val_src;
}