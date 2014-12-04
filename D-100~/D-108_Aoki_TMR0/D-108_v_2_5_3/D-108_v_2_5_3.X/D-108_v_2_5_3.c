/*
 * File:   D-108_v_2_5_3.c
 * Author: iwabuchik
 *
 * Created on 2014/11/21, 16:02
 */


#include <xc.h>
#include <stdio.h>
//#include <string.h>

#include "SD1602_4bit_mode.h"
#include "debug.h"

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#ifndef LIB_D_108_V_2_5_3_H
#include "lib_D-108_V_2_5_3.h"
#endif

/*
 * lib_D-108_V_2_5_3.h
 *
 * 		conv_Dex_to_Binary
 */

#define true	1
#define false	0

#define EQ_500MS	4500
//#define EQ_500MS	9765


// PIC16F88 Configuration Bit Settings

// 'C' source line config statements

#include <xc.h>

// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

// CONFIG1
#pragma config FOSC = HS        // Oscillator Selection bits (HS oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = ON       // Power-up Timer Enable bit (PWRT enabled)
#pragma config MCLRE = ON       // RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is MCLR)
#pragma config BOREN = ON       // Brown-out Reset Enable bit (BOR enabled)
//#pragma config BODEN = ON       // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF         // Low-Voltage Programming Enable bit (RB3/PGM pin has PGM function, Low-Voltage Programming enabled)
#pragma config CPD = OFF        // Data EE Memory Code Protection bit (Code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off)
//#pragma config CCPMX = RB0      // CCP1 Pin Selection bit (CCP1 function on RB0)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)
#pragma config DEBUG = OFF         // Flash Program Memory Code Protection bit (Code protection off)

//// CONFIG2
//#pragma config FCMEN = ON       // Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor enabled)
//#pragma config IESO = ON        // Internal External Switchover bit (Internal External Switchover mode enabled)

//#pragma config FOSC = HS
//#pragma config WDTE = OFF
//#pragma config PWRTE = ON
//#pragma config CP = OFF



///////////////////////

// protos

///////////////////////
void _Setup(void);
//void _Setup_Interrupt(void);
void _Setup_Timer(void);

void _Display(void);
void _Display__Hex(int);
void _Display__Hex_3Items(int);

//void _While(void);
//void _Init_Vars(void);
static void interrupt intr(void);
void intr__TMR(void);
void intr__INT(void);

void conv_1Hex_to_String(int, char[4]);

////debug
//void pulse_250ms(unsigned int);
//void pulse_100ms(unsigned int);
//
//void pulse_250ms_RB2(unsigned int);
//void pulse_100ms_RB2(unsigned int);

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
char binary_display_16[17];	// 16 chars + 1 null char = 17

char msg_1[]  = "D-108 v-2.6.1";
char msg_2[]  = "You clicked it!";

char msg_Hex_2Digit[3];	// 2-digit hex
						// length is 3 => 2 digits and '0' char

unsigned int flag_Intr = false;

