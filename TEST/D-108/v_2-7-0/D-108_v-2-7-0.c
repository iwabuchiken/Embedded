#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>



///////////////////////

// protos

///////////////////////
void conv_Hex_to_Decimal_String(int, char[5]);

int is_Numeric(char*);

//char[5] container;

///////////////////////

// funcs

///////////////////////
void main(int argc, char** args) {

//	char[] cont = "abcd";
//	char[5] cont;

	//REF syntax http://stackoverflow.com/questions/10365859/expected-identifier-or-before-token-and-error-expected-before answered Apr 28 '12 at 17:31
	char cont[5];

	int num = 1023;

	int res_i;

	// command line input
	if (argc > 1) {

		if (is_Numeric(args[1])) {

			num = atoi(args[1]);

		} else {

			printf("not a digit => %s\n", args[1]);

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
	printf("converted => %s\n", cont);

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
	printf("num = %d\n", num);
	printf("%d %d %d %d\n", thou, hunds, tens, residue);

	sprintf(cont, "%d%d%d%d", thou, hunds, tens, residue);

	printf("cont => %s\n", cont);

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

//void conv_Dex_to_CharCodes(int num, char container[5]) {
//
//
//}
