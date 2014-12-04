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

void conv_Dex_to_Binary(int, char[9]);

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
 */
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


#ifdef	__cplusplus
}
#endif

#endif	/* LIB_D_108_V_2_5_2_H */

