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

//#ifndef MAIN_H
//#include "main.h"
//#endif

#ifndef DISP_V_1_H
#include "disp_v_1.h"
#endif


//#include "lib_v_1.h"

#ifndef LIB_D_108_V_2_5_3_H
#include "lib_v_1.h"
#endif

//#ifndef DISP_V_1_H
//#include "disp_v_1.h"
//#endif


/*
 * lib_D-108_V_2_5_3.h
 *
 * 		conv_Dex_to_Binary
 */

//#define true	1
//#define false	0
//
//#define EQ_500MS	4500
////#define EQ_500MS	9765
//
//#define ADCH    1
//#define ADCL    0xCD
//
//#define MAX_NUM 1023

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
void _Setup_ANSEL(void);

//void _Display(void);
void _Display__Hex(int);
void _Display__Hex_3Items(int);
void _Display__Hex_2Items(int);

void _While(void);

//void _Init_Vars(void);
static void interrupt intr(void);
void intr__TMR(void);
void intr__INT(void);

//void conv_1Hex_to_String(int, char[4]);

void get_ADC_Values(void);

void _Display__ADC_Fractional(void);

//void conv_Float_to_String(float, char[6]);

//void conv_ADC_to_FloatString
//(int, int, double, char[6]);

//void conv_Hex_to_3Digit_String(int, char[4]);	// 3 digits + null char = 4

////debug
//void pulse_250ms(unsigned int);
//void pulse_100ms(unsigned int);
//
//void pulse_250ms_RB2(unsigned int);
//void pulse_100ms_RB2(unsigned int);

///////////////////////

// vars

///////////////////////
//unsigned int msg_num = 0;	// message number
//						// 0 => version; 1 => greeting
//
//unsigned int msg_Len;
//unsigned int i;			// index for iterator
//unsigned int flag_Intr = false;
//unsigned int count;

//int adcH = ADCH, adcL = ADCL, hex = ADCL;
//
//char s[20];
//
//double ref = 5.0;

//char binary[9];
//char binary_display[12];
//char binary_display_16[17];	// 16 chars + 1 null char = 17
//char binary_display_8[9];	// "3FF 1023" (8 chars + null char)
//char binary_display_9[10];	// "1DC 1.245\0" (9 chars + null char)
//
//char temp_4[4];				// 3-bit decimal number
//char temp_5[5];				// 4-digit number string => ADRESH, ADRESL
//
//char msg_Project_Name[]  = "D-111 v-1.0";
//char msg_2[]  = "INT!";
//
//char msg_Hex_2Digit[3];	// 2-digit hex
//						// length is 3 => 2 digits and '0' char

//unsigned int flag_Intr = false;
//
//unsigned int count;

//int hunds, tens, residue;

//int adcH = ADCH, adcL = ADCL, hex = ADCL;
//int adcL = ADCL;

//int hex = ADCL;
//int adcH = 1;
//int adcL = 0xCD;
//
//int hex = adcL;

//double ref = 5.0;

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	_Setup_ANSEL();

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

		_While();

//		if (flag_Intr == true) {
//
////			hex ++;
//
////			hex = TMR0;
//
//			adcL ++;
//
//			hex = adcL;
//
////			_Display__Hex(hex);
////			_Display__Hex_3Items(hex);
//			_Display__Hex_2Items(hex);
//
//			flag_Intr = false;
//
//		}
	}//while(1)

    return;
}

void
_Setup_ANSEL(void) {

	//REF http://homepage3.nifty.com/mitt/pic/pic88_3.html
	/****************
	 * ANSEL
	 ****************/
	ADCON0 = 0x99;	// 1001 1001
					// Bit 5-3: CHS2-0
					// Bit 2: GO/^DONE

	ADCON1 = 0x80;	// 1000 0000
					// Bit 8: ADFM => 1: right-aligned
					// Bits 5-4: VCFG => 00: Vref+ = Vdd, Vref- = Vss

	ANSEL = 0x08;	// 0000 1000
					// AN3 => ADC

}//_Setup_ANSEL

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

