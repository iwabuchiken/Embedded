//#include "settings_1.h"

#define usi unsigned short int
//#define INPUT_A 0xFE

void main(void)
{
		 usi i;
		 usi custom_code_a, custom_code_b;
		 usi data_code_a, data_code_b;

		 // Setup
     TRISA     = 0x00;
     PORTA     = 0x00;		//0000 0010

     TRISB     = 0x00;		// Input: RB0 ~ RB7
     PORTB     = 0x00;
     
		 OPTION_REG &= 0xDF;	// Timer by clock
     OPTION_REG &= 0xF0;	// Prescaler => on
		 OPTION_REG |= 0x07;	// Prescaler => 1/256

     custom_code_a = 0xFF;
     custom_code_b = 0x00;
     data_code_a   = 0x00;   // Button '+'
     data_code_b   = ~data_code_a;

     while(1)
     {
				/*********************
				  Reader
				**********************/
				TMR0     = 0;

				while(TMR0 < 176)         // 9.0ms
				{
					 // Modulation
					 PORTA        = 0x01;   // RA0 => on
					 Delay_us(9);   // 8.8us
					 
					 PORTA        = 0x00;   // RA0 => off
					 Delay_us(17);   // 26.3us - 8.8us =% 17us
				}
				
				TMR0 = 0;
				PORTA = 0x00;
				
				while(TMR0 < 88)       // 4.5ms
				{

				}

				/*********************
				 Custom code: lower 8 bits
				**********************/

				/*********************
				 Custom code: upper 8 bits
				**********************/
				
	   }//while(1)

}//void main(void)

//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window
