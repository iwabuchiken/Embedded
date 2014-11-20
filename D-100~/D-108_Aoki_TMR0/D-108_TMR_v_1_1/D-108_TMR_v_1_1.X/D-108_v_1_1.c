/*
 * File:   D-108_v_1_1.c
 * Author: iwabuchik
 *
 * Created on 2014/11/18, 10:40
 */


#include <xc.h>
#define _XTAL_FREQ 20000000

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF


unsigned int count;

void _Setup(void);
void condensor(void);

void main(void) {

    /****************
     *  setup
     ****************/
     _Setup();

     ///////////////////////

	// loop

	///////////////////////
	while(1) {

		condensor();

	}

    return;
}

void _Setup(void) {

    /****************
     * TRISB
     ****************/
    TRISB = 0x00;		// RB0~7 => outputs
    TRISA = 0B00000010;	// RA1 => input, others => output

    /****************
     * PORT
     ****************/
    PORTA = 0x00;
    PORTB = 0x00;

    //REF http://technologicaladvance.blog.fc2.com/blog-entry-72.html
//    PORTAbits.RA0 = 1;
    
    /****************
     * ANSEL
     ****************/
    ANSEL = 0x00;

    /****************
     * OPTION_REG
     ****************/
    OPTION_REG &= 0x7F;
    OPTION_REG &= 0xDF;

}//_Setup

void
condensor(void) {

	///////////////////////

	// set: RA0

	///////////////////////
    PORTAbits.RA0 = 1;

    __delay_us(770);

    PORTAbits.RA0 = 0;

    while(PORTAbits.RA1 != 1) {

        PORTAbits.RA2 = 1;

    }

    PORTAbits.RA2 = 0;

}//condensor
