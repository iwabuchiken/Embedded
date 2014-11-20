/*
 * File:   D-108_v_2_5_0.c
 * Author: iwabuchik
 *
 * Created on 2014/11/20, 15:40
 */


#include <xc.h>
#include <string.h>

#include "SD1602_4bit_mode.h"

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#define true	1
#define false	0

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

void _Setup(void);
void _Display(void);
void _While(void);

unsigned int msg_num = 0;	// message number
						// 0 => version; 1 => greeting

char s[20];

const char msg_1[]  = "D-108 v-2.5.1b";
const char msg_2[]  = "You clicked it!";

void main(void) {

	_Display();

	while(1) {

		_While();

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

    ///////////////////////

	// vars

	///////////////////////
    msg_num = 0;
}//_Setup

void _Display(void) {

	strcpy(s, msg_1);
//	strcpy(s, "D-108 v-2.5.1a");
//	char s[]  = "D-108 v-2.5.0a";

	_Setup();

	SD1602_init_2();

	SD1602_control(0x02);	// Cursor => at home
							// Exec time => 1.64 ms

	__delay_ms(2);

	SD1602_print(s);

}

void
_While(void) {

	if (PORTBbits.RB1 == 1) {

		if(msg_num != 1) {

			SD1602_control(0x01);	// LCD => clear

			__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

			SD1602_control(0x02);	// Cursor => at home
									// Exec time => 1.64 ms

			__delay_ms(2);

			strcpy(s, msg_2);

			SD1602_print(s);

			// set message number
			msg_num = 1;

		}

		PORTBbits.RB0 = 1;

	} else {

		if(msg_num != 0) {

			SD1602_control(0x01);	// LCD => clear

			__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

			SD1602_control(0x02);	// Cursor => at home
									// Exec time => 1.64 ms

			__delay_ms(2);

			strcpy(s, msg_1);

			SD1602_print(s);

			// set message number
			msg_num = 0;

		}

		PORTBbits.RB0 = 0;

	}//if (PORTBbits.RB1 == 1)

}//_While
