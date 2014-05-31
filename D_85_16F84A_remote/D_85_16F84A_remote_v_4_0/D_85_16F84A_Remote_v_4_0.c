#include "settings_1.h"


usi count;
usi duty;
usi led_pattern;

usi k;

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xDF;
		 INTCON         &= 0xFB;

		 if(count < duty)
		 {
//		          PORTA = 0x01;
		          PORTA = led_pattern & 0xFF;
		 }
		 else
		 {
              PORTA = 0x00;
		 }

		 count++;

		 if(count == 100)
		 {
		          count = 0;
		 }

		 INTCON         |= 0x20;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{
     usi i, j;
//     usi i, j, k;
//     usi k;


     TRISA     = 0x00;
     PORTA     = 0x00; //0000 0010
     TRISB     = 0x00;
     PORTB     = 0x00;

     OPTION_REG &= 0xDF;

		 count	= 0;
		 duty   = 0;

		 led_pattern   = 0x0001;

     TMR0  = 0;

     INTCON         |= 0x20;
     INTCON         |= 0x80;

     while(1)
     {
             j = rand() % 100;

             for(i = j; i < 100; i++)
             {
                   duty = i;
                   Delay_ms(10);
             }

             for(i = j; i < 100; i++)
             {
                   duty = 99 - i;
                   Delay_ms(10);
             }

						 // Initialize: LED pattern
             led_pattern = 0x01;

						 k = rand() % 4;

						 // Set: New LED pattern
//						 led_pattern = 0x01 * 2^k;
						 led_pattern = 0x01 << k;

     }//while(1)

}//void main(void)

//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window
