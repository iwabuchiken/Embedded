void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xEF;
		 INTCON         &= 0xFD;
		 
		 Delay_ms(20);
		 
		 if((PORTB & 0x01) == 0)
		 {
		           PORTA   ^= 0x03;
		 }
		 
		 INTCON         |= 0x10;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{

     TRISA     = 0x00;
     PORTA     = 0x02;
     TRISB     = 0xFF;

     OPTION_REG &= 0x7F;
     OPTION_REG &= 0xBF;

     INTCON         |= 0x10;
     INTCON         |= 0x80;

     while(1)
     {

     }//while(1)

}//void main(void)