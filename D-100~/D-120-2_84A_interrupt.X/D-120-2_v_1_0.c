/*
* File:   D-120_v_1_0.c
 * Author: iwabuchik
 *
 * Created on
 */

#ifndef XC_H
#define XC_H
#include <xc.h>
#endif

#include <stdio.h>
#include <stdlib.h>

#include "pic.h"

#define _XTAL_FREQ 20000000

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF


///////////////////////

// protos

///////////////////////
void _Setup__TRIS(void);

void _Setup_Interrupt(void);

void interrupt intr(void);

void _int_TMR0(void);

///////////////////////

// vars

///////////////////////
int count = 0;

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup__TRIS();

	_Setup_Interrupt();

//	TRISB = 0x00;	// RB3:output
//
//	PORTB = 0x00;

	///////////////////////////////
	//
	// setup: PORTB
	//
	 ///////////////////////////////
	PORTBbits.RB2 = 1;		//=> 2 LEDS blinking simultaneously
	PORTBbits.RB3 = 0;

	///////////////////////////////
	//
	// while
	//
	 ///////////////////////////////
	while(1) {

//            //REF binary http://www.microchip.com/forums/m504764.aspx
//            PORTB = 0b00001111;
////            PORTB = 0b00000001;
//
//            __delay_ms(1000);
//
//            PORTB = 0b00000000;
//
//            __delay_ms(500);

	}//while(1)

	return;

}

void interrupt intr(void) {

	INTCON         &= 0x7F;		// prohibit		=> interrupt	0111 1111

	///////////////////////////////
	//
	// chattering
	//
	 ///////////////////////////////
//	__delay_ms(20);

	///////////////////////////////
	//
	// INT
	//
	 ///////////////////////////////
	if (INTF == 1) {

//		_int_INT();

		return;

	}

	///////////////////////////////
	//
	// TMR0
	//	in the functon up to => INTCON         |= 0x80
	//
	 ///////////////////////////////
	if (T0IF == 1) {

		_int_TMR0();

		return;

	}

	///////////////////////////////
	//
	// allow: interrupts
	//
	 ///////////////////////////////
	INTCON         |= 0x80;		// allow		=> interrupt	1000 0000

}//void interrupt intr(void)

void _Setup__TRIS(void) {

//	/****************
//	 * OPTION_REG
//	 ****************/
//	OPTION_REGbits.nRBPU = 0;   // 0 => enabled

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

void _Setup_Interrupt() {

	///////////////////////////////
	//
	// OPTION_REG
	//
	 ///////////////////////////////
	// PORTB Pull-up Enable bit
	OPTION_REGbits.nRBPU = 0;   // 0 => enabled

	OPTION_REG &= 0xDF;		// TMR0 by clock	1101 1111	Internal instruction cycle clock (CLKO)
//	OPTION_REG &= 0x7F;		// pull-up	=> enabled	0111 1111
	OPTION_REG &= 0xBF;		// INT intr => 5V->0V

	/****************************
	 * TMR0
	 *****************************/
	TMR0  = 0;

	/****************
	* interrupt
	****************/
	INTCON         |= 0x10;		// allow interrupt: INT
	INTCON         |= 0x20;		// allow interrupt: TMR0
	INTCON         |= 0x80;		// allow interrupt: global


}//void _Setup_Interrupt()

void _int_TMR0() {

	INTCON         &= 0xDF;		// prohibit		=> TMR0 interrupt	1101 1111
	INTCON         &= 0xFB;		// TMR0 flag	=> clear	1111 1011


	///////////////////////////////
	//
	// judge: 1 sec
	//
	 ///////////////////////////////
	count ++;

//	if (count == 19531 / 2) {
	if (count == 19531) {

		PORTBbits.RB2 = ~PORTBbits.RB2;		//=> 2 LEDS blinking simultaneously
		PORTBbits.RB3 = ~PORTBbits.RB3;

		count = 0;

	}//if (count == 19531)

	///////////////////////////////
	//
	// allow: interrupts
	//
	 ///////////////////////////////
	INTCON         |= 0x20;		// allow		=> TMR0 interrupt	0010 0000
	INTCON         |= 0x80;		// allow		=> intr: global		1000 0000

}//_int_TMR0

