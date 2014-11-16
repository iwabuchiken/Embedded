#include "SD1602_4bit_mode.h"

#define usi unsigned short int

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////

///////////////////////

// protos

///////////////////////
//void interrupt(void);
void _main_Setup(void);

///////////////////////

// funcs

///////////////////////
void main(void)
{

//	_main_Setup();

   char s[] = "Hello";
   
   TRISA = 0x00;
   PORTA = 0x00;

   TRISB = 0x00;
   PORTB = 0x00;

 	///////////////////////

	// ANSEL

	///////////////////////
	ADCON0 = 0x00;

	ANSEL = 0;


   SD1602_init();

	while(1)
	{
     SD1602_clear();
     SD1602_control(0x80);
     
     SD1602_print(s);
     
     Delay_ms(1000);
     
     SD1602_clear();
     SD1602_control(0xC0);

     SD1602_print(s);

     Delay_ms(1000);


	}//while(1)

}//void main(void)


void
_main_Setup(void) {

	TRISA	= 0x00;
	TRISB	= 0x00;

	PORTA	= 0x00;

	PORTB	= 0x01;
//	PORTB	= 0x00;

	///////////////////////

	// ANSEL

	///////////////////////
	ADCON0 = 0x00;

	ANSEL = 0;

	///////////////////////

	// timer

	///////////////////////
	OPTION_REG	&= 0x7F;	// enable pull-up	0111 1111
	OPTION_REG	&= 0xDF;	// internal clock	1101 1111


	TMR0	= 0;

	///////////////////////

	// interrupt

	///////////////////////
//	INTCON &= 0xFB;		// clear timer interrupt flag

	INTCON |= 0x20;
	INTCON |= 0x80;

}//_main_Setup
