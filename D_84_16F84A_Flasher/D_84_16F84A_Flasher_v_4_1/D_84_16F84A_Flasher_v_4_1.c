unsigned short int count;
unsigned short int duty;
unsigned short int led_pattern;

unsigned short int k;

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
     unsigned short int i, j;
//     unsigned short int i, j, k;
//     unsigned short int k;


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

						 k = rand() % 4;
						 
						 led_pattern = 0x01 * 2^k;
						 
     }//while(1)

}//void main(void)

//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window