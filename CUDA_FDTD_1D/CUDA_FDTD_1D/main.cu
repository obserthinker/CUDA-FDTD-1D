#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include "Hy.cuh"
#include "Ex.cuh"
#include "src.cuh"
#include "save2file.cuh"

using namespace std;

//host
float *Ex, *Hy, coe_Hy, coe_Ex, dt, dz;
int size_space, size_time, size_Hy, size_Ex;
//device
float *dev_Ex, *dev_Hy;
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
		Hy_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, coe_Hy, size_space);
		Ex_cmp_kernel << <1, 1 >> >(dev_Hy, dev_Ex, coe_Ex, size_space);
		Ex_boundary_PEC_kernel << <1, 1 >> >(dev_Ex, size_space);
		src_cmp_kernel << <1, 1 >> >(i, dt, dev_Ex, size_space);

		Hy_transfer_device_host(size_Hy);
		Ex_transfer_device_host(size_Ex);
		
		save2file();
	}

	//Hy_checkout(size_Hy);
	//Ex_checkout(size_Ex);
	
    return 0;
}