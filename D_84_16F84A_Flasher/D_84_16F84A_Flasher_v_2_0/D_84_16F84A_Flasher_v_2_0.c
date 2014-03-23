unsigned short int i;
unsigned short int p[8] = {
				 0x00,
				 0x7E,
				 0x11,
				 0x11,
				 
				 0x11,
				 0x7E,
				 0x00,
				 0x00
};

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xDF;
		 INTCON         &= 0xFB;

		 i++;
		 
		 
		 Delay_ms(20);
		 
		 
		 if(i == 8)
		 {
		      i = 0;
		 }

		 PORTB = p[i];
//		 PORTB = 0x00;
//		 PORTB = 0xFF;
//		 PORTB = 0x7E;

		 INTCON         |= 0x20;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{

     TRISA     = 0x00;
     PORTA     = 0x00; //0000 0010
     TRISB     = 0x00;
     PORTB     = 0x00;

     OPTION_REG &= 0xDF;
     OPTION_REG &= 0xF0;
     OPTION_REG &= 0x07;

		 i = 0;

     TMR0  = 0;

     INTCON         |= 0x20;
     INTCON         |= 0x80;

     while(1)
     {

     }//while(1)

}//void main(void)
