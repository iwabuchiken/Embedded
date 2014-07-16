/*
	Receiver

*/

#define usi unsigned short int
#define PASSED_4_5_ms TMR0 < 68 || TMR0 > 108
#define LED_1_ON PORTA = 0x01
#define LED_1_OFF PORTA = 0x00

#define true 1
#define false 0


usi color;

usi LED_FLAG = 1;

void _pulse(int num)
{
		int	i;

		for(i = 0; i < num; i++)
		{

			PORTA = 0x01; Delay_ms(1);

			PORTA = 0x00; Delay_ms(1);

		}

}

void _while_PORTB_0x01(int num)
{

	while((PORTB & 0x01) == num) //---------------------
	{
		// Check: Time out?
		if(TMR0 == 255)
		{
			// Exit from the check process

			_pulse(3);

//			break;
			return;

		}

	}//while((PORTB & 0x01) == 0)

	return;

}

/*********************************
 * @return false => either lower than low, or
 * 			higher than high
**********************************/
int _judge_TMR_(int low, int high) {

	if(TMR0 < low) //---------------------
	{

		INTCON |= 0x10;        // INT interrupt => permitted
		INTCON |= 0x80;        // interrupt => permitted

		//debug
//		PORTA = 0x01;
//		Delay_ms(1);
//		PORTA = 0x00;

		_pulse(1);

		return false;                // return

//		} else if (TMR0 > 196 || TMR0 < 200) {
//
//					INTCON |= 0x10;        // INT interrupt => permitted
//					INTCON |= 0x80;        // interrupt => permitted
//
//					//debug
//					_pulse_3();
//
//					return;                // return
	} else if (TMR0 > high) {

		INTCON |= 0x10;        // INT interrupt => permitted
		INTCON |= 0x80;        // interrupt => permitted

		//debug
		_pulse(2);

		return false;

	}

	return true;

}//int _judge_TMR_(int low, int high)

void _response(void)
{

	_pulse(4);

//	if(LED_FLAG == 1)
//	{
////		    LED_1_ON;
//		PORTA = 0x01;
//
//		LED_FLAG *= -1;
//
//	} else {
//
////		    LED_1_OFF;
//
//		PORTA = 0x00;
//		Delay_ms(1);
//		_pulse(2);
//
//		LED_FLAG *= -1;
//
//	}//if(LED_FLAG == 1)

}

void interrupt(void)
{
		/*********************************
		 * vars
		**********************************/
		usi	i;
		usi	custom_code_a, custom_code_b;
		usi	data_code_a, data_code_b;

		usi	result;		// receive return value from functinos

		INTCON &= 0x7F;  // interrupt => forbidden
		INTCON &= 0xEF;  // INT interrupt => forbidden
		INTCON &= 0xFD;  // INT interrupt flag => cleared

		/////////////////////////////////////////////////

		// Reader

		/////////////////////////////////////////////////

		//////////////////////////////////

		// 9.0 ms

		//////////////////////////////////
		TMR0 = 0;

		// RB0 => off(i.e. 5V -> 0V)
		// Notice: Pullup is on
		// => hence, no signal means 5V
		//    at the pin

		/*********************************
		 * listen: PORTB
		**********************************/
		_while_PORTB_0x01(0);

		// 9.0ms => passed?
		// If less than 9.0 or more
		// => return: i.e. exit from interrupt process

		//////////////////////////////////

		// judge

		//////////////////////////////////
		result = _judge_TMR_(156, 196);

		if (result == false) {

//			_pulse(1);

			return;

		}

		//////////////////////////////////

		// 4.5 ms

		//////////////////////////////////
		//////////////////////////////////

		// Reset: TMR0

		//////////////////////////////////
		TMR0 = 0;

		//////////////////////////////////

		// Listen

		//////////////////////////////////
		_while_PORTB_0x01(1);

		//////////////////////////////////

		// judge

		//////////////////////////////////
		result = _judge_TMR_(68, 108);

		if (result == false) {

//			_pulse(1);

			return;

		}

		//////////////////////////////////

		// Response

		//////////////////////////////////
		_response();

		//////////////////////////////////

		// reset: interruption config

		//////////////////////////////////
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
