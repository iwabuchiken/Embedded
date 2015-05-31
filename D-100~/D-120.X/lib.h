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
//#ifndef SD1602_4BIT_H
//#include "SD1602_4bit_mode.h"
//#endif
//
//#ifndef _FONT5X8_H_
//#include "font5x8.h"
//#endif

//REF http://www9.plala.or.jp/sgwr-t/c/sec16.html
typedef unsigned int usi;

#ifdef	__cplusplus
extern "C" {
#endif

///////////////////////////////
//
// protos
//
#ifdef	__cplusplus
}
#endif

#endif	/* LIB_H */

