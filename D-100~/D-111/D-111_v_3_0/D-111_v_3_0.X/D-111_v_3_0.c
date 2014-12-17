/*
 * File:   D-111_v_1_0.c
 * Author: iwabuchik
 *
 * Created on 10/12/2014 20:36:38
 */


#include <xc.h>
//#ifndef XC_H
//#include <xc.h>
//#endif

#include <stdio.h>

#ifndef MAIN_H
#include "main.h"
#endif

//#include "SD1602_4bit_mode.h"
#ifndef SD1602_4BIT_H
#include "SD1602_4bit_mode.h"
#endif

#ifndef DEBUG_H
#include "debug.h"
#endif

#ifndef INTR_H
#include "intr.h"
#endif

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

/////////////////////////
//
//// protos
//
/////////////////////////
//void _Setup__Registries(void);
//void _Setup_ANSEL(void);
//void _Setup__Interrupt(void);
//void _Display(void);
//
//static void interrupt intr(void);

///////////////////////

// protos

///////////////////////
void _Setup__Registries(void);
//void _Setup_Interrupt(void);
void _Setup_Timer(void);
void _Setup_ANSEL(void);

void _Setup_Init_Vars(void);

//void _Display(void);
void _Display__Hex(int);
void _Display__Hex_3Items(int);
void _Display__Hex_2Items(int);

// while
void _While(void);
void _While_PORTA(void);

//void _Init_Vars(void);
static void interrupt intr(void);
void intr__TMR(void);
void intr__INT(void);

void get_ADC_Values(void);

void _Display__ADC_Fractional(void);

///////////////////////

// vars

///////////////////////

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup__Registries();			// init MCU

	_Setup_ANSEL();

	//debug
	pulse_250ms(3);

	_Setup_Timer();

	//debug
	pulse_250ms_RB2(3);

