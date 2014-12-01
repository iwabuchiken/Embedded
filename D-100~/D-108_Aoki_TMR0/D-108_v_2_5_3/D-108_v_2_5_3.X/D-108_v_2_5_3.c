/*
 * File:   D-108_v_2_5_3.c
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 16:02
 */


#include <xc.h>

#include "SD1602_4bit_mode.h"

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#ifndef LIB_D_108_V_2_5_3_H
#include "lib_D-108_V_2_5_3.h"
#endif

#define true	1
#define false	0

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

///////////////////////

// protos

///////////////////////
void _Setup(void);
void _Setup_Interrupt(void);
void _Setup_Timer(void);

void _Display(void);
void _Display__Hex(int);

void _While(void);
void _Init_Vars(void);
static void interrupt intr(void);

void pulse_250ms(unsigned int);
void pulse_250ms_RB2(unsigned int);
void pulse_100ms_RB2(unsigned int);

///////////////////////

// vars

///////////////////////
unsigned int msg_num = 0;	// message number
						// 0 => version; 1 => greeting

unsigned int msg_Len;

unsigned int i;			// index for iterator

int hex = 0xCC;

char s[20];

char binary[9];
char binary_display[12];

char msg_1[]  = "D-108 v-2.6.0";
char msg_2[]  = "You clicked it!";

char msg_Hex_2Digit[3];	// 2-digit hex
						// length is 3 => 2 digits and '0' char

unsigned int flag_Intr = false;

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	_Setup_Interrupt();
//	_Setup_Interrupt;

	pulse_250ms_RB2(3);
//	pulse_250ms(3);

	_Setup_Timer();

//	pulse_250ms_RB2(2);

	_Init_Vars();		// init variables

	SD1602_init_2();	// init LCD

//	pulse_250ms(3);

	///////////////////////

	// display string

	///////////////////////
	_Display();

        //REF STATUS bits http://www.picfun.com/pic18/mcc10.html "IPR1bits.TMR1IP=0;"
//        STATUSbits.C;

	while(1) {

		if (flag_Intr == true) {

			pulse_250ms(2);

			hex ++;

//			_Display__Hex(TMR0);
			_Display__Hex(hex);
//			_Display__Hex(0xDD);
                        
			///////////////////////

			// flag => resetb

			///////////////////////
			flag_Intr = false;

		}

//		_While();

	}

    return;
}

void _Setup(void) {

    /****************
     * OPTION_REG
     ****************/
     OPTION_REGbits.nRBPU = 0;

    /****************
     * TRIS
     ****************/
    TRISB = 0b00000001;		// RB0 => input
    TRISA = 0x00;

    /****************
     * PORT
     ****************/
    PORTA = 0x00;
    PORTB = 0x00;

    /****************
     * ANSEL
     ****************/
    ANSEL = 0x00;

//    ///////////////////////
//
//	// vars
//
//	///////////////////////
//    msg_num = 0;

}//_Setup

void _Setup_Interrupt(void) {

	OPTION_REG &= 0x7F;		// pull-up --> ON
//	OPTION_REG &= 0X7F;		// pull-up --> ON
	OPTION_REG &= 0xBF;		// INT intr --> 5V ~> 0V

	INTCON |= 0x10;		// permit: INT intr
	INTCON |= 0x80;		// permit: intr

}

void _Setup_Timer(void) {

	//debug
	pulse_250ms(2);

	OPTION_REG &= 0xDF;	// timer by clock

	//debug
	pulse_100ms_RB2(3);

	INTCON |= 0x20;		// permit: timer intr
//	INTCON |= 0x80;		// permit: intr

	TMR0 = 0;

}

void
_Display(void) {

//	strcpy(s, msg_1);

	///////////////////////

	// line: 1

	///////////////////////
	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

	SD1602_print(msg_1);

	///////////////////////

	// line: 2

	///////////////////////
	SD1602_control(0xC0);	// Cursor => second line
							// Exec time => 40 us

	conv_Dex_to_Binary(hex, binary);

	for (i = 0; i < 12; i ++) {

		binary_display[3 + i] = binary[i];

	}

	conv_Hex_to_CharCode_2Digits(hex, msg_Hex_2Digit);

	binary_display[0] = msg_Hex_2Digit[0];
	binary_display[1] = msg_Hex_2Digit[1];
	binary_display[2] = ' ';

	SD1602_print(binary_display);

}//_Display

