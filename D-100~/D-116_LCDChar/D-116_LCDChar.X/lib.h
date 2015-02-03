/* 
 * File:   lib_D-108_v_2_5_2.h
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 8:15
 */

#ifndef LIB_H
#define	LIB_H

#define true	1
#define false	0

#define EQ_500MS	4500
//#define EQ_500MS	9765

#define ADCH    1
#define ADCL    0xCD

#define MAX_NUM 1023

#ifndef SD1602_4BIT_H
#include "SD1602_4bit_mode.h"
#endif


//REF http://www9.plala.or.jp/sgwr-t/c/sec16.html
typedef unsigned int usi;

#ifdef	__cplusplus
extern "C" {
#endif

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


#ifdef	__cplusplus
}
#endif

#endif	/* LIB_H */

