//#include "SD1602_8bit_mode.h"
#include "SD1602_4bit_mode.h"
#include "utils.h"

//const char s1[]  = "Psedoscience";
const char s1[]  = "Versionsgeschichte";

//const char s2[]  = "xylophone";
const char s2[]  = "Schmargendorf";
//const char s2[]  = "ad nauseam";

char s[]  = "Schmargendorf";
//char s[30];
//char s[] = s2;

int flag = 1;

//void strConstCpy2
//(char *dest, const char *source)
//{
//	while(*source)
//	*dest++ = *source++ ;
//
//	*dest = 0 ;
//}

void interrupt(void)
{
		 INTCON         &= 0x7F;
		 INTCON         &= 0xEF;
		 INTCON         &= 0xFD;

		 Delay_ms(20);

		 if((PORTB & 0x01) == 0)
		 {
             if (flag == 1)
		           {

//		              strConstCpy(s, s1);
		              strConstCpy2(s, s1);

		              flag *= -1;

		           } else {

//		              strConstCpy(s, s2);
		              strConstCpy2(s, s2);

		              flag *= -1;

		           }
		           
//							 Delay_ms(2000);
//                 Delay_ms(3000);
							 
//		           PORTA   ^= 0x03;

//		           strcpy(msg, &s1);

							// strcpy(msg, s1);
// strConst
		 }

		 INTCON         |= 0x10;
		 INTCON         |= 0x80;

}//void interrupt(void)

void main(void)
{
//		 char s[]  = "Hello!";
   //char s[]  = "Dictionary";
//		 char s[]  = "±²³´µ";


     TRISA     = 0x00;
     PORTA     = 0x00;
//     TRISB     = 0x00;
//     TRISB     = 0x80;
     TRISB     = 0x01;
     
     //PORTB     = 0x00;
     PORTB     = 0x80;  // 1000 0000

     OPTION_REG &= 0x7F;
     OPTION_REG &= 0xBF;

     INTCON         |= 0x10;
     INTCON         |= 0x80;


		 SD1602_init();

		 SD1602_clear();
		 
//		 strConstCpy(s, s2);

////	   strConstCpy(s, s2);

		 while(1)
		 {
		         // s2
           //strConstCpy(s, s2);
		         
           //SD1602_clear();
		         SD1602_control(0x80);
		         SD1602_print(s);

		         Delay_ms(1000);
		         
		         SD1602_clear();

		         Delay_ms(500);
		         
		         // s1//
//		         strConstCpy(s, s1);
//
//           //SD1602_clear();
//		         SD1602_control(0x80);
//		         SD1602_print(s);
//
//		         Delay_ms(1000);
//
//		         SD1602_clear();
//
//		         Delay_ms(500);



		 }//while(1)

}