unsigned int count;

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	count = 0;

	pulse_250ms(3);

	_Setup_Timer();

	pulse_250ms_RB2(3);

	///////////////////////

	// LCD-related

	///////////////////////
	SD1602_init_2();	// init LCD

	pulse_250ms(2);

	_Display();

	pulse_250ms_RB2(2);

	///////////////////////

	// while

	///////////////////////
	while(1) {

		if (flag_Intr == true) {

//			hex ++;

			hex = TMR0;

//			_Display__Hex(hex);
			_Display__Hex_3Items(hex);

			flag_Intr = false;

		}
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

//void _Setup_Interrupt(void) {
//
//	///////////////////////
//
//	// OPTION: : INT
//
//	///////////////////////
//	OPTION_REG &= 0x7F;		// pull-up --> ON
////	OPTION_REG &= 0X7F;		// pull-up --> ON
//	OPTION_REG &= 0xBF;		// INT intr --> 5V ~> 0V
//
//	///////////////////////
//
//	// OPTION: TMR
//
//	///////////////////////
//	OPTION_REG &= 0xDF;	// timer by clock
//
//
//	//debug
//	pulse_100ms_RB2(3);
//
////	INTCON |= 0x80;		// permit: intr
//
//	TMR0 = 0;
//
////	//debug
////	pulse_100ms(2);
//
//	///////////////////////
//
//
//	// INTCON
//
//	///////////////////////
//	INTCON |= 0x20;		// permit: timer intr
//
//	//debug
//	pulse_100ms(2);         // working
//
//	INTCON |= 0x10;		// permit: INT intr
//
//	//debug
//	pulse_100ms_RB2(1);
//
//	INTCON |= 0x80;		// permit: intr
//
//	//debug
//	pulse_100ms(1);         // n/w
//
//}

void
_Setup_Timer(void) {

	OPTION_REG &= 0x7F;	// pull-up --> ON

	OPTION_REG &= 0xDF;	// timer by clock
	OPTION_REG &= 0xBF;		// INT intr --> 5V ~> 0V

	TMR0 = 0;

	INTCON |= 0x10;		// permit: INT intr
	INTCON |= 0x20;		// permit: timer intr

	INTCON |= 0x80;		// permit: intr

}//_Setup_Timer


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

	pulse_100ms(3);

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

/*
 * 3 items
 * 		=> hex, binary, decimal
 */
void _Display__Hex_3Items(int num) {

	char temp_4[4];

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

	for (i = 3; i < 12; i ++) {
//	for (i = 0; i < 12; i ++) {

		binary_display_16[i] = binary[i];
//		binary_display_16[3 + i] = binary[i];

	}

	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);

	binary_display_16[0] = msg_Hex_2Digit[0];
	binary_display_16[1] = msg_Hex_2Digit[1];
	binary_display_16[2] = ' ';

	///////////////////////

	// decimal chars

	///////////////////////
	conv_1Hex_to_String(num, temp_4);

	binary_display_16[12] = temp_4[0];
	binary_display_16[13] = temp_4[1];
	binary_display_16[14] = temp_4[2];
	binary_display_16[15] = temp_4[3];


	SD1602_print(binary_display_16);
//	SD1602_print(binary_display);

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

	///////////////////////

	// prohibit: further interruption

	///////////////////////
	INTCON &= 0x7F;		// prohibit: intr			// 0111 1111

	if (INTCONbits.TMR0IF == 1) {

		intr__TMR();

//		INTCON &= 0xDF;		// prohibit: timer intr		// 1101 1111
//		INTCON &= 0xFB;		// clear: timer intr flag	// 1111 1011
//
//		///////////////////////
//
//		// ops
//
//		///////////////////////
//		count ++;
//
//		if (count == EQ_500MS) {
//
//			PORTBbits.RB3 ^= 1;
//
//			count = 0;
//
//		}

	} else if (INTCONbits.INT0IF == 1) {

		intr__INT();

	} else {

	}

//	INTCON &= 0xDF;		// prohibit: timer intr		// 1101 1111
//	INTCON &= 0xFB;		// clear: timer intr flag	// 1111 1011

//	INTCON &= 0xEF;		// prohibit: INT intr		// 1110 1111
//	INTCON &= 0xFD;		// clear: INT intr flag		// 1111 1101

        

//	///////////////////////
//
//	// ops
//
//	///////////////////////
//	count ++;
//
//	if (count == EQ_500MS) {
//
//		PORTBbits.RB3 ^= 1;
//
//		count = 0;
//
//	}

//	if (TMR0 == 255) {

//		PORTBbits.RB3 ^= 1;
//
////	PORTBbits.RB3 = 1;
//
//	__delay_us(200);
//
//	PORTBbits.RB3 ^= 1;

//	PORTBbits.RB3 = 0;

//	}

	///////////////////////

	// resume: interrupt

	///////////////////////
	INTCON |= 0x10;		// allow: INT intr
	INTCON |= 0x20;		// allow: timer intr

	INTCON |= 0x80;		// allow: intr

}//interrupt intr()

void
intr__TMR(void) {

	INTCON &= 0xDF;		// prohibit: timer intr		// 1101 1111
	INTCON &= 0xFB;		// clear: timer intr flag	// 1111 1011

	///////////////////////

	// ops

	///////////////////////
	count ++;

	if (count == EQ_500MS) {

		PORTBbits.RB3 ^= 1;

		count = 0;

	}

}//intr__TMR

void
intr__INT(void) {

	INTCON &= 0xEF;		// prohibit: INT intr		// 1110 1111
	INTCON &= 0xFD;		// clear: INT intr flag		// 1111 1101

	PORTBbits.RB3 = 0;

	__delay_ms(500);

	flag_Intr = true;

//	hex ++;
//
//	_Display__Hex(hex);

}

/*
 * @param
 * 		num => < 256, >= 0
 */
void conv_1Hex_to_String
(int num, char cont[4]) {

	// 100s
	int hunds = num / 100;

	int residue = num - hunds * 100;

	// 10s
	int tens = residue / 10;

	residue = residue - tens * 10;

//	// display
//	printf("[%d] num = %d\n", __LINE__, num);

	sprintf(cont, "%d%d%d", hunds, tens, residue);

//	printf("[%d] cont => %s\n", __LINE__, cont);

}//conv_Hex_to_Decimal_String


//
//void pulse_250ms(unsigned int num) {
//
//	int i;
//
//	for (i = 0; i < num; i ++) {
//
//		PORTBbits.RB1 = 1;
//
//		__delay_ms(250);
//
//		PORTBbits.RB1 = 0;
//
//		__delay_ms(250);
//
//	}
//
//}
//
//void pulse_250ms_RB2(unsigned int num) {
//
//	int i;
//
//	for (i = 0; i < num; i ++) {
//
//		PORTBbits.RB2 = 1;
//
//		__delay_ms(250);
//
//		PORTBbits.RB2 = 0;
//
//		__delay_ms(250);
//
//	}
//
//}
//
//void pulse_100ms(unsigned int num) {
//
//	int i;
//
//	for (i = 0; i < num; i ++) {
//
//		PORTBbits.RB1 = 1;
//
//		__delay_ms(100);
//
//		PORTBbits.RB1 = 0;
//
//		__delay_ms(100);
//
//	}
//
//}
//
//void pulse_100ms_RB2(unsigned int num) {
//
//	int i;
//
//	for (i = 0; i < num; i ++) {
//
//		PORTBbits.RB2 = 1;
//
//		__delay_ms(100);
//
//		PORTBbits.RB2 = 0;
//
//		__delay_ms(100);
//
//	}
//
//}
//
