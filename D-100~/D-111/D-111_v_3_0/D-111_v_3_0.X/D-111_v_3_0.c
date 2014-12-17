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

///////////////////////

// protos

///////////////////////
void _Setup__Registries(void);
void _Setup_ANSEL(void);
void _Setup__Interrupt(void);
void _Display(void);

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

//	//debug
//	pulse_250ms_RB2(3);

	_Setup_ANSEL();

	//debug
	pulse_100ms(2);

	_Setup__Interrupt();

	pulse_250ms_RB2(2);

	///////////////////////

	// LCD-related

	///////////////////////
	SD1602_init_2();	// init LCD

//	pulse_250ms(2);

	_Display();

	///////////////////////

	// while

	///////////////////////
	while(1) {

//		_While();

//		_While_PORTA();
//
//		PORTAbits.RA4 = 0;


	}//while(1)

    return;
}

void
_Setup__Interrupt(void) {

//	pulse_100ms_RB2(3);

	OPTION_REG &= 0x7F;	// pull-up --> ON

	OPTION_REG &= 0xDF;	// timer by clock
	OPTION_REG &= 0xBF;		// INT intr --> 5V ~> 0V

	TMR0 = 0;

	INTCON |= 0x10;		// permit: INT intr
	INTCON |= 0x20;		// permit: timer intr

	INTCON |= 0x80;		// permit: intr

	//debug
	pulse_100ms_RB2(3);	//=> program stops here

}//_Setup_Timer

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
	/****************
	 * PORT
	 ****************/
	PORTA = 0b00000000;		// initial => no output, no input
//    PORTA = 0b00100000;		// RA2 => input

	PORTB = 0x00;

}//_Setup

void
_Display(void) {

//	strcpy(s, msg_1);

	///////////////////////

	// line: 1

	///////////////////////
	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

	SD1602_print(msg_Project_Name);

//	pulse_100ms(3);

	///////////////////////

	// line: 2

	///////////////////////
	SD1602_control(0xC0);	// Cursor => second line
							// Exec time => 40 us

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

}//_Display
