#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <math.h>

///////////////////////

// protos

///////////////////////

///////////////////////

// funcs

///////////////////////
char title[] = "D-116 v-1_2";

void main(int argc, char** args) {

	printf("title = %s\n", title);

	int n1 = (0x02 << 3);
	int n2 = (0x40|(0x02 << 3));

	printf("(0x02 << 3) => %d(%x)\n", n1, n1);
//	printf("(0x02 << 3) => %d(%x)\n", (0x02 << 3), );
	printf("(0x40|(0x02 << 3)) => %d(%x)\n", n2, n2);


	return;

}

