#include <iostream>
#include "Ex.h"

using namespace std;

extern float *Ex, *Hy;
extern int step_space, step_time;
extern float coe_Ex, dt,dz;
//extern const float epsilon;
const float epsilon = 8.85e-12;

void Ex_init()
{
	int i;
	int step_space_Ex;
	step_space_Ex = step_space + 1;
	Ex = (float *)malloc(step_space * sizeof(float));

	for (i = 0; i < step_space_Ex; i++){
		Ex[i] = 0.f;
	}

	coe_Ex = dt / (epsilon * dz);
}

void Ex_cmp()
{
	int i;
	for (i = 1; i < step_space; i++){
		Ex[i] = Ex[i] - coe_Ex*(Hy[i] - Hy[i - 1]);
	}
}