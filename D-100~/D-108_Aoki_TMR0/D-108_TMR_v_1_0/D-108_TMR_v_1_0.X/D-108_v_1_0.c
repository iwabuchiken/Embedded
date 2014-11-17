/*
 * File:   D-108_Aoki_TMR0_v-1_0.c
 * Author: iwabuchik
 *
 * Created on 2014/11/17, 15:05
 */


#include <xc.h>
#define _XTAL_FREQ 20000000

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF


unsigned int count;

void _Setup(void);
void interrupt intr(void);

void main(void) {

    /****************
     *  setup
     ****************/
     _Setup();

     ///////////////////////

	// loop

	///////////////////////
	while(1) {

	}

    return;
}

void interrupt intr(void) {

    INTCON         &= 0x7F;
    INTCON         &= 0xDF;
    INTCON         &= 0xFB;

    count++;

    if(count == 19531) {

        PORTA    ^= 0x03;

        __delay_ms(200);

        PORTA    ^= 0x03;

//        __delay_ms(1);

        count    = 0;

    }

     INTCON         |= 0x20;
     INTCON         |= 0x80;

}//void interrupt intr(void)

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

    /****************
     * OPTION_REG
     ****************/
    OPTION_REG &= 0x7F;
    OPTION_REG &= 0xDF;

    /****************
     * init vars
     ****************/
    count = 0;
    TMR0  = 0;

    /****************
     * interrupt
     ****************/
    INTCON         |= 0x20;
    INTCON         |= 0x80;

}//_Setup
