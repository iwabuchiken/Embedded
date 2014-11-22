#include <stdlib.h>
#include <stdio.h>


void conv_Dex_to_Binary(int, char[9]);
//void conv_Dex_to_Binary(int, char*);

void shift_Right_Left(int);

void main(void) {

	int num = 0xEA;

	shift_Right_Left(num);

//	int c1 = 0x0C;
////	int c1 = 0xFC;
//
//	char binary[9];
//
//
//	printf("c1 => %d\n", c1);
//
//	///////////////////////
//
//	// shift
//
//	///////////////////////
//	c1 = c1 >> 1;
//
//	printf("c1 >> 1 ------------------\n");
//	printf("c1 => %d\n", c1);
//
//	///////////////////////
//
//	// conversion
//
//	///////////////////////
//	conv_Dex_to_Binary(0xCE, binary);
////	conv_Dex_to_Binary(0x0C, binary);
//
//	printf("conversion ------------------\n");
//	printf("binary => %s\n", binary);

    return;

}

void conv_Dex_to_Binary
(int num, char result[9]) {

	int i;
	int len = 8;

	int tmp;

	//debug
	printf("\n");
	printf("[%d] start conversion...\n", __LINE__);

	printf("\n");
	printf("hex => %02x, dex => %d\n", num, num);

	for (i = len - 1; i >= 0; i --) {

		tmp = num & 0x01;

		if (tmp == 1) {

			result[i] = '1';

		} else {

			result[i] = '0';

		}

		// shift
		num = num >> 1;

	}

	///////////////////////

	// null char

	///////////////////////
	result[8] = '\0';

	///////////////////////

	// report

	///////////////////////
	printf("\n");
	printf("result => %s\n", result);
//	printf("result => %s (%x)\n", result, num);

}

void shift_Right_Left(int num) {

	//debug
	printf("\n");
	printf("[%d] ----------- shift_Right_Left -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);

	///////////////////////

	// shift: right

	///////////////////////
	num = num >> 3;

	//debug
	printf("\n");
	printf("[%d] ----------- num >> 3 -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);

	///////////////////////

	// shift: left

	///////////////////////
	num = num << 3;

	//debug
	printf("\n");
	printf("[%d] ----------- num << 3 -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);


}
