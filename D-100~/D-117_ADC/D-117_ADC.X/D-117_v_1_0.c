/*
 * File:   D-117_v_1_0.c
 * Author: iwabuchik
 *
 * Created on 05/02/2015 09:11:31
 */

#ifndef XC_H
#define XC_H
#include <xc.h>
#endif

#ifndef STDIO_H
#define STDIO_H
#include <stdio.h>
#endif



#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#ifndef LIB__H
#include "lib.h"
#endif

#ifndef DEBUG_H
#include "debug.h"
#endif

#ifndef SD1602_4BIT_H
#include "SD1602_4bit_mode.h"
#endif

#ifndef MAIN_H
#include "main.h"
#endif

#ifndef DISP_H
#include "disp.h"
#endif

#ifndef _FONT5X8_H_
#include "font5x8.h"
#endif

///////////////////////

// protos

///////////////////////
void _Setup(void);
void _Setup_ANSEL(void);

void _Setup_Init_Vars(void);

void _test_Chars(void);
int register_Chars(void);

void _While(void);

void _N2C(void);

void _Setup_Interrupt(void);

void interrupt intr(void);

void _Setup_Vars(void);

void _Setup_PORTB(void);

///////////////////////

// vars

///////////////////////
usi count;

///////////////////////

// funcs

///////////////////////
void main(void) {

				//  0123456789012345
//	char msg_1[] = "ddram addressing";
//	char msg_1[] = "display 0x02...";
//	char msg_1[] = "register done";
//	char msg_1[] = "register_Char";

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	_Setup_ANSEL();

	_Setup_Interrupt();

	_Setup_Vars();

//	_Setup_PORTB();

	///////////////////////

	// LCD-related

	///////////////////////
	SD1602_init_2();	// init LCD

//	_Display();	// disp.h
	_Display_2Lines(msg_Project_Name, msg_Initial);	// disp.h

	///////////////////////////////
	//
	// setup: PORTB
	//
	 ///////////////////////////////
	_Setup_PORTB();

//	///////////////////////////////
//	//
//	// register: chars
//	//
//	 ///////////////////////////////
//	int res = register_Chars();
//
//	/****************************
//	 * validate
//	 *****************************/
//	if (res == false) {
//
//		SD1602_control(0x80 + 0x40 + 0x00);	// 2nd line, 6th digit
//
//		char msg[] = "can't register!";
//
//		SD1602_print(msg);
//
////		return;
//
//	}
//	} else {
//
//		///////////////////////////////
//		//
//		// test
//		//
//		 ///////////////////////////////
//		_test_Chars();
//
//	}

//	///////////////////////////////
//	//
//	// conv: num to chars
//	//
//	 ///////////////////////////////
//	_N2C();

	///////////////////////
	while(1) {

		_While();

	}//while(1)

	return;
}

void interrupt intr(void) {

	INTCON         &= 0x7F;		// prohibit		=> interrupt
	INTCON         &= 0xDF;		// prohibit		=> TMR0 interrupt
	INTCON         &= 0xFB;		// TMR0 flag	=> clear


	///////////////////////////////
	//
	// judge: 1 sec
	//
	 ///////////////////////////////
	count ++;

	if (count == 19531) {

//		if (PORTBbits.RB2 == 0) PORTBbits.RB2 = 1;
//		else if (PORTBbits.RB2 == 1) PORTBbits.RB2 = 0;

//		PORTB ^= 0b00110000;	// RB2,RB3 --> XOR	//=> both LEDs go blank

//		(PORTBbits.RB2 == 0) ? PORTBbits.RB2 = 1 : PORTBbits.RB2 = 0;
//		(PORTBbits.RB3 == 0) ? PORTBbits.RB3 = 1 : PORTBbits.RB3 = 0;

//		PORTBbits.RB2 ^= 0x01;
//		PORTBbits.RB3 ^= 0x01;

//		PORTBbits.RB2 = ~(PORTBbits.RB2);	//=> 2 LEDS blinking simultaneously
//		PORTBbits.RB3 = ~(PORTBbits.RB3);
		PORTBbits.RB2 = ~PORTBbits.RB2;		//=> 2 LEDS blinking simultaneously
		PORTBbits.RB3 = ~PORTBbits.RB3;

		count = 0;

	}

	///////////////////////////////
	//
	// allow: interrupts
	//
	 ///////////////////////////////
	INTCON         |= 0x20;		// allow		=> TMR0 interrupt
	INTCON         |= 0x80;		// allow		=> interrupt

}//void interrupt intr(void)

