#include "SD1602_8bit_mode.h"

void main(void)
{
		 char s1[]  = "Hello! world.";
		 char s2[]  = "©ид╣ь";

     TRISA     = 0x00;
     PORTA     = 0x00;
     TRISB     = 0x00;
     PORTB     = 0x00;


		 SD1602_init();

		 while(1)
		 {
		         // s1
		 				 SD1602_clear();

						 SD1602_control(0x80);

						 SD1602_print(s1);

		         Delay_ms(1000);
		         
		         // s2
		         SD1602_clear();

						 SD1602_control(0xC0);

						 SD1602_print(s2);
						 
		         Delay_ms(1000);

		 }

}