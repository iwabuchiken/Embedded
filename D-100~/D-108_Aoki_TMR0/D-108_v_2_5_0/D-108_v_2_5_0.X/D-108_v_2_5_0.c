/*
 * File:   D-108_v_2_5_0.c
 * Author: iwabuchik
 *
 * Created on 2014/11/20, 15:40
 */


#include <xc.h>

#include "SD1602_4bit_mode.h"

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

void _Setup(void);
void _Display(void);
void _While(void);

void main(void) {

	_Display();

	while(1) {

		_While();

//		if (PORTBbits.RB1 == 1) {
//
//			PORTBbits.RB0 = 1;
//
//		} else {
//
//			PORTBbits.RB0 = 0;
//
//		}

	}

    return;
}

void _Setup(void) {

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

}//_Setup

void _Display(void) {

	char s[]  = "D-108 v-2.5.0a";

	_Setup();

	SD1602_init_2();

	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

	SD1602_print(s);

}

void _While(void) {

	if (PORTBbits.RB1 == 1) {

		PORTBbits.RB0 = 1;

	} else {

		PORTBbits.RB0 = 0;

	}

}
