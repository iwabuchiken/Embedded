/*
	Receiver
	File: D_85_16F84A_Remote_v_5_3_2.c

*/

#define usi unsigned short int

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////

///////////////////////

// protos

///////////////////////
void interrupt(void);
void _main_Setup(void);

///////////////////////

// funcs

///////////////////////
void main(void)
{

	_main_Setup();

	while(1)
	{

		PORTA = 0x01;

		Delay_us(10);

		PORTA = 0x02;

		Delay_us(10);

//		PORTA = 0x01;
//
//		Delay_ms(50);
//
//		PORTA = 0x02;
//
//		Delay_ms(50);

	}//while(1)

}//void main(void)

void
interrupt(void) {

	INTCON &= 0x7F;		// forbid global interrupt
	INTCON &= 0xDF;		// forbid timer interrupt
	INTCON &= 0xFB;		// clear timer interrupt flag

	///////////////////////

	// change LED

	///////////////////////
//	PORTA = 0x01;
//
//	PORTA = 0x02;

	PORTA ^= 0x03;

	///////////////////////

	// INTCON

	///////////////////////
	INTCON |= 0x20;
	INTCON |= 0x80;

}//interrupt

void
_main_Setup(void) {

	TRISA	= 0x00;
	TRISB	= 0x00;

	PORTB	= 0x01;
//	PORTB	= 0x00;

	///////////////////////

	// ANSEL

	///////////////////////
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
	INTCON &= 0xFB;		// clear timer interrupt flag

	INTCON |= 0x20;
	INTCON |= 0x80;

}//_main_Setup
