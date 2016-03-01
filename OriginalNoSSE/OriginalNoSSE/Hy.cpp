#include <iostream>
#include "Hy.h"

extern float *Ex, *Hy;
extern int step_space, step_time;
extern float *coe_Hy, dt, dz;
extern const float mu;

void Hy_init()
{
	int i, step_space_Hy;
	step_space_Hy = step_space;

	Hy = (float *)malloc(step_space_Hy * sizeof(float));
	coe_Hy = (float *)malloc(sizeof(float));

	for (i = 0; i < step_space_Hy; i++)	{
		Hy[i] = 0.f;
	}

	*coe_Hy = dt / (mu*dz);
}

void Hy_cmp()
{
	int i;
	for (i = 0; i < step_space; i++){
		Hy[i] = Hy[i] - (*coe_Hy)*(Ex[i + 1] - Ex[i]);
	}
}