//    /****************
//     * ANSEL
//     ****************/
//    ANSEL = 0x00;

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


//void
//_Display(void) {
//
////	strcpy(s, msg_1);
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
//	SD1602_print(msg_Project_Name);
//
//	pulse_100ms(3);
//
//	///////////////////////
//
//	// line: 2
//
//	///////////////////////
//	SD1602_control(0xC0);	// Cursor => second line
//							// Exec time => 40 us
//
//	conv_Dex_to_Binary(hex, binary);
//
//	for (i = 0; i < 12; i ++) {
//
//		binary_display[3 + i] = binary[i];
//
//	}
//
//	conv_Hex_to_CharCode_2Digits(hex, msg_Hex_2Digit);
//
//	binary_display[0] = msg_Hex_2Digit[0];
//	binary_display[1] = msg_Hex_2Digit[1];
//	binary_display[2] = ' ';
//
//	SD1602_print(binary_display);
//
//}//_Display

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
void
_Display__Hex_3Items
(int num) {

//	char temp_4[4];

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

	for (i = 0; i < 9; i ++) {
//	for (i = 3; i < 12; i ++) {
//	for (i = 0; i < 12; i ++) {

//		binary_display_16[i] = binary[i];
		binary_display_16[3 + i] = binary[i];

	}

	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);

	binary_display_16[0] = msg_Hex_2Digit[0];
	binary_display_16[1] = msg_Hex_2Digit[1];
	binary_display_16[2] = '-';
//	binary_display_16[2] = ' ';

	///////////////////////

	// decimal chars

	///////////////////////
	conv_1Hex_to_String(num, temp_4);

	binary_display_16[11] = ' ';	// remove the null char

//	binary_display_16[12] = 'a';
//	binary_display_16[13] = 'b';
//	binary_display_16[14] = 'c';
//	binary_display_16[15] = '\0';
	binary_display_16[12] = temp_4[0];
	binary_display_16[13] = temp_4[1];
	binary_display_16[14] = temp_4[2];
	binary_display_16[15] = temp_4[3];


	SD1602_print(binary_display_16);
//	SD1602_print(binary_display);

}//_Display__Hex_3Items

/*
 * 2 items
 * 		=> hex, decimal
 */
void
_Display__Hex_2Items
(int num) {

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

//	conv_Dex_to_Binary(num, binary);
//
//	for (i = 0; i < 9; i ++) {
////	for (i = 3; i < 12; i ++) {
////	for (i = 0; i < 12; i ++) {
//
////		binary_display_16[i] = binary[i];
//		binary_display_16[3 + i] = binary[i];
//
//	}

	conv_Hex_to_CharCode_2Digits(adcL, msg_Hex_2Digit);
//	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);

	binary_display_8[0] = adcH + 0x30;
	binary_display_8[1] = msg_Hex_2Digit[0];
	binary_display_8[2] = msg_Hex_2Digit[1];

	///////////////////////

	// decimal chars

	///////////////////////
//	conv_1Hex_to_String(num, temp_4);
	conv_2Hex_to_String(adcH, adcL, temp_5);
//	conv_2Hex_to_String(adcH, num, temp_5);

	binary_display_8[3] = ' ';

	binary_display_8[4] = temp_5[0];
	binary_display_8[5] = temp_5[1];
	binary_display_8[6] = temp_5[2];
	binary_display_8[7] = temp_5[3];
	binary_display_8[8] = temp_5[4];	// '\0'

	SD1602_print(binary_display_8);
//	SD1602_print(binary_display);

}//_Display__Hex_3Items

/*
 * 2 items
 * 		=> hex, decimal
 */

