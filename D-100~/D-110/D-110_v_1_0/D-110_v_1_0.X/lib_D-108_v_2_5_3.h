/* 
 * File:   lib_D-108_v_2_5_2.h
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 8:15
 */

#ifndef LIB_D_108_V_2_5_2_H
#define	LIB_D_108_V_2_5_2_H

#ifdef	__cplusplus
extern "C" {
#endif

///////////////////////

// protos

///////////////////////
void conv_Dex_to_Binary(int, char[9]);

void conv_2Hex_to_String(int, int, char[5]);

void conv_Hex_to_Decimal_String(int, char[5]);

///////////////////////

// funcs

///////////////////////
//REF char comparison QA http://forum.htsoft.com/all/showflat.php/Cat/0/Number/171462/Main/171272/
char
//conv_Hex_to_Dec(unsigned char c) {  // lib_D-108_v_2_5_2.h:21: warning: (765) degenerate unsigned comparison
conv_Hex_to_CharCode
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

///////////////////////

// conv_Hex_to_CharCode_2Digits
/*	@param
 * 		converted[]: size => 2
 */
///////////////////////

void
conv_Hex_to_CharCode_2Digits
(signed char c, char converted[]) {
//(signed char c, char[2] converted) {

	char tmp_Chr;

	///////////////////////

	// digit: 1

	///////////////////////
	tmp_Chr = 0x0F & c;

	converted[1] = conv_Hex_to_CharCode(tmp_Chr);

	///////////////////////

	// digit: 2

	///////////////////////
	tmp_Chr = 0xF0 & c;

	tmp_Chr = tmp_Chr >> 4;

	converted[0] = conv_Hex_to_CharCode(tmp_Chr);

}//conv_Hex_to_CharCode_2Digits

/*
 * binary 8 bits + null char = 9 chars
 *  */
void
conv_Dex_to_Binary
(int num, char result[9]) {

	int i;
	int len = 8;

	int tmp;

//	//debug
//	printf("\n");
//	printf("[%d] start conversion...\n", __LINE__);

//	printf("\n");
//	printf("[%d] hex => %02x, dex => %d\n", __LINE__, num, num);

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
//	printf("\n");
//	printf("result => %s\n", result);
////	printf("result => %s (%x)\n", result, num);

}

/************************************
 * @param
 * 		v1	=> ADRESH
 * 		v2	=> ADRESL
 *
 * @dependencies
 * 		conv_Hex_to_Decimal_String
 *
 * @return
 * 		container	=> 4-digit number string
 * 					=> null char at the end
 ************************************/
void
conv_2Hex_to_String
(int v1, int v2, char container[5]) {

	///////////////////////

	// modify: v1

	///////////////////////
	v1 = v1 & 0x03;		// use => lower 2 bits
//	v1 = v1 && 0x03;

	///////////////////////

	// prep: sum

	///////////////////////
	int adh = v1 * 256;

	int sum = adh + v2;

	///////////////////////

	// build: string

	///////////////////////
	conv_Hex_to_Decimal_String(sum, container);

}//conv_2Hex_to_String

/*
 * @param
 * 		num	=> =< 9999
 * 1. 4-digit string
 * 2. cont	=> null char added at the end
 */
void conv_Hex_to_Decimal_String
(int num, char cont[5]) {

	///////////////////////

	// prep: numbers

	///////////////////////
	// 1000s
	int thou = num / 1000;

	int residue = num - thou * 1000;

	// 100s
	int hunds = residue / 100;

	residue = residue - hunds * 100;

	// 10s
	int tens = residue / 10;

	residue = residue - tens * 10;

	///////////////////////

	// build: string

	///////////////////////
//	sprintf(cont, "%d%d%d%d", thou, hunds, tens, residue);

	cont[0] = thou + 0x30;
	cont[1] = hunds + 0x30;
	cont[2] = tens + 0x30;
	cont[3] = residue + 0x30;
	cont[4] = '\0';

}//conv_Hex_to_Decimal_String


#ifdef	__cplusplus
}
#endif

#endif	/* LIB_D_108_V_2_5_2_H */

