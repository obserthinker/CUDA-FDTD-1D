#include "save2file.h"
#include <iostream>
#include <fstream>

using namespace std;

extern float *Ex, *Hy;
extern int step_space;

void file_init()
{
	fstream outEx, outHy;

	outEx.open("Ex.txt", ios::out);
	outEx.close();
	outHy.open("Hy.txt", ios::out);
	outHy.close();
}

void save2file()
{
	fstream outEx;
	outEx.open("Ex.txt", ios::app);
	int i;

	for (i = 0; i < step_space + 1; i++){
		outEx << *(Ex + i) << "\t";
	}
	outEx << endl << endl;
	outEx.close();

	fstream outHy;
	outHy.open("Hy.txt", ios::app);
	for (i = 0; i < step_space; i++){
		outHy << *(Hy + i) << "\t";
	}
	outHy << endl << endl;
	outHy.close();
}