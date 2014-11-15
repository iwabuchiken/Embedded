/*
 * File:   D-97_LCD_v-2_0.c
 * Author: iwabuchik
 *
 * Created on 2014/11/07, 16:23
 *
 * Aoki.184
 *
 */


#include <xc.h>

#include "SD1602_4bit_mode.h"

//#define _XTAL_FREQ 20000000

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF

void _Setup(void);

void _Loop(void);
void _Loop_LCD(void);


void main(void) {

    /****************
     * Setup
     ****************/
     _Setup();

     /****************
     * loop
     ****************/
//     _Loop();
     _Loop_LCD();

//    while(1) {
//
//        //REF binary http://www.microchip.com/forums/m504764.aspx
//        PORTB = 0x01;
//
//        __delay_ms(500);
//
//        PORTB = 0x02;
//
//        __delay_ms(500);
//
//    }

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

//     /****************
//     * report
//     ****************/
//     PORTA = 0x00;
//     PORTA = 0x01;
//
//     __delay_ms(100);
//
//     PORTA = 0x00;

    /****************
     * LCD
     ****************/
     SD1602_init();

//     /****************
//     * report
//     ****************/
//     PORTB = 0x00;
//     PORTB = 0x01;
//
//     __delay_ms(100);
//
//     PORTB = 0x00;
//
//     __delay_ms(500);

}//_Setup

void _Loop(void){

    	while(1) {

            //REF binary http://www.microchip.com/forums/m504764.aspx
            PORTB = 0x01;

            __delay_ms(500);

            PORTB = 0x02;

            __delay_ms(500);

	}

}//void _Loop(void)

void _Loop_LCD(void){

    char s[] = "Hello!";

    SD1602_init();

    while(1) {

        SD1602_clear();
        SD1602_control(0x80);
        SD1602_print(s);

        __delay_ms(1000);

        SD1602_clear();
        SD1602_control(0xC0);
        SD1602_print(s);

        __delay_ms(1000);

    }//while(1)

}//void _Loop_LCD(void)
