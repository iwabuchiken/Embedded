/*
	Receiver

*/

#define usi unsigned short int
#define PASSED_4_5_ms TMR0 < 68 || TMR0 > 108
#define LED_1_ON PORTA = 0x01
#define LED_1_OFF PORTA = 0x00

usi color;

usi LED_FLAG = 1;

void _pulse_2(void)
{

		 PORTA = 0x01; Delay_ms(1);

		 PORTA = 0x00; Delay_ms(1);

		 PORTA = 0x01; Delay_ms(1);

		 PORTA = 0x00; Delay_ms(1);

}

void _pulse_3(void)
{

		 PORTA = 0x01; Delay_ms(1);
		 PORTA = 0x00; Delay_ms(1);

		 PORTA = 0x01; Delay_ms(1);
		 PORTA = 0x00; Delay_ms(1);

		 PORTA = 0x01; Delay_ms(1);
		 PORTA = 0x00; Delay_ms(1);

}

//void _pulse_2(void);
//void _pulse_3(void);
void interrupt(void)
{
		 usi i;
		 usi custom_code_a, custom_code_b;
		 usi data_code_a, data_code_b;
		 
		 INTCON &= 0x7F;  // interrupt => forbidden
		 INTCON &= 0xEF;  // INT interrupt => forbidden
		 INTCON &= 0xFD;  // INT interrupt flag => cleared

 		 /*********************
		   Reader
		 **********************/
		 TMR0 = 0;

		 // RB0 => off(i.e. 5V -> 0V)
     // Notice: Pullup is on
     // => hence, no signal means 5V
     //    at the pin
		 while((PORTB & 0x01) == 0) //---------------------
		 {
        // Check: Time out?
    //if(TMR0 = 255)
        if(TMR0 == 255)
				{
           // Exit from the check process
           
           _pulse_3();
           
					 break;
				}

     }//while((PORTB & 0x01) == 0)

		 // 9.0ms => passed?
		 // If less than 9.0 or more
		 // => return: i.e. exit from interrupt process

		 if(TMR0 < 156) //---------------------
		 {

					 INTCON |= 0x10;        // INT interrupt => permitted
					 INTCON |= 0x80;        // interrupt => permitted

					 //debug
					 PORTA = 0x01;
					 Delay_ms(1);
					 PORTA = 0x00;

					 return;                // return

//		 } else if (TMR0 > 196 || TMR0 < 200) {
//
//					 INTCON |= 0x10;        // INT interrupt => permitted
//					 INTCON |= 0x80;        // interrupt => permitted
//
//					 //debug
//					 _pulse_3();
//
//					 return;                // return
     } else if (TMR0 > 196) {
     
					 INTCON |= 0x10;        // INT interrupt => permitted
					 INTCON |= 0x80;        // interrupt => permitted

					 //debug
					 _pulse_2();
					 

		 }

		 PORTA = 0x01;


//		 if(TMR0 < 156 || TMR0 > 196) //---------------------
//		 {
//
//					 INTCON |= 0x10;        // INT interrupt => permitted
//					 INTCON |= 0x80;        // interrupt => permitted
//
//					 //debug
//					 PORTA = 0x01;
//					 Delay_ms(1);
//					 PORTA = 0x00;
//
//					 return;                // return
//		 }
//
//		 PORTA = 0x01;
//		 // Timer => reset
//		 TMR0 = 0;
//
//		 // Check: time out?
//		 while((PORTB & 0x01) == 1) //---------------------
//		 {
//        // Check: Time out?
//				if(TMR0 = 255)
//				{
//           // Exit from the check process
//					 break;
//				}
//
//     }//while((PORTB & 0x01) == 0)
//
//		 // 4.5ms => passed?
//		 // If less than 4.5 or more
//		 // => return: i.e. exit from interrupt process
//   //if(PASSED_4_5_ms) //---------------------
//     if(TMR0 < 68 || TMR0 > 108) //---------------------
//		 {
//
//					 INTCON |= 0x10;        // INT interrupt => permitted
//					 INTCON |= 0x80;        // interrupt => permitted
//
//					 return;                // return
//		 }
//
//     PORTA = 0x01;
//
////		 // LED on/off
////		 if(LED_FLAG == 1)
////		 {
//////		     LED_1_ON;
////         PORTA = 0x01;
////
////		     LED_FLAG *= -1;
////
////		 } else {
////
//////		     LED_1_OFF;
////         PORTA = 0x00;
////
////		     LED_FLAG *= -1;
////
////		 }//if(LED_FLAG == 1)
		 // INTCON => reset
		 INTCON |= 0x10;        // INT interrupt => permitted
  	 INTCON |= 0x80;

}//void interrupt(void)


void main(void)
{

		 // Setup
     TRISA     = 0x00;
     PORTA     = 0x00;		//0000 0010

     TRISB     = 0xFF;		// Input: RB0 ~ RB7

		 OPTION_REG &= 0x7F;	// Pull-up => on
     OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V

		 OPTION_REG &= 0xDF;	// Timer by clock
		 OPTION_REG &= 0xF0;	// Prescaler => on
		 OPTION_REG |= 0x07; // Prescaler => 1/256
		 

//     custom_code_a = 0xFF;
//     custom_code_b = 0x00;
//     data_code_a   = 0x00;   // Button '+'
//     data_code_b   = ~data_code_a;

		 INTCON |= 0x10;        // INT interrupt => permitted
  	 INTCON |= 0x80;

     while(1)
     {
     
//        PORTA = 0x01;
        

	   }//while(1)

}//void main(void)

//void _pulse_2(void)
//{
//
//		 PORTA = 0x01; Delay_ms(1);
//
//		 PORTA = 0x00; Delay_ms(1);
//
//		 PORTA = 0x01; Delay_ms(1);
//
//		 PORTA = 0x00; Delay_ms(1);
//
//}
//
//void _pulse_3(void)
//{
//
//		 PORTA = 0x01; Delay_ms(1);
//		 PORTA = 0x00; Delay_ms(1);
//
//		 PORTA = 0x01; Delay_ms(1);
//		 PORTA = 0x00; Delay_ms(1);
//
//		 PORTA = 0x01; Delay_ms(1);
//		 PORTA = 0x00; Delay_ms(1);
//
//}
//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window
