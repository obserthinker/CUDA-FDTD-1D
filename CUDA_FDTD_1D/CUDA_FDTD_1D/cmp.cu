#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "Hy.cuh"
#include "Ex.cuh"

using namespace std;

extern int step_space, size_Ex, size_Hy;
extern float *dev_Hy, *dev_Ex;

void cmp_compute();
void cmp_show_result();

void cmp()
{
	cmp_compute();

	cmp_show_result();
}

void cmp_compute()
{
	Hy_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, step_space);
	//Ex_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, step_space);
}

void cmp_show_result()
{
	Hy_transfer_device_host(size_Hy);
	Hy_checkout(size_Ex);
	//Ex_transfer_device_host(size_Ex);
	//Ex_checkout(size_Ex);
}