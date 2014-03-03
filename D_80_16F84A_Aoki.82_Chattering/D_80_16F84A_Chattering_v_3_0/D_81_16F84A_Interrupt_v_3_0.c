unsigned int count;

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xDF;
		 INTCON         &= 0xFB;

		 count++;
		 
		 if(count == 19531)
		 {
		          PORTA    ^= 0x03;
		          count    = 0;
		 }

		 INTCON         |= 0x20;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{

     TRISA     = 0x00;
     PORTA     = 0x02; //0000 0010
     TRISB     = 0xFF;

     OPTION_REG &= 0x7F;
     OPTION_REG &= 0xDF;
     
     count = 0;
     TMR0  = 0;

     INTCON         |= 0x20;
     INTCON         |= 0x80;

     while(1)
     {

     }//while(1)

}//void main(void)