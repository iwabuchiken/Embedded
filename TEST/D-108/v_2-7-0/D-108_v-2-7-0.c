#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

/*
 * printf\("(.+\\n)", (.+)\);	=> printf("[%d] $1", __LINE__, $2);
 */

///////////////////////

// protos

///////////////////////
void conv_Hex_to_Decimal_String(int, char[5]);

int is_Numeric(char*);

void conv_2Hex_to_String(int, int, char[5]);
void conv_1Hex_to_String(int, char[4]);

//char[5] container;

///////////////////////

// funcs

///////////////////////
void main(int argc, char** args) {

//	char[] cont = "abcd";
//	char[5] cont;

	//REF syntax http://stackoverflow.com/questions/10365859/expected-identifier-or-before-token-and-error-expected-before answered Apr 28 '12 at 17:31
	char cont[5];
	char cont4[4];

	int num = 1023;

	int v1, v2;

	int res_i;

	// command line input
	if (argc > 1) {

		if (is_Numeric(args[1])) {

			num = atoi(args[1]);

		} else {

			printf("[%d] not a digit => %s\n", __LINE__, args[1]);

		}

//		printf("%s\n", args[1]);
//
//		printf("%c\n", args[1][0]);
//
//		printf("isdigit => %d\n", isdigit(args[1][0]));
//
//		res_i = is_Numeric(args[1]);
//
//		printf("is_Numeric => %d\n", res_i);

//		if(isdigit(atoi(args[1][0]))) {
////		if(isdigit(args[1])) {
//
//			num = atoi(args[1]);
//
//		} else {
//
//			printf("not a digit => %s\n", args[1]);
//
//		}

	}

	conv_Hex_to_Decimal_String(num, cont);

	// report
	printf("[%d] converted => %s\n", __LINE__, cont);

	///////////////////////

	// 2 hexes

	///////////////////////
	if (argc >= 4) {

		if (is_Numeric(args[2]) && is_Numeric(args[3])) {

			v1 = atoi(args[2]);
			v2 = atoi(args[3]);

		} else {

			printf("[%d] not a digit => %s\n", __LINE__, args[1]);

			v1 = 0x03;
			v2 = 0xFF;

		}

	} else {//if (argc >= 4)

		v1 = 0x03;
		v2 = 0xFF;

	}//if (argc >= 4)

	// 2 hexes
//	v1 = 0x07;
//	v1 = 0x03;
//	v2 = 0xFF;

	conv_2Hex_to_String(v1, v2, cont);

	printf("[%d] 2 hexes converted: %02x, %02x => %s\n", __LINE__, v1, v2, cont);

	///////////////////////

	// 1 hex

	///////////////////////
	conv_1Hex_to_String(v2, cont4);

	printf("[%d] 1 hex converted: %02x => %s\n", __LINE__, v2, cont4);

    return;

}

void conv_Hex_to_Decimal_String
(int num, char cont[5]) {

	// 1000s
	int thou = num / 1000;

	int residue = num - thou * 1000;

	// 100s
	int hunds = residue / 100;

	residue = residue - hunds * 100;

	// 10s
	int tens = residue / 10;

	residue = residue - tens * 10;

	// display
	printf("[%d] num = %d\n", __LINE__, num);
	printf("[%d] %d %d %d %d\n", __LINE__, thou, hunds, tens, residue);

	sprintf(cont, "%d%d%d%d", thou, hunds, tens, residue);

	printf("[%d] cont => %s\n", __LINE__, cont);

	// convert


}//conv_Hex_to_Decimal_String

/*
 * @param
 * 		num => < 256, >= 0
 */
void conv_1Hex_to_String
(int num, char cont[4]) {

	// 100s
	int hunds = num / 100;

	int residue = num - hunds * 100;

	// 10s
	int tens = residue / 10;

	residue = residue - tens * 10;

	// display
	printf("[%d] num = %d\n", __LINE__, num);

//	sprintf(cont, "%d%d%d", hunds, tens, residue);

	cont[0] = hunds + 0x30;
	cont[1] = tens + 0x30;
	cont[2] = residue + 0x30;

	cont[3] = '\0';

	printf("[%d] cont => %s\n", __LINE__, cont);

	// convert


}//conv_Hex_to_Decimal_String

int is_Numeric(char* value) {

	while(*value != '\0') {

		if(!isdigit(*value)) {

			return 0;

		}

		value ++;

	}

	return 1;

}

/*
 * @param
 * 		v1	=> ADRESH
 * 		v2	=> ADRESL
 *
 * @dependencies
 * 		conv_Hex_to_Decimal_String
 *
 */
void
conv_2Hex_to_String
(int v1, int v2, char container[5]) {

	printf("[%d] v1 = %d\n", __LINE__, v1);

	v1 = v1 & 0x03;
//	v1 = v1 && 0x03;

	printf("[%d] v1(& 0x03) = %d\n", __LINE__, v1);

	int adh = v1 * 256;

	int sum = adh + v2;

	conv_Hex_to_Decimal_String(sum, container);

	printf("[%d] conv_2Hex_to_String => done\n", __LINE__);

}//conv_2Hex_to_String

//void conv_Dex_to_CharCodes(int num, char container[5]) {
//
//
//}
