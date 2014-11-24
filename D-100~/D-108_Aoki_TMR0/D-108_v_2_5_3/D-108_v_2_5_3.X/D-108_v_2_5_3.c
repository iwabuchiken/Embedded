/*
 * File:   D-108_v_2_5_3.c
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 16:02
 */


#include <xc.h>

//#include <string.h>

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

void _Setup(void);
void _Display(void);
void _While(void);
void _Init_Vars(void);

unsigned int msg_num = 0;	// message number
						// 0 => version; 1 => greeting

unsigned int msg_Len;

unsigned int i;			// index for iterator

int hex = 0x3E;
//int hex = 0xC6;

char s[20];

char binary[9];
char binary_display[12];

char msg_1[]  = "D-108 v-2.5.3b-1";
char msg_2[]  = "You clicked it!";

char msg_Hex[] = "2CF";
//char msg_Hex[] = "0CF";
//const char msg_Hex[] = "0CF";
char msg_Hex_2Digit[3];	// 2-digit hex
						// length is 3 => 2 digits and '0' char

void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	_Init_Vars();		// init variables

	SD1602_init_2();	// init LCD

	///////////////////////

	// display string

	///////////////////////
	_Display();

        //REF STATUS bits http://www.picfun.com/pic18/mcc10.html "IPR1bits.TMR1IP=0;"
//        STATUSbits.C;

	while(1) {

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
     * TRISB
     ****************/
    TRISB = 0b00000010;		// RB1 => input
//    TRISB = 0x00;
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

void
_Display(void) {

//	strcpy(s, msg_1);
//	strcpy(s, "D-108 v-2.5.1a");
//	char s[]  = "D-108 v-2.5.0a";

//	_Setup();

//	SD1602_init_2();

	///////////////////////

	// line: 1

	///////////////////////
	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

//	SD1602_print(&msg_Hex);
//	SD1602_print(msg_Hex);
	SD1602_print(msg_1);

	///////////////////////

	// line: 2

	///////////////////////
//	msg_Len = sizeof(msg_Hex) / sizeof(msg_Hex[0]);

//	// conversion
//	for(i = 0; i < msg_Len - 1; i++) {
////	for(i = 0; i < msg_Len; i++) {
//
//		msg_Hex[i] = conv_Hex_to_CharCode(msg_Hex[i]);
//
//	}

//	msg_Hex[0] = conv_Hex_to_CharCode(0x0A);
//	msg_Hex[1] = conv_Hex_to_CharCode(0x01);
//	msg_Hex[2] = conv_Hex_to_CharCode(0x0F);

//	conv_Hex_to_CharCode_2Digits(0xAF, msg_Hex_2Digit);

//	msg_Hex_2Digit[2] = 0x00;

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
//	SD1602_print(binary);
//	SD1602_print(msg_Hex_2Digit);
//	SD1602_print(msg_Hex);


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
