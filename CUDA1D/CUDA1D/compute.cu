#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "compute.cuh"
#include "Hy.cuh"
#include "Ex.cuh"
#include "boundary.cuh"
#include "source.cuh"
#include "save2file.cuh"

using namespace std;

extern float *Ex, *Hy;
extern int step_time;

void compute()
{
	int i;
	for (i = 0; i < step_time; i++){
		Hy_cmp();
		Ex_cmp();
		boundary_cmp_MUR();
		//Boundary_cmp_PEC();
		src_cmp(i);
		//save2file();
	}
}