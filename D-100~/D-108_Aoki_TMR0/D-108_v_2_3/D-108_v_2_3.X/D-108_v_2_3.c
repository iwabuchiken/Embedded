/*
 * File:   D-108_v_2_3.c
 * Author: iwabuchik
 *
 * Created on 2014/11/19, 14:43
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

void main(void) {

	_Setup();

	SD1602_init();

	SD1602_clear();


	while(1) {

		PORTA = 0x01;

		__delay_ms(250);

		PORTA = 0x00;

		__delay_ms(500);

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
