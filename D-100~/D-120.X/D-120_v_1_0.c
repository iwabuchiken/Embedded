/*
* File:   D-120_v_1_0.c
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

#ifndef MAIN_H
#include "main.h"
#endif

#ifndef LIB__H
#include "lib.h"
#endif

///////////////////////

// protos

///////////////////////
void _Setup(void);
void _Setup_ANSEL(void);

void _While(void);

void _Setup_Vars(void);

void _Setup_PORTB(void);

///////////////////////

// vars

///////////////////////
usi count;

int f_INT = false;

usi cycle = 0;	// count: num of display update

///////////////////////

// funcs

///////////////////////
void main(void) {

	///////////////////////

	// setups

	///////////////////////
	_Setup();			// init MCU

	_Setup_ANSEL();

	///////////////////////////////
	//
	// setup: PORTB
	//
	 ////////////-///////////////////
	///////////////////////////////
	//
	// initial status
	//
	 ///////////////////////////////
	PORTBbits.RB2 = 0;
	PORTBbits.RB3 = 1;

//	_Setup_PORTB();


	///////////////////////////////
	//
	// while
	//
	 ///////////////////////////////
	while(1) {

//		_While();

	}//while(1)

	return;
}

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
	PORTB = 0b00001111;		// RB0~3 => H / RB4~7 => L
//	PORTB = 0x00;

}//_Setup

void
_While(void) {

//	///////////////////////////////
//	//
//	// flag: f_INT
//	//
//	 ///////////////////////////////
//	if (f_INT == true) {
//
//		PORTBbits.RB2 = tmp_1;
//		PORTBbits.RB3 = tmp_2;
//
//	}//if (f_INT == true)

}//_While

