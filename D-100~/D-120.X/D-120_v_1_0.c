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
	TRISB = 0x00;	// RB3:output

	PORTB = 0x00;

	///////////////////////////////
	//
	// while
	//
	 ///////////////////////////////
	while(1) {

            //REF binary http://www.microchip.com/forums/m504764.aspx
            PORTB = 0b00001111;
//            PORTB = 0b00000001;

            __delay_ms(500);

            PORTB = 0b00000000;

            __delay_ms(500);

	}//while(1)

	return;

}