void _Setup_PORTB() {

	///////////////////////////////
	//
	// initial status
	//
	 ///////////////////////////////
	PORTBbits.RB2 = 0;
	PORTBbits.RB3 = 1;

}

void _Setup_Vars() {

	count = 0;

}

void _Setup_Interrupt() {

	///////////////////////////////
	//
	// OPTION_REG
	//
	 ///////////////////////////////
	OPTION_REG &= 0xDF;		// TMR0 by clock

	/****************************
	 * TMR0
	 *****************************/
	TMR0  = 0;

	/****************
	* interrupt
	****************/
	INTCON         |= 0x20;
	INTCON         |= 0x80;


}//void _Setup_Interrupt()

void _N2C() {

	char degree[3];

	signed char temp_i = 0xCF;
//	int temp_i = 0xCF;

	conv_H2CC_HEX_2Digits(temp_i, degree);

	degree[2] = '\0';

	SD1602_control(0x80 + 0x40 + (lenOf_msg_Initial - 1));	// 2nd line, 11th digit
//	SD1602_control(0x80 + 0x40 + 0x0B);	// 2nd line, 11th digit

	SD1602_display(degree[0]);
	SD1602_display(degree[1]);

}//void _N2C()

int register_Chars() {

	//	register_Char();	//	lib.h
//	int res = registerChar(0x08, 1);	//	lib.h
	int res = registerChar(0x02, 1);	//	lib.h
							// char code is 0x02
							// char is => '火'


	return res;

}//register_Chars

void _test_Chars() {
				//  0123456789012345
	char msg_1[] = "Using enums...";

	//report
	_Display_2Lines(msg_Project_Name, msg_1);	// disp.h
//	_Display_2Lines(msg_Project_Name, "register_Char");	// disp.h

	SD1602_control(0x80 + 0x40 + 0x05);	// 2nd line, 6th digit
//	SD1602_control(0x80 + 0x40 + 0x05);	// 2nd line, 6th digit
//	SD1602_control(0x80 + 0x40 + 0x06);	// 2nd line, 6th digit
//	SD1602_control(0x80 + 0x0F + 0x06);	// 2nd line, 6th digit
//	SD1602_control(0x80 + 0x06);	// 2nd line, 6th digit
//	SD1602_control(0x80 | 0x45);	// 2nd line, 6th digit

	SD1602_display(0x02);
//	SD1602_display(0xC0);	// 'タ'
//	SD1602_write(0x02, 1);

}//_test_Chars

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
	TRISA = 0x00000000;		// RA => all output

	/****************
	 * PORT
	 ****************/
	PORTA = 0b00000000;		// initial => no output, no input
	PORTB = 0x00;

}//_Setup

void
_While(void) {

//	///////////////////////
//
//	// while RB0 is H => set RB1 H
//
//	///////////////////////
//	while(PORTBbits.RB0 == 1) {
//
//		///////////////////////
//
//		// RB1 => H: transistor is set ON
//
//		///////////////////////
//		PORTBbits.RB1 = 1;
//
//	}
//
//	///////////////////////
//
//	// RB1 => L: transistor is set OFF
//
//	///////////////////////
//	PORTBbits.RB1 = 0;

}//_While

void
_Setup_Init_Vars(void) {
//_Init_Vars(void) {

	///////////////////////

	// vars

	///////////////////////
    
}
