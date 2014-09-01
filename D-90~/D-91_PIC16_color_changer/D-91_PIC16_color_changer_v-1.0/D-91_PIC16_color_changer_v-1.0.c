/*
	Receiver
	File: D_85_16F84A_Remote_v_5_3_2.c

*/

#define usi unsigned short int

///////////////////////

// Output

///////////////////////
#define LED_1_ON PORTA = 0x01
#define LED_2_ON PORTA = 0x02
#define LED_3_ON PORTA = 0x04

#define LED_1_ON_2_ON PORTA = 0x03
#define LED_1_ON_3_ON PORTA = 0x05
#define LED_2_ON_3_ON PORTA = 0x06

#define LEDs_ON PORTA = 0x07
#define LEDs_OFF PORTA = 0x00

//#define LED_2_ON PORTA = 0x10


///////////////////////

// Input

///////////////////////
#define PORTB_0_H	(PORTB & 0x01) == 0x01
#define PORTB_1_H	(PORTB & 0x02) == 0x02
#define PORTB_2_H	(PORTB & 0x04) == 0x04
#define PORTB_3_H	(PORTB & 0x08) == 0x08

//#define PORTB_0_H_1_H	(PORTB & 0x03) == 0x03

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////

void
_Opearations() {

	while(PORTB_0_H) {
//	while(PORTB & 0x01 == 0x01) {

		///////////////////////

		// All LEDs

		///////////////////////
		if ((PORTB_1_H) && (PORTB_2_H) && (PORTB_3_H)) {

			LEDs_ON;

		///////////////////////

		// 1 LED

		///////////////////////
		} else if ((PORTB_1_H) && !(PORTB_2_H) && !(PORTB_3_H)) {

			LED_1_ON;

		} else if (!(PORTB_1_H) && (PORTB_2_H) && !(PORTB_3_H)) {

			LED_2_ON;

		} else if (!(PORTB_1_H) && !(PORTB_2_H) && (PORTB_3_H)) {

			LED_3_ON;

		///////////////////////

		// 2 LEDs

		///////////////////////
		} else if ((PORTB_1_H) && (PORTB_2_H) && !(PORTB_3_H)) {

			LED_1_ON_2_ON;

		} else if ((PORTB_1_H) && !(PORTB_2_H) && (PORTB_3_H)) {

			LED_1_ON_3_ON;

		} else if (!(PORTB_1_H) && (PORTB_2_H) && (PORTB_3_H)) {

			LED_2_ON_3_ON;

		///////////////////////

		// All off

		///////////////////////
		} else {

			LEDs_OFF;
//			LED_1_ON;
//			LED_2_ON;

		}

	}//while(PORTB_0_H)

}//_Opearations

void interrupt(void)
{
		/*********************************
		 * vars
		**********************************/
//		usi	i;
//		usi	custom_code_a, custom_code_b;
//		usi	data_code_a, data_code_b;
//
//		usi	result;		// receive return value from functinos

		INTCON &= 0x7F;  // interrupt => forbidden
		INTCON &= 0xEF;  // INT interrupt => forbidden
		INTCON &= 0xFD;  // INT interrupt flag => cleared

		_Opearations();

		//////////////////////////////////

		// reset: interruption config

		//////////////////////////////////
		// INTCON => reset
		INTCON |= 0x10;		  // INT interrupt => permitted
		INTCON |= 0x80;

}//void interrupt(void)


void main(void)
{

		// Setup
		TRISA     = 0x00;
		PORTA     = 0x00;		//0000 0010

		TRISB     = 0xFF;		// Input: RB0 ~ RB7

		OPTION_REG &= 0x7F;	// Pull-up => on
		OPTION_REG &= 0xFF;	// INT interrupt => by 0V ~> 5V
//		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V

//		OPTION_REG &= 0xDF;	// Timer by clock
//		OPTION_REG &= 0xF0;	// Prescaler => on
//		OPTION_REG |= 0x07; // Prescaler => 1/256


//     custom_code_a = 0xFF;
//     custom_code_b = 0x00;
//     data_code_a   = 0x00;   // Button '+'
//     data_code_b   = ~data_code_a;

		INTCON |= 0x10;        // INT interrupt => permitted
		INTCON |= 0x80;

		while(1)
		{

//        PORTA = 0x01;
			LEDs_OFF;

		}//while(1)

}//void main(void)
