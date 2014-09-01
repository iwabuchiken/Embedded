/*
	Receiver
	File: D_85_16F84A_Remote_v_5_3_2.c

*/

#define usi unsigned short int


///////////////////////

// Timer

///////////////////////
#define MS90 TMR0 < 176
#define MS45 TMR0 < 88

#define RESET_TMR TMR0 = 0


///////////////////////

// Output

///////////////////////
#define OUT_OFF PORTA = 0x00

///////////////////////

// Input

///////////////////////
#define PORTB_0_H	(PORTB & 0x01) == 0x01
#define PORTB_1_H	(PORTB & 0x02) == 0x02
#define PORTB_2_H	(PORTB & 0x04) == 0x04
#define PORTB_3_H	(PORTB & 0x08) == 0x08

//#define PORTB_0_H_1_H	(PORTB & 0x03) == 0x03

#define true 1
#define false 0

//////////////////////////////////

// vars

//////////////////////////////////
usi i;
usi custom_code_a, custom_code_b;
usi data_code_a, data_code_b;

usi bit_len = 4;

///////////////////////

// protos

///////////////////////
void _pulsing_u_100(void);

///////////////////////

// funcs

///////////////////////

void
_pulse_Modulation(void)
{

	// Modulation
	PORTA        = 0x01;   // RA0 => on
	Delay_us(9);   // 8.8us

	PORTA        = 0x00;   // RA0 => off
	Delay_us(17);   // 26.3us - 8.8us =% 17us

}

void
_reader(void)
{

	TMR0     = 0;

//	while(TMR0 < 50)         // 9.0ms
//	while(TMR0 < 176)         // 9.0ms
	while(MS90)         // 9.0ms
	{
		// Modulation
		PORTA        = 0x01;   // RA0 => on
		Delay_us(9);   // 8.8us

		PORTA        = 0x00;   // RA0 => off
		Delay_us(17);   // 26.3us - 8.8us =% 17us

	}

	TMR0 = 0;
	PORTA = 0x00;

	while(MS45)       // 4.5ms
//	while(TMR0 < 88)       // 4.5ms
	{

	}

}//void _reader(void)

void
_custom_lower(void)
{
//	usi bit_len = 4;

	custom_code_a = 0x0A;
//	custom_code_a = 0x0A;

	for(i = 0; i < bit_len; i++)
	{

		//////////////////////////////////

		// high

		//////////////////////////////////
		RESET_TMR;

		while(TMR0 < 11)	// 0.56ms
		{
			_pulse_Modulation();

		}

		//////////////////////////////////

		// low

		//////////////////////////////////
		PORTA = 0x00;

		if (((custom_code_a >> i) & 0x01) == 0)
		{

			while(TMR0 < 22)	// 1.125ms
			{

			}

		} else {

			while(TMR0 < 44)	// 2.250ms
			{

			}

		}//if (((custom_code_a >> i) & 0x01) == 0)

	}//for(i = 0; i < bit_len)

}//_custom_lower

void
_Delay_50ms(void) {

	Delay_ms(50);

}

void
_Opearations() {

	while(PORTB_0_H) {
//	while(PORTB & 0x01 == 0x01) {

		///////////////////////

		// Command 1

		///////////////////////
		if ((PORTB_1_H) && !(PORTB_2_H) && !(PORTB_3_H)) {

			_reader();

			_custom_lower();

			// signalling that the custom lower sent
			_pulsing_u_100();
//			_pulsing_u_100;

			// Interval between interrupts
			_Delay_50ms();

		} else {

			OUT_OFF;

		}

	}//while(PORTB_0_H)

}//_Opearations

void interrupt(void)
{
		/*********************************
		 * vars
		**********************************/
//		usi	i;
//		usi	custom_code_a, custom_code_b;
//		usi	data_code_a, data_code_b;
//
//		usi	result;		// receive return value from functinos

		INTCON &= 0x7F;  // interrupt => forbidden
		INTCON &= 0xEF;  // INT interrupt => forbidden
		INTCON &= 0xFD;  // INT interrupt flag => cleared

		_Opearations();

		//////////////////////////////////

		// reset: interruption config

		//////////////////////////////////
		// INTCON => reset
		INTCON |= 0x10;		  // INT interrupt => permitted
		INTCON |= 0x80;

}//void interrupt(void)


void main(void)
{

		// Setup
		TRISA     = 0x00;
		PORTA     = 0x00;		//0000 0010

		TRISB     = 0xFF;		// Input: RB0 ~ RB7

		OPTION_REG &= 0x7F;	// Pull-up => on
		OPTION_REG &= 0xFF;	// INT interrupt => by 0V ~> 5V
//		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V

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

			OUT_OFF;

		}//while(1)

}//void main(void)

void
_pulsing_u_100()
{

	PORTA = 0x00;

	PORTA = 0x01; Delay_us(50);

	PORTA = 0x00; Delay_us(50);

}//_pulsing_u_100
