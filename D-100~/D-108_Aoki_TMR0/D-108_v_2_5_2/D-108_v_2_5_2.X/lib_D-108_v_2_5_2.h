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

//REF char comparison QA http://forum.htsoft.com/all/showflat.php/Cat/0/Number/171462/Main/171272/
char
//conv_Hex_to_Dec(unsigned char c) {  // lib_D-108_v_2_5_2.h:21: warning: (765) degenerate unsigned comparison
conv_Hex_to_CharCode(signed char c) {
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

}//conv_Hex_to_Dec


#ifdef	__cplusplus
}
#endif

#endif	/* LIB_D_108_V_2_5_2_H */

