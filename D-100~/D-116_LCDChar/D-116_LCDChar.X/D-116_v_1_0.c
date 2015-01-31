/*
 * File:   D-116_v_1_0.c
 * Author: iwabuchik
 *
 * Created on 31/01/2015 08:49:28
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

///////////////////////

// protos

///////////////////////
void _Setup(void);
void _Setup_ANSEL(void);

void _Setup_Init_Vars(void);

void _While(void);

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
	_Setup();			// init MCU

	_Setup_ANSEL();

	///////////////////////

	// LCD-related

	///////////////////////
	SD1602_init_2();	// init LCD

//	pulse_250ms(2);

	_Display();

	///////////////////////
	while(1) {

		_While();

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
	TRISA = 0x00000000;		// RA => all output

	/****************
	 * PORT
	 ****************/
	PORTA = 0b00000000;		// initial => no output, no input
	PORTB = 0x00;

}//_Setup

void
_While(void) {

	///////////////////////

	// while RB0 is H => set RB1 H

	///////////////////////
	while(PORTBbits.RB0 == 1) {

		///////////////////////

		// RB1 => H: transistor is set ON

		///////////////////////
		PORTBbits.RB1 = 1;

	}

	///////////////////////

	// RB1 => L: transistor is set OFF

	///////////////////////
	PORTBbits.RB1 = 0;

}//_While

void
_Setup_Init_Vars(void) {
//_Init_Vars(void) {

	///////////////////////

	// vars

	///////////////////////
    
}
