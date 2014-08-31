/*
	Receiver
	File: D_85_16F84A_Remote_v_5_3_2.c

*/

#define usi unsigned short int
#define LED_1_ON PORTA = 0x01
#define LED_2_ON PORTA = 0x02

#define LEDs_OFF PORTA = 0x00

//#define LED_2_ON PORTA = 0x10

#define LED_1_ON_2_ON PORTA = 0x03

///////////////////////

// Output

///////////////////////
#define PORTB_0_H	(PORTB & 0x01) == 0x01
#define PORTB_1_H	(PORTB & 0x02) == 0x02
#define PORTB_0_H_1_H	(PORTB & 0x03) == 0x03

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////

void _Opearations(void) {

	while(PORTB_0_H) {
//	while(PORTB & 0x01 == 0x01) {

		if (PORTB_0_H_1_H) {
//		if (PORTB & 0x10 == 0x10) {

//			LED_1_OFF;
//			LED_2_ON;
			LED_1_ON_2_ON;

		} else if (PORTB_0_H && !(PORTB_1_H)) {
//		} else if (PORTB_0_H) {

			LED_1_ON;
//			LED_2_OFF;

		} else if (!(PORTB_0_H) && (PORTB_1_H)) {
//		} else if (PORTB_1_H) {

//			LED_1_ON;
			LED_2_ON;

		} else {

			LEDs_OFF;
//			LED_1_ON;
//			LED_2_ON;

		}

	}

}

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
