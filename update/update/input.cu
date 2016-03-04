#include <iostream>
#include "source.cuh"
#include "Hy.cuh"
#include "Ex.cuh"
#include "boundary.cuh"
#include "save2file.cuh"

using namespace std;

float space_length, time_length, omega;

extern float *coe_MUR, *coe_Ex, *coe_Hy, dt, dz;
extern int step_space, step_time;

extern const float PI = 3.141592653589793;
extern const float C = 299792458;
extern const float mu = (4 * PI)*1e-7;
extern const float eps = 8.85e-12;

void init_check()
{
	cout << "dz = " << dz << endl;
	cout << "dt = " << dt << endl;
	cout << "Nx : " << step_space << endl;
	cout << "Nt : " << step_time << endl;
	cout << "Coe_Ex: " << *coe_Ex << endl;
	cout << "Coe_Hy: " << *coe_Hy << endl;
	cout << "Coe_MUR: " << *coe_MUR << endl;
}

void initialize()
{
	src_init();
	step_space = 30;
	step_time = 500;
	Ex_init();
	Hy_init();
	boundary_init();
	file_init();
	init_check();
}

void input()
{
	initialize();
}


