/*
 * Sender
 */
#define usi unsigned short int

#define MS90 TMR0 < 176
#define MS45 TMR0 < 88

#define RESET_TMR TMR0 = 0

//////////////////////////////////

// vars

//////////////////////////////////
usi i;
usi custom_code_a, custom_code_b;
usi data_code_a, data_code_b;

//////////////////////////////////

// funcs

//////////////////////////////////
void _pulse(void)
{

	// Modulation
	PORTA        = 0x01;   // RA0 => on
	Delay_us(9);   // 8.8us

	PORTA        = 0x00;   // RA0 => off
	Delay_us(17);   // 26.3us - 8.8us =% 17us

}

void _reader(void)
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

void _custom_lower(void)
{
	usi bit_len = 4;

	custom_code_a = 0x0A;

	for(i = 0; i < bit_len; i++)
	{

		//////////////////////////////////

		// high

		//////////////////////////////////
		RESET_TMR;

		while(TMR0 < 11)	// 0.56ms
		{
			_pulse();

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

void main(void)
{
//	usi i;
//	usi custom_code_a, custom_code_b;
//	usi data_code_a, data_code_b;

	// Setup
	TRISA     = 0x00;
	PORTA     = 0x00;		//0000 0010

	TRISB     = 0x00;		// Input: RB0 ~ RB7
	PORTB     = 0x00;

	OPTION_REG &= 0xDF;	// Timer by clock
	OPTION_REG &= 0xF0;	// Prescaler => on
	OPTION_REG |= 0x07;	// Prescaler => 1/256

	custom_code_a = 0xFF;
	custom_code_b = 0x00;
	data_code_a   = 0x00;   // Button '+'
	data_code_b   = ~data_code_a;

	while(1)
	{
		/*********************
		  Reader
		**********************/
		_reader();

		/*********************
		Custom code: lower 8 bits
		**********************/
		_custom_lower();

		/*********************
		Custom code: upper 8 bits
		**********************/

	}//while(1)

}//void main(void)

//REF show value window http://www.mikroe.com/download/eng/documents/compilers/mikroc/pro/pic/help/debug_windows.htm#watch_window
