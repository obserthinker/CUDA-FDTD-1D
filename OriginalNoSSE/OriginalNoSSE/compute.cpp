#include <iostream>
#include "compute.h"
#include "Hy.h"
#include "Ex.h"
#include "boundary.h"
#include "source.h"
#include "save2file.h"

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
		src_cmp(i);
		save2file();
	}
}