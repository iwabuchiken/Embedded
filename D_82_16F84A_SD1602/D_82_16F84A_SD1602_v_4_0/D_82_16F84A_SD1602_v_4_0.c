//#include <stdio.h>

// --- Copying strings from ROM to RAM
void strConstCpy
(char *dest, const char *source)
{
	while(*source)
	*dest++ = *source++ ;

	*dest = 0 ;
}

//char s1[]  = "THIS IS 8-BIT";
const char *s1 = "THIS IS 8-BIT";
const char *s2 = "THIS IS 4-BIT";

int flag = 1;

char msg[20];

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xEF;
		 INTCON         &= 0xFD;

		 Delay_ms(20);

		 if((PORTB & 0x01) == 0)
		 {
		           PORTA   ^= 0x03;
		           
//		           strcpy(msg, &s1);
		           
							// strcpy(msg, s1);
// strConst
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
     
     
             //strcpy(msg, &s1);
//             strcpy(msg, &s1);
//
//             strcpy(msg, &s2);
//             strConstCpy(msg,s1);
//
//             strConstCpy(msg,s2);
             

     }//while(1)

}//void main(void)