#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <math.h>

///////////////////////

// protos

///////////////////////
void
conv_Hex_to_SecString(int, char[12]);

///////////////////////

// funcs

///////////////////////
char title[] = "D-111 v-3_0";

void main(int argc, char** args) {

	char cont[12];

	int x = 2635;

	///////////////////////

	// setup: x

	///////////////////////
	if (argc > 1) {

		x = atoi(args[1]);

	}

	printf("%s\n", title);

	conv_Hex_to_SecString(x, cont);

	printf("%d => %s\n", x, cont);

	return;

}

void
conv_Hex_to_SecString(int x, char cont[12]) {

	int d100, d10, d1,dp1, dp2, dp3, residue, residue2;

	d1 = x / 1000;

	residue = x - 1000 * d1;

	dp1 = residue / 100;

	residue = residue - dp1 * 100;

	//debug
	printf("x = %d, d1 = %d, dp1 = %d, residue = %d\n", x, d1, dp1, residue);

	dp2 = residue / 10;

	residue = residue - dp2 * 10;

	//debug
	printf("dp2 = %d, residue = %d\n", dp2, residue);

//	dp3 = x / 1000;
//

	///////////////////////

	// integer

	///////////////////////
	d100 = d1 / 100;
	residue2 = d1 - d100 * 100;

	d10 = residue2 / 10;
	residue2 = residue2 - d10 * 10;

	d1 = residue2;

	///////////////////////

	// set

	///////////////////////
	cont[0] = (d100 == 0) ? ' ' : d100 + 0x30;
//	cont[0] = d100 + 0x30;

	cont[1] = (d10 == 0) ? ' ' : d10 + 0x30;
	cont[2] = d1 + 0x30;
	cont[3] = '.';
	cont[4] = dp1+ 0x30;
	cont[5] = dp2 + 0x30;
	cont[6] = residue + 0x30;
	cont[7] = ' ';

	cont[8] = 's';
	cont[9] = 'e';
	cont[10] = 'c';
	cont[11] = '\0';

}
