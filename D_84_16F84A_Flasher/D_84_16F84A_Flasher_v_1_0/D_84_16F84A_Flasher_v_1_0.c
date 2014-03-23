unsigned short int count;
//unsigned int count;
unsigned int p;

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xDF;
		 INTCON         &= 0xFB;

		 count++;

//		 if(count == 20)
		 if(count == 300)
		 {
		          p <<= 1;
		          
		          if(p == 0x0100)
		          {
		               p = 0x0001;
							}
		          
		          PORTB  = p & 0xFF;
		          
		          count  = 0;
		          

		 }

		 INTCON         |= 0x20;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{

     TRISA     = 0x00;
     PORTA     = 0x00; //0000 0010
//     TRISB     = 0xFF;
     TRISB     = 0x00;
     PORTB     = 0x00;

     OPTION_REG &= 0xDF;
     OPTION_REG &= 0xF0;
     OPTION_REG &= 0x07;

		 p = 0x0001;
		 PORTB = p & 0xFF;

     count = 0;
     TMR0  = 0;

     INTCON         |= 0x20;
     INTCON         |= 0x80;

     while(1)
     {

     }//while(1)

}//void main(void)
