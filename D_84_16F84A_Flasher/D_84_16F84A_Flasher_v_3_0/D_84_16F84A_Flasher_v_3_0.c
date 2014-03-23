unsigned short int count;
unsigned short int duty;

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xDF;
		 INTCON         &= 0xFB;

		 if(count < duty)
		 {
		          PORTA = 0x01;
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
     unsigned short int i;


     TRISA     = 0x00;
     PORTA     = 0x00; //0000 0010
     TRISB     = 0x00;
     PORTB     = 0x00;

     OPTION_REG &= 0xDF;
//     OPTION_REG &= 0xF0;
//     OPTION_REG &= 0x07;

		 count	= 0;
		 duty   = 0;

     TMR0  = 0;

     INTCON         |= 0x20;
     INTCON         |= 0x80;

     while(1)
     {
             for(i = 0; i < 100; i++)
             {
                   duty = i;
                   Delay_ms(10);
             }
             
             for(i = 0; i < 100; i++)
             {
                   duty = 99 - i;
                   Delay_ms(10);
             }

     }//while(1)

}//void main(void)
