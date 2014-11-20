/*
 * File:   D-108_v_2_4_1.c
 * Author: iwabuchik
 *
 * Created on 2014/11/20, 8:31
 */


#include <xc.h>

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#include "SD1602_4bit_mode.h"


#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

void _Setup(void);

void main(void) {

	char s[]  = "Hello!";

	_Setup();

	SD1602_init_2();

//	SD1602_control(0x02);
////
//	SD1602_print(s);

//	SD1602_clear();

	while(1) {

//		SD1602_init_2();

		SD1602_control(0x02);
//		SD1602_control(0x80);

		SD1602_print(s);


//		PORTA = 0x01;
//
//		__delay_ms(250);
//
//		PORTA = 0x00;
//
//		__delay_ms(500);

	}

    return;
}

void _Setup(void) {

    /****************
     * TRISB
     ****************/
    TRISB = 0x00;
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
