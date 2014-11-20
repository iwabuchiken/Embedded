/*
 * File:   D-108_v_2_1.c
 * Author: iwabuchik
 *
 * Created on 2014/11/19, 9:33
 */


#include <xc.h>

//#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
//#endif

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

void _Setup(void);

void main(void) {

    _Setup();

    while(1) {

        PORTA = 0x01;

        __delay_ms(500);

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
    PORTA = 0x02;
    PORTB = 0x00;

    /****************
     * ANSEL
     ****************/
    ANSEL = 0x00;

}//_Setup
