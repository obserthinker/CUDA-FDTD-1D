#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "boundary.cuh"

extern float Ex_bd, dz, dt, coe_MUR, Ex_nbd;
extern float *Ex;
const float C = 3e8;
extern int step_space;

void boundary_init()
{
	Ex_nbd = 0.f;
	Ex_bd = 0.f;

	coe_MUR = (C*dt - dz) / (C*dt + dz);
}

void boundary_cmp_MUR()
{
	int bd, nbd;
	bd = step_space;
	nbd = bd - 1;

	Ex[bd] = Ex_nbd + coe_MUR*(Ex[nbd] - Ex_bd);

	Ex_bd = Ex[bd];
	Ex_nbd = Ex[nbd];
}

void Boundary_cmp_PEC()
{
	Ex[step_space] = 0.f;
}