//#include "settings_1.h"

#define usi unsigned short int
//#define INPUT_A 0xFE

void main(void)
{
		 usi i;
		 usi custom_code_a, custom_code_b;
		 usi data_code_a, data_code_b;
		 
		 // Inputs
		 usi input_a = 0xFE;
		 usi input_b = 0xFD;
		 
		 // Outputs//
		 usi LED_Left = 0x02;
		 usi LED_Right = 0x01;
		 usi LED_Both =0x03;
		 
		 // Setup
     TRISA     = 0x00;
     PORTA     = 0x00;		//0000 0010

     TRISB     = 0xFF;		// Input: RB0 ~ RB7
		 OPTION_REG &= 0x7F;	// Pullup => on

     while(1)
     {
				if (PORTB == input_a) {
//				if (PORTB == 0xFE) {

				   PORTA = LED_Left;

				} else if(PORTB == input_b) {
//				} else if(PORTB == 0xFD) {

				   PORTA = LED_Right;

			  } else {

			     PORTA = LED_Both;

				}//if (PORTB == input_a)
				
	   }//while(1)
	   
}//void main(void)

//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window
