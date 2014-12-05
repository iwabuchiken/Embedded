#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <math.h>

/*
 * printf\("(.+\\n)", (.+)\);	=> printf("[%d] $1", __LINE__, $2);
 */

///////////////////////

// protos

///////////////////////
void conv_Float_to_String(float, char[6]);

void conv_Hex_to_3Digit_String(int, char[4]);	// 3 digits + null char = 4

///////////////////////

// funcs

///////////////////////
void main(int argc, char** args) {

	float num = 3.543;

	char cont[6];

//	printf("num = %1.3f\n", num);

	conv_Float_to_String(num, cont);

    return;

}

void
conv_Float_to_String
(float num, char cont[6]) {

	int num_Int;
	float num_Decimal;
//	float

	int num_Decimal_int;

	char num_Decimal_str[4];

	///////////////////////

	// int

	///////////////////////
	num_Int = (int) num;

	///////////////////////

	// decimal

	///////////////////////
	num_Decimal = num - num_Int;

	printf("[%d] num = %1.6f, Int = %d, decimal = %1.6f\n",
			__LINE__, num, num_Int, num_Decimal);	//=>

	///////////////////////

	// decimal part => to string

	///////////////////////
	conv_Hex_to_3Digit_String(num_Decimal * 1000, cont);

	printf("[%d] num = %1.3f, cont = %s, "
			"num_Decimal * 1000 = %d, num_Decimal * 1000(float) = %1.3f\n",
			__LINE__, num, cont, (int)(num_Decimal * 1000), (num_Decimal * 1000));

	num_Decimal = num_Decimal * 1000;

//	num_Decimal_int = (int) (num_Decimal * 1000);
	num_Decimal_int = (int) num_Decimal;

	printf("[%d] num = %1.3f, num_Decimal_int = %d\n",
				__LINE__, num, num_Decimal_int);

	conv_Hex_to_3Digit_String(num_Decimal_int, num_Decimal_str);

	printf("[%d] num = %1.3f, num_Decimal_str = %s\n",
					__LINE__, num, num_Decimal_str);


	///////////////////////

	// build

	///////////////////////
	cont[0] = num_Int + 0x30;
	cont[1] = '.';
	cont[2] = num_Decimal_str[0];
	cont[3] = num_Decimal_str[1];
	cont[4] = num_Decimal_str[2];
	cont[5] = num_Decimal_str[3];

	printf("[%d] num = %1.3f, cont = %s\n",
						__LINE__, num, cont);

//	printf("[%d] num => %1.3f\n", __LINE__, num);	//=> 3.543
//
//	printf("[%d] num(floor) => %d\n", __LINE__, (int)floor(num));	//=> 3
////	printf("[%d] num(floor) => %1f\n", __LINE__, floor(num));
////	printf("[%d] num(floor) => %d\n", __LINE__, floor(num));
//
//	printf("[%d] num(int) => %d\n", __LINE__, (int)num);	//=>



}//conv_Float_to_String

void
conv_Hex_to_3Digit_String
(int num , char cont[4]) {

	int hunds, tens, residue;

	// 100s
	hunds = num / 100;

	residue = num - hunds * 100;

	// 10s
	tens = residue / 10;

	residue = residue - tens * 10;

	///////////////////////

	// build

	///////////////////////
	cont[0] = hunds + 0x30;
	cont[1] = tens + 0x30;
	cont[2] = residue + 0x30;
	cont[3] = '\0';

}//conv_Hex_to_3Digit_String