void
_Display__ADC_Fractional() {

	char temp[6];

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

//	conv_Dex_to_Binary(num, binary);
//
//	for (i = 0; i < 9; i ++) {
////	for (i = 3; i < 12; i ++) {
////	for (i = 0; i < 12; i ++) {
//
////		binary_display_16[i] = binary[i];
//		binary_display_16[3 + i] = binary[i];
//
//	}

	conv_Hex_to_CharCode_2Digits(adcL, msg_Hex_2Digit);
//	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);

	binary_display_9[0] = adcH + 0x30;
	binary_display_9[1] = msg_Hex_2Digit[0];
	binary_display_9[2] = msg_Hex_2Digit[1];

	///////////////////////

	// decimal chars

	///////////////////////
//	conv_2Hex_to_String(adcH, adcL, temp_5);
	conv_ADC_to_FloatString(adcH, adcL, ref, temp);

	binary_display_9[3] = ' ';

	binary_display_9[4] = temp[0];
	binary_display_9[5] = temp[1];
	binary_display_9[6] = temp[2];
	binary_display_9[7] = temp[3];
	binary_display_9[8] = temp[4];	// '\0'
	binary_display_9[9] = temp[5];	// '\0'

	SD1602_print(binary_display_9);
//	SD1602_print(binary_display);

}//_Display__ADC_Fractional


void
_While(void) {

//	if (flag_Intr == true) {
//
////			hex ++;
//
////			hex = TMR0;
//
////		adcL ++;
//
//		hex ++;
//
////		hex = adcL;
//
//		///////////////////////
//
//		// ADC
//
//		///////////////////////
//		get_ADC_Values();
//
//		///////////////////////
//
//		// display
//
//		///////////////////////
////			_Display__Hex(hex);
////			_Display__Hex_3Items(hex);
////		_Display__Hex_2Items(hex);
//		_Display__ADC_Fractional();
//
//		///////////////////////
//
//		// reset: flag
//
//		///////////////////////
//		flag_Intr = false;
//
//	}//if (flag_Intr == true)

	///////////////////////

	// flag: clicked

	///////////////////////
	if (f_Clicked == true) {

		if (st_Stopwatch == 1) {

			_While__Clicked(1);		// lib_v_1.h

		} else if (st_Stopwatch == -1) {

			_While__Clicked(-1);		// lib_v_1.h

		} else {

		}

		f_Clicked = false;

	}
//	_While__Clicked();

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

	///////////////////////

	// flag: f_Clicked

	///////////////////////
//	if (f_Clicked == true) {
//
//		f_Clicked = false;
//
//	} else {

		f_Clicked = true;

//	}

//	hex ++;
//
//	_Display__Hex(hex);

}

///*
// * @param
// * 		num => < 256, >= 0
// */
//void conv_1Hex_to_String
//(int num, char cont[4]) {
//
//	// 100s
//	hunds = num / 100;
//
//	residue = num - hunds * 100;
//
//	// 10s
//	tens = residue / 10;
//
//	residue = residue - tens * 10;
//
////	// display
////	printf("[%d] num = %d\n", __LINE__, num);
//
////	sprintf(cont, "%d%d%d", hunds, tens, residue);
//
////	cont[0] = 'x';
////	cont[1] = 'y';
////	cont[2] = 'z';
//
//	cont[0] = hunds + 0x30;
//	cont[1] = tens + 0x30;
//	cont[2] = residue + 0x30;
////
//	cont[3] = '\0';
//
//
////	printf("[%d] cont => %s\n", __LINE__, cont);
//
//}//conv_Hex_to_Decimal_String


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

void
get_ADC_Values(void) {

	ADCON0bits.GO = 1;

    while(ADCON0bits.GO == 1) {

    }

    adcH = ADRESH;

    adcL = ADRESL;

}//get_ADC_Values

