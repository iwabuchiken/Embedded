#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <math.h>

///////////////////////

// protos

///////////////////////
void _conv_ADC_to_FS__LessThan10(int, char[6]);

void _conv_ADC_to_FS__EqualOrMoreThan10(int, char[6]);

///////////////////////////////
//
// vars
//
 ///////////////////////////////
char title[] = "D-117 v-2.0";

///////////////////////

// funcs

///////////////////////
void _conv_ADC_to_FS__LessThan10(int n, char str[6]) {



}

void conv_ADC_to_FractionalString
(int adh, int adl, float ref, char str[6]) {

	///////////////////////////////
	//
	// get: sum
	//
	 ///////////////////////////////
	int sum = adh * 256 + adl;

	float n = ref * (sum / (float) 1024);

	printf("adh = %d / adl = %d / sum = %d / ref = %f / n => %f\n",
				adh, adl, sum, ref, n);

	///////////////////////////////
	//
	// dispatch
	//
	 ///////////////////////////////
	if (n < 10) {

		_conv_ADC_to_FS__LessThan10(n, str);

	} else {

		_conv_ADC_to_FS__EqualOrMoreThan10(n, str);

	}



}

void main(int argc, char** args) {

	printf("title = %s\n", title);

	char str[6];

	int adh = 0x02, adl = 0xCC;

	conv_ADC_to_FractionalString(adh, adl, 5.0, str);

	return;

}