void _Display__Hex(int num) {

//	strcpy(s, msg_1);

	///////////////////////

	// clear: display

	///////////////////////
	SD1602_clear();

	///////////////////////

	// line: 1

	///////////////////////
	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

	SD1602_print(msg_2);

	///////////////////////

	// line: 2

	///////////////////////
	SD1602_control(0xC0);	// Cursor => second line
							// Exec time => 40 us

	conv_Dex_to_Binary(num, binary);

	for (i = 0; i < 12; i ++) {

		binary_display[3 + i] = binary[i];

	}

	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);

	binary_display[0] = msg_Hex_2Digit[0];
	binary_display[1] = msg_Hex_2Digit[1];
	binary_display[2] = ' ';

	SD1602_print(binary_display);

}//_Display

void
_While(void) {

	if (PORTBbits.RB1 == 1) {

		if(msg_num != 1) {

			SD1602_control(0x01);	// LCD => clear

			__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

			SD1602_control(0x02);	// Cursor => at home
									// Exec time => 1.64 ms

			__delay_ms(2);

//
//                        strcpy(s, msg_2);

			SD1602_print(s);

			// set message number
			msg_num = 1;

		}

		PORTBbits.RB0 = 1;

	} else {

		if(msg_num != 0) {

			SD1602_control(0x01);	// LCD => clear

			__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

			SD1602_control(0x02);	// Cursor => at home
									// Exec time => 1.64 ms

			__delay_ms(2);

//			strcpy(s, msg_1);

			SD1602_print(s);

			// set message number
			msg_num = 0;

		}

		PORTBbits.RB0 = 0;

	}//if (PORTBbits.RB1 == 1)

}//_While

void
_Init_Vars(void) {

    ///////////////////////

	// vars

	///////////////////////
    msg_num = 0;

}

static void
interrupt intr() {

//	hex = 0xBF;

	///////////////////////

	// prohibit: further interruption

	///////////////////////
	INTCON &= 0X7F;		// prohibit: intr
	INTCON &= 0XEF;		// prohibit: INT intr
	INTCON &= 0XFD;		// clear: INT intr flag

	INTCON &= 0xDF;		// prohibit: timer intr
	INTCON &= 0xFB;		// clear: timer intr flag


	///////////////////////

	// delay: against chattering

	///////////////////////
	__delay_ms(20);

	///////////////////////

	// ops

	///////////////////////
	flag_Intr = true;

//	pulse_250ms(3);

//	PORTBbits.RB1 = 0;
//	PORTBbits.RB1 = 1;
//
//	__delay_ms(500);
//
//	PORTBbits.RB1 = 0;

	///////////////////////

	// anti-chattering

	///////////////////////
	INTCON &= 0XFD;		// clear: INT intr flag

        
//	///////////////////////
//
//	// display
//
//	///////////////////////
//	///////////////////////
//
//	// clear: display
//
//	///////////////////////
//	SD1602_clear();
//
//	///////////////////////
//
//	// line: 1
//
//	///////////////////////
//	SD1602_control(0x02);	// Cursor => at home
//							// Exec time => 1.64 ms
//
//	__delay_ms(2);
//
//	SD1602_print(msg_2);


//	_Display__Hex(hex);		// D-108_v_2_5_3.c:66: warning: (1393) possible hardware stack overflow detected, estimated stack depth: 9
//	_Display__Hex(0xBF);	// D-108_v_2_5_3.c:180: error: (269) inconsistent type

	///////////////////////

	// resume: interrupt

	///////////////////////
	INTCON |= 0x10;		// allow: INT intr
	INTCON |= 0x80;		// allow: intr

	INTCON |= 0x20;		// allow: timer intr

}//interrupt intr()

void pulse_250ms(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB1 = 1;

		__delay_ms(250);

		PORTBbits.RB1 = 0;

		__delay_ms(250);

	}

}

void pulse_250ms_RB2(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB2 = 1;

		__delay_ms(250);

		PORTBbits.RB2 = 0;

		__delay_ms(250);

	}

}

void pulse_100ms_RB2(unsigned int num) {

	int i;

	for (i = 0; i < num; i ++) {

		PORTBbits.RB2 = 1;

		__delay_ms(100);

		PORTBbits.RB2 = 0;

		__delay_ms(100);

	}

}
