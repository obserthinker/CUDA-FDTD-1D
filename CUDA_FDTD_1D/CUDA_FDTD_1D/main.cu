#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "Hy.cuh"
#include "Ex.cuh"
#include "src.cuh"
#include "save2file.cuh"

#define MULTI_B_T

using namespace std;

//host
float *Ex, *Hy, coe_Hy, coe_Ex, dt, dz, coe_MUR, Ex_bd, Ex_nbd;
int size_space, size_time, size_Hy, size_Ex;
//device
float *dev_Ex, *dev_Hy, *dev_Ex_bd, *dev_Ex_nbd;
//test
int gpu_data_int;

int main()
{
	size_space = 30;
	size_time = 300;
	/***** source *****/
	src_init();

	/*********  Hy ********/
	Hy_init(size_space);
	//Hy_checkout(size_Hy);
	Hy_transfer_host_device(size_Hy);

	/******** Ex ********/
	Ex_init(size_space);
	//Ex_checkout(size_Ex);
	Ex_transfer_host_device(size_Ex);

	/******** File ********/
	file_init();

	for (int i = 0; i < size_time; i++)
	{
#ifndef MULTI_B_T
		Hy_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, coe_Hy, size_space);
		Ex_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, coe_Ex, size_space);
		Ex_boundary_PEC_kernel << <1, 1 >> >(dev_Ex, size_space);
		src_cmp_kernel << <1, 1 >> >(i, dt, dev_Ex, size_space);
#else
		Hy_cmp_kernel << <4, 10 >> >(dev_Hy, dev_Ex, coe_Hy, size_space);
		Ex_cmp_kernel << <4, 10 >> >(dev_Hy, dev_Ex, coe_Ex, size_space);
		//PEC
		//Ex_boundary_PEC_kernel << <1, 1 >> >(dev_Ex, size_space);
		//MUR
		Ex_boundary_MUR_kernek << <1, 1 >> >(dev_Ex, size_space, dev_Ex_bd, dev_Ex_nbd, coe_MUR);
		src_cmp_kernel << <1, 1 >> >(i, dt, dev_Ex, size_space);
#endif
		Hy_transfer_device_host(size_Hy);
		Ex_transfer_device_host(size_Ex);
		
		save2file();
	}

	cudaFree(dev_Ex);
	cudaFree(dev_Hy);
	//Hy_checkout(size_Hy);
	//Ex_checkout(size_Ex);
	
    return 0;
}