//void
//conv_Float_to_String
//(float num, char cont[6]) {
//
//	int num_Int, num_Decimal_int;
//	float num_Decimal;
//
//	char num_Decimal_str[4];
//
//	///////////////////////
//
//	// int
//
//	///////////////////////
//	num_Int = (int) num;
//
//	///////////////////////
//
//	// decimal
//
//	///////////////////////
//	num_Decimal = num - num_Int;
//
////	printf("[%d] num = %1.6f, Int = %d, decimal = %1.6f\n",
////			__LINE__, num, num_Int, num_Decimal);	//=>
//
//	///////////////////////
//
//	// decimal part => to string
//
//	///////////////////////
//	conv_Hex_to_3Digit_String((int)num_Decimal * 1000, cont);
//
////	printf("[%d] num = %1.3f, cont = %s, "
////			"num_Decimal * 1000 = %d, num_Decimal * 1000(float) = %1.3f\n",
////			__LINE__, num, cont, (int)(num_Decimal * 1000), (num_Decimal * 1000));
//
//	num_Decimal = num_Decimal * 1000;
//
////	num_Decimal_int = (int) (num_Decimal * 1000);
//	num_Decimal_int = (int) num_Decimal;
//
////	printf("[%d] num = %1.3f, num_Decimal_int = %d\n",
////				__LINE__, num, num_Decimal_int);
//
//	conv_Hex_to_3Digit_String(num_Decimal_int, num_Decimal_str);
//
////	printf("[%d] num = %1.3f, num_Decimal_str = %s\n",
////					__LINE__, num, num_Decimal_str);
//
//
//	///////////////////////
//
//	// build
//
//	///////////////////////
//	cont[0] = num_Int + 0x30;
//	cont[1] = '.';
//	cont[2] = num_Decimal_str[0];
//	cont[3] = num_Decimal_str[1];
//	cont[4] = num_Decimal_str[2];
//	cont[5] = num_Decimal_str[3];
//
////	printf("[%d] num = %1.3f, cont = %s\n",
////						__LINE__, num, cont);
//
////	printf("[%d] num => %1.3f\n", __LINE__, num);	//=> 3.543
////
////	printf("[%d] num(floor) => %d\n", __LINE__, (int)floor(num));	//=> 3
//////	printf("[%d] num(floor) => %1f\n", __LINE__, floor(num));
//////	printf("[%d] num(floor) => %d\n", __LINE__, floor(num));
////
////	printf("[%d] num(int) => %d\n", __LINE__, (int)num);	//=>
//
//
//
//}//conv_Float_to_String

//void
//conv_ADC_to_FloatString
//(int adcH, int adcL, double ref, char cont[6]) {
//
//	char temp[4];
//
//	int sum;
//
//	double scaled;
//
//	///////////////////////
//
//	// prep: adcH
//
//	///////////////////////
//	adcH &= 0x03;
//
//	///////////////////////
//
//	// sum
//
//	///////////////////////
//	sum = adcH * 256 + adcL;
//
//	///////////////////////
//
//	// decimal part => to string
//
//	///////////////////////
//	conv_Hex_to_3Digit_String(adcL, temp);
//
////	printf("[%d] adcL = %d(%%x = %x) (str = %s) \n"
////			"adcH = %d(%%x = %x)\n"
////			"(sum = %d)\n",
////				__LINE__, adcL, adcL, temp, adcH, adcH, sum);
//
//	///////////////////////
//
//	// convert
//
//	///////////////////////
//	scaled = (sum / (double)MAX_NUM) * ref;
//
////	printf("[%d] ref = %f, scaled = %f\n",
////				__LINE__, ref, scaled);
//
//	///////////////////////
//
//	// string
//
//	///////////////////////
//	conv_Float_to_String(scaled, cont);
//
//}//conv_Float_to_String

//void
//conv_Hex_to_3Digit_String
//(int num , char cont[4]) {
//
//	int hunds, tens, residue;
//
//	// 100s
//	hunds = num / 100;
//
//	residue = num - hunds * 100;
//
//	// 10s
//	tens = residue / 10;
//
//	residue = residue - tens * 10;
//
//	///////////////////////
//
//	// build
//
//	///////////////////////
//	cont[0] = hunds + 0x30;
//	cont[1] = tens + 0x30;
//	cont[2] = residue + 0x30;
//	cont[3] = '\0';
//
//}//conv_Hex_to_3Digit_String