//	///////////////////////
//
//	// LCD-related
//
//	///////////////////////
//	SD1602_init_2();	// init LCD
//
////	pulse_250ms(2);
//
//	_Display();
//
////	pulse_250ms_RB2(2);
//
	///////////////////////

	// while

	///////////////////////
	while(1) {

////		_While();
//
//		_While_PORTA();
//
//		PORTAbits.RA4 = 0;


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

void _Setup__Registries(void) {

	/****************
	 * OPTION_REG
	 ****************/
	OPTION_REGbits.nRBPU = 0;

	/****************
	 * TRIS
	 ****************/
	TRISB = 0b00000001;		// RB0 => input
	TRISA = 0x00001100;		// RA2,3 => input
							// RA3 --> ANSEL
							// RA2 --> input
//    TRISA = 0x00;

	/****************
	 * PORT
	 ****************/
	PORTA = 0b00000000;		// initial => no output, no input
//    PORTA = 0b00100000;		// RA2 => input
//    PORTA = 0x00;
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

}//_Setup__Registries(void)

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

//void _Display__Hex(int num) {
//
////	strcpy(s, msg_1);
//
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
//
//	///////////////////////
//
//	// line: 2
//
//	///////////////////////
//	SD1602_control(0xC0);	// Cursor => second line
//							// Exec time => 40 us
//
//	conv_Dex_to_Binary(num, binary);
//
//	for (i = 0; i < 12; i ++) {
//
//		binary_display[3 + i] = binary[i];
//
//	}
//
//	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);
//
//	binary_display[0] = msg_Hex_2Digit[0];
//	binary_display[1] = msg_Hex_2Digit[1];
//	binary_display[2] = ' ';
//
//	SD1602_print(binary_display);
//
//}//_Display
//
///*
// * 3 items
// * 		=> hex, binary, decimal
// */
//void
//_Display__Hex_3Items
//(int num) {
//
////	char temp_4[4];
//
////	strcpy(s, msg_1);
//
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
//
//	///////////////////////
//
//	// line: 2
//
//	///////////////////////
//	SD1602_control(0xC0);	// Cursor => second line
//							// Exec time => 40 us
//
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
//
//	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);
//
//	binary_display_16[0] = msg_Hex_2Digit[0];
//	binary_display_16[1] = msg_Hex_2Digit[1];
//	binary_display_16[2] = '-';
////	binary_display_16[2] = ' ';
//
//	///////////////////////
//
//	// decimal chars
//
//	///////////////////////
//	conv_1Hex_to_String(num, temp_4);
//
//	binary_display_16[11] = ' ';	// remove the null char
//
////	binary_display_16[12] = 'a';
////	binary_display_16[13] = 'b';
////	binary_display_16[14] = 'c';
////	binary_display_16[15] = '\0';
//	binary_display_16[12] = temp_4[0];
//	binary_display_16[13] = temp_4[1];
//	binary_display_16[14] = temp_4[2];
//	binary_display_16[15] = temp_4[3];
//
//
//	SD1602_print(binary_display_16);
////	SD1602_print(binary_display);
//
//}//_Display__Hex_3Items
//
///*
// * 2 items
// * 		=> hex, decimal
// */
//void
//_Display__Hex_2Items
//(int num) {
//
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
//
//	///////////////////////
//
//	// line: 2
//
//	///////////////////////
//	SD1602_control(0xC0);	// Cursor => second line
//							// Exec time => 40 us
//
////	conv_Dex_to_Binary(num, binary);
////
////	for (i = 0; i < 9; i ++) {
//////	for (i = 3; i < 12; i ++) {
//////	for (i = 0; i < 12; i ++) {
////
//////		binary_display_16[i] = binary[i];
////		binary_display_16[3 + i] = binary[i];
////
////	}
//
//	conv_Hex_to_CharCode_2Digits(adcL, msg_Hex_2Digit);
////	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);
//
//	binary_display_8[0] = adcH + 0x30;
//	binary_display_8[1] = msg_Hex_2Digit[0];
//	binary_display_8[2] = msg_Hex_2Digit[1];
//
//	///////////////////////
//
//	// decimal chars
//
//	///////////////////////
////	conv_1Hex_to_String(num, temp_4);
//	conv_2Hex_to_String(adcH, adcL, temp_5);
////	conv_2Hex_to_String(adcH, num, temp_5);
//
//	binary_display_8[3] = ' ';
//
//	binary_display_8[4] = temp_5[0];
//	binary_display_8[5] = temp_5[1];
//	binary_display_8[6] = temp_5[2];
//	binary_display_8[7] = temp_5[3];
//	binary_display_8[8] = temp_5[4];	// '\0'
//
//	SD1602_print(binary_display_8);
////	SD1602_print(binary_display);
//
//}//_Display__Hex_3Items
//
///*
// * 2 items
// * 		=> hex, decimal
// */
//
//void
//_Display__ADC_Fractional() {
//
//	char temp[6];
//
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
//
//	///////////////////////
//
//	// line: 2
//
//	///////////////////////
//	SD1602_control(0xC0);	// Cursor => second line
//							// Exec time => 40 us
//
////	conv_Dex_to_Binary(num, binary);
////
////	for (i = 0; i < 9; i ++) {
//////	for (i = 3; i < 12; i ++) {
//////	for (i = 0; i < 12; i ++) {
////
//////		binary_display_16[i] = binary[i];
////		binary_display_16[3 + i] = binary[i];
////
////	}
//
//	conv_Hex_to_CharCode_2Digits(adcL, msg_Hex_2Digit);
////	conv_Hex_to_CharCode_2Digits(num, msg_Hex_2Digit);
//
//	binary_display_9[0] = adcH + 0x30;
//	binary_display_9[1] = msg_Hex_2Digit[0];
//	binary_display_9[2] = msg_Hex_2Digit[1];
//
//	///////////////////////
//
//	// decimal chars
//
//	///////////////////////
////	conv_2Hex_to_String(adcH, adcL, temp_5);
//	conv_ADC_to_FloatString(adcH, adcL, ref, temp);
//
//	binary_display_9[3] = ' ';
//
//	binary_display_9[4] = temp[0];
//	binary_display_9[5] = temp[1];
//	binary_display_9[6] = temp[2];
//	binary_display_9[7] = temp[3];
//	binary_display_9[8] = temp[4];	// '\0'
//	binary_display_9[9] = temp[5];	// '\0'
//
//	SD1602_print(binary_display_9);
////	SD1602_print(binary_display);
//
//}//_Display__ADC_Fractional
//
//
//void
//_While(void) {
//
////	if (flag_Intr == true) {
////
//////			hex ++;
////
//////			hex = TMR0;
////
//////		adcL ++;
////
////		hex ++;
////
//////		hex = adcL;
////
////		///////////////////////
////
////		// ADC
////
////		///////////////////////
////		get_ADC_Values();
////
////		///////////////////////
////
////		// display
////
////		///////////////////////
//////			_Display__Hex(hex);
//////			_Display__Hex_3Items(hex);
//////		_Display__Hex_2Items(hex);
////		_Display__ADC_Fractional();
////
////		///////////////////////
////
////		// reset: flag
////
////		///////////////////////
////		flag_Intr = false;
////
////	}//if (flag_Intr == true)
//
//	///////////////////////
//
//	// flag: clicked
//
//	///////////////////////
//	if (f_Clicked == true) {
//
//		///////////////////////
//
//		// debug
//
//		///////////////////////
//		pulse_100ms_RB2(2);
//
//		///////////////////////
//
//		// clear
//
//		///////////////////////
//		SD1602_control(0x01);	// LCD => clear
//
//		__delay_ms(2);			// "Execute time(max.)" => 1.64 ms
//
//		///////////////////////
//
//		// switch
//
//		///////////////////////
//		if (st_Stopwatch == 1) {
//
//			// Start
//			_While__Clicked(1);		// lib_v_1.h
//
//		} else if (st_Stopwatch == -1) {
//
//			// stop
//			_While__Clicked(-1);		// lib_v_1.h
//
//		} else {
//
//			// Unknown
//			_While__Clicked(-2);		// lib_v_1.h
//
//		}
//
//		// reset flag
//		f_Clicked = false;
//
//	}
////	_While__Clicked();
//
//}//_While
//
//void
//_While_PORTA(void) {
//
//	if (f_Clicked == true) {
//
//		while(PORTAbits.RA2 == 1) {
//
//			PORTAbits.RA4 = 1;
//
//		}
//
//		// RA4 => back to 0
//		PORTAbits.RA4 = 0;
//
//		// reset flag
//		f_Clicked = false;
//
//	} else {
//
//		PORTAbits.RA4 = 0;
//
//	}
//
////	PORTAbits.RA4 = 1;
////
////	__delay_ms(250);
////
////	PORTAbits.RA4 = 0;
////
////	__delay_ms(250);
//
//
//}
//
//void
//_Setup_Init_Vars(void) {
////_Init_Vars(void) {
//
//	///////////////////////
//
//	// vars
//
//	///////////////////////
//	msg_num = 0;
//
//	st_Stopwatch = -1;	// inital => "Stop"
//
//}


static void
interrupt intr() {

	///////////////////////

	// prohibit: further interruption

	///////////////////////
	INTCON &= 0x7F;		// prohibit: intr			// 0111 1111

	if (INTCONbits.TMR0IF == 1) {

//		intr__TMR();

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

//		intr__INT();

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

//void
//intr__TMR(void) {
//
//	INTCON &= 0xDF;		// prohibit: timer intr		// 1101 1111
//	INTCON &= 0xFB;		// clear: timer intr flag	// 1111 1011
//
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
//
//}//intr__TMR
//
//void
//intr__INT(void) {
//
//	INTCON &= 0xEF;		// prohibit: INT intr		// 1110 1111
//	INTCON &= 0xFD;		// clear: INT intr flag		// 1111 1101
//
//	///////////////////////
//
//	// validate: chattering
//
//	///////////////////////
//	__delay_ms(20);
//
//	if (PORTBbits.RB0 != 0) {
//
//		return;
//
//	}
//
//
//	///////////////////////
//
//	// report: INT starting
//
//	///////////////////////
//	PORTBbits.RB3 = 0;
//
//	__delay_ms(500);
//
//	///////////////////////
//
//	// set: flag
//
//	///////////////////////
//	flag_Intr = true;
//
//	///////////////////////
//
//	// flag: f_Clicked
//
//	///////////////////////
////	if (f_Clicked == true) {
////
////		f_Clicked = false;
////
////	} else {
//
//		f_Clicked = true;
//
////	}
//
////	hex ++;
////
////	_Display__Hex(hex);
//
//	///////////////////////
//
//	// invert: st_Stopwatch
//
//	///////////////////////
//	if (st_Stopwatch == 1) {
//
//		st_Stopwatch = -1;
//
//	} else {
//
//		st_Stopwatch = 1;
//
//	}
//
////	///////////////////////
////
////	// capacitor
////
////	///////////////////////
////	while(PORTAbits.RA2 == 1) {
////
////		PORTAbits.RA4 = 1;
////
////	}
////
////	PORTAbits.RA4 = 0;
//
////	// report
////	pulse_100ms_RB2(2);
//
//}//intr__INT
//
/////*
//// * @param
//// * 		num => < 256, >= 0
//// */
////void conv_1Hex_to_String
////(int num, char cont[4]) {
////
////	// 100s
////	hunds = num / 100;
////
////	residue = num - hunds * 100;
////
////	// 10s
////	tens = residue / 10;
////
////	residue = residue - tens * 10;
////
//////	// display
//////	printf("[%d] num = %d\n", __LINE__, num);
////
//////	sprintf(cont, "%d%d%d", hunds, tens, residue);
////
//////	cont[0] = 'x';
//////	cont[1] = 'y';
//////	cont[2] = 'z';
////
////	cont[0] = hunds + 0x30;
////	cont[1] = tens + 0x30;
////	cont[2] = residue + 0x30;
//////
////	cont[3] = '\0';
////
////
//////	printf("[%d] cont => %s\n", __LINE__, cont);
////
////}//conv_Hex_to_Decimal_String
//
//
////
////void pulse_250ms(unsigned int num) {
////
////	int i;
////
////	for (i = 0; i < num; i ++) {
////
////		PORTBbits.RB1 = 1;
////
////		__delay_ms(250);
////
////		PORTBbits.RB1 = 0;
////
////		__delay_ms(250);
////
////	}
////
////}
////
////void pulse_250ms_RB2(unsigned int num) {
////
////	int i;
////
////	for (i = 0; i < num; i ++) {
////
////		PORTBbits.RB2 = 1;
////
////		__delay_ms(250);
////
////		PORTBbits.RB2 = 0;
////
////		__delay_ms(250);
////
////	}
////
////}
////
////void pulse_100ms(unsigned int num) {
////
////	int i;
////
////	for (i = 0; i < num; i ++) {
////
////		PORTBbits.RB1 = 1;
////
////		__delay_ms(100);
////
////		PORTBbits.RB1 = 0;
////
////		__delay_ms(100);
////
////	}
////
////}
////
////void pulse_100ms_RB2(unsigned int num) {
////
////	int i;
////
////	for (i = 0; i < num; i ++) {
////
////		PORTBbits.RB2 = 1;
////
////		__delay_ms(100);
////
////		PORTBbits.RB2 = 0;
////
////		__delay_ms(100);
////
////	}
////
////}
////
//
//void
//get_ADC_Values(void) {
//
//	ADCON0bits.GO = 1;
//
//	while(ADCON0bits.GO == 1) {
//
//	}
//
//	adcH = ADRESH;
//
//	adcL = ADRESL;
//
//}//get_ADC_Values
//
