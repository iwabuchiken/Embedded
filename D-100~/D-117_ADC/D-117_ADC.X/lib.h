/* 
 * File:   lib_D-108_v_2_5_2.h
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 8:15
 *
 * Dependencies:
 * 		SD1602_4bit_mode.h
 * 		font5x8.h
 *
 */

#ifndef LIB_H
#define	LIB_H

///////////////////////////////
//
// defines
//
 ///////////////////////////////
#define true	1
#define false	0

#define EQ_500MS	4500
//#define EQ_500MS	9765

#define ADCH    1
#define ADCL    0xCD

#define MAX_NUM 1023

#define NUM_OF_EXTRA_CHARS	8

#define NUM_OF_CHAR_LINES	8

///////////////////////////////
//
// includes
//
 ///////////////////////////////
#ifndef SD1602_4BIT_H
#include "SD1602_4bit_mode.h"
#endif

#ifndef _FONT5X8_H_
#include "font5x8.h"
#endif

//REF http://www9.plala.or.jp/sgwr-t/c/sec16.html
typedef unsigned int usi;

#ifdef	__cplusplus
extern "C" {
#endif

///////////////////////////////
//
// protos
//
 ///////////////////////////////
void conv_H2CC_HEX_2Digits(signed char, char[]);

char conv_H2CC_HEX(signed char c);
void conv_Hex_to_3Digit_String(int, char[4]);

void conv_ADC_to_FractionalString(int, int, float ref, char[6]);

///////////////////////////////
//
// funcs
//
 ///////////////////////////////
void register_Char() {

	///////////////////////////////
	//
	// set: address
	//
	 ///////////////////////////////
	SD1602_control(0x50);	// 01 010 000 (01010000) => code=0x02

	///////////////////////////////
	//
	// char data
	//
	///////////////////////////////
	SD1602_display(0x0F);
	SD1602_display(0x09);
	SD1602_display(0x0F);
	SD1602_display(0x09);

	SD1602_display(0x0F);
	SD1602_display(0x09);
	SD1602_display(0x11);
	SD1602_display(0x00);

	///////////////////////////////
	//
	// display
	//
	 ///////////////////////////////
//	SD1602_write(0x02, 1);

}

int registerChar
(int charCode, int charIndex) {

	///////////////////////////////
	//
	// validate
	//
	 ///////////////////////////////
	// char code
	if (charCode > NUM_OF_EXTRA_CHARS - 1) {

		return false;

	}

	// char index
	int size_Chars = sizeof(dots) / sizeof(dots[0]);

	if (charIndex > (size_Chars - 1)) {

		return false;

	}

	///////////////////////////////
	//
	// set: address
	//
	 ///////////////////////////////
	SD1602_control(0x40|(charCode << 3));	// 01 010 000 (01010000) => code=0x02
//	SD1602_control(0x50);	// 01 010 000 (01010000) => code=0x02

	///////////////////////////////
	//
	// char data
	//
	///////////////////////////////
	for (int i = 0; i < NUM_OF_CHAR_LINES; ++i) {

		SD1602_display(dots[charIndex][i]);

	}

	///////////////////////////////
	//
	// return
	//
	 ///////////////////////////////
	return true;

}//registerChar

/****************************
 * @return => null char is not added at the end
 *****************************/
void conv_H2CC_HEX_2Digits
(signed char c, char converted[]) {
//conv_Hex_to_CharCode_2Digits
//(signed char c, char[2] converted) {

//	signed char tmp_Chr;	//=> 'signed' --> 'CF7 converted to '@F'
	char tmp_Chr;

	///////////////////////

	// digit: 1

	///////////////////////
	tmp_Chr = 0x0F & c;

	converted[1] = conv_H2CC_HEX(tmp_Chr);

	///////////////////////

	// digit: 2

	///////////////////////
	tmp_Chr = 0xF0 & c;

	tmp_Chr = tmp_Chr >> 4;

	converted[0] = conv_H2CC_HEX(tmp_Chr);

}//conv_Hex_to_CharCode_2Digits

///////////////////////////////
//
// originally from: C:\WORKS\WS\Embedded\D-100~\D-110\D-110_v_1_0\D-110_v_1_0.X\D-110_v_1_0.c
//
///////////////////////////////
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


//REF char comparison QA http://forum.htsoft.com/all/showflat.php/Cat/0/Number/171462/Main/171272/
char
//conv_Hex_to_Dec(unsigned char c) {  // lib_D-108_v_2_5_2.h:21: warning: (765) degenerate unsigned comparison
//conv_Hex_to_CharCode
conv_H2CC_HEX
(signed char c) {
//conv_Hex_to_Dec(char c) {             // warning: (765) degenerate unsigned comparison

	if (c >= 0x00 && c <= 0x09) {
//	if (c >= 0 && c <= 9) {

		return 0x30 + c;
//		return 0x30 + c;

	} else if (c > 9 && c <= 0x0F){

		return 0x37 + c;	// 0x37 => dex 55
							// e.g. 0x37 + 0x0A => 0x41(dex 65)
//		return 0x31 + c;

	} else {

		return 0x40;		// '@'
//		return 0xFF;		// black rectangle

	}

}//conv_Hex_to_CharCode

void conv_ADC_to_FractionalString
(int adh, int adl, float ref, char str[6]) {

	///////////////////////////////
	//
	// get: sum
	//
	 ///////////////////////////////
	int sum = adh * 256 + adl;



}//conv_ADC_to_FractionalString

#ifdef	__cplusplus
}
#endif

#endif	/* LIB_H */

