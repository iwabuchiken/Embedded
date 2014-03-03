#include "SD1602_8bit_mode.h"

void main(void)
{
		 char s[]  = "Hello!";

     TRISA     = 0x00;
     PORTA     = 0x00;
     TRISB     = 0x00;
     PORTB     = 0x00;


		 SD1602_init();

		 SD1602_clear();

		 while(1)
		 {
           //SD1602_clear();
		         SD1602_control(0x80);
		         SD1602_print(s);

		         Delay_ms(1000);
		 }

}