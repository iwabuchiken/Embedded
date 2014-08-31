/*
	Receiver
	File: D_85_16F84A_Remote_v_5_3_2.c

*/

#define usi unsigned short int

#define LED_1_ON PORTA = 0x01
#define LED_1_OFF PORTA = 0x00
#define LED_2_ON PORTA = 0x02
//#define LED_2_ON PORTA = 0x10
#define LED_2_OFF PORTA = 0x00

#define PORTB_0_H PORTB & 0x01 == 0x01

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////

void main(void)
{

		// Setup
		TRISA     = 0x00;
		PORTA     = 0x00;		//0000 0010

		TRISB     = 0xFF;		// Input: RB0 ~ RB7

		OPTION_REG &= 0x7F;	// Pull-up => on

		while(1)
		{

			if (PORTB_0_H) {

				LED_1_ON;

			} else {

				LED_1_OFF;

			}

		}//while(1)

}//void main(void)
