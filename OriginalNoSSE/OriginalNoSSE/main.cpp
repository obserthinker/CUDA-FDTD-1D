#include <iostream>
#include <cmath>
#include <fstream>
#include "input.h"
#include "compute.h"

using namespace std;

void Boundary_PEC(float* Ex, int Nx);
void Save2File(float* Ex, float* Hy, int Nx);

float *Ex, *Hy;
int step_space, step_time;
float coe_Ex, coe_Hy, coe_MUR, dt, dz, Ex_nbd, Ex_bd;

const float PI = 3.141592653589793;
const float C = 299792458;
const float mu = (4 * PI)*1e-7;
const float epsilon = 8.85e-12;

void main()
{
	input();
	compute();
}