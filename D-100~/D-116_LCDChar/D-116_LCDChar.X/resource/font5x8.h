#ifndef	_FONT5X8_H_
#define	_FONT5X8_H_


#include	<avr/pgmspace.h>

enum	E_FONT_IDX
{
	E_MON,
	E_TUE,
	E_WED,
	E_THU,
	E_FRI,
	E_SAT,
	E_SUN,
	E_YEAR,
	E_HEI,
	E_SEI,
	E_AM,
	E_PM
};

const	prog_uint8_t	dots[][8] =
{
	{	//��
		0b01111,
		0b01001,
		0b01111,
		0b01001,
		0b01111,
		0b01001,
		0b10001,
		0b00000
	},
	{	//��
		0b00100,
		0b10101,
		0b10101,
		0b00100,
		0b01010,
		0b01010,
		0b10001,
		0b00000
	},
	{	//��
		0b00100,
		0b00101,
		0b11110,
		0b00110,
		0b01101,
		0b10100,
		0b00100,
		0b00000
	},
	{	//��
		0b00100,
		0b00100,
		0b11111,
		0b00100,
		0b01110,
		0b10101,
		0b00100,
		0b00000
	},
	{	//��
		0b01110,
		0b10001,
		0b01110,
		0b11111,
		0b00100,
		0b10101,
		0b11111,
		0b00000
	},
	{	//�y
		0b00100,
		0b00100,
		0b11111,
		0b00100,
		0b00100,
		0b00100,
		0b11111,
		0b00000
	},
	{	//��
		0b11111,
		0b10001,
		0b10001,
		0b11111,
		0b10001,
		0b10001,
		0b11111,
		0b00000
	},
	{	//�N
		0b10000,
		0b11111,
		0b00100,
		0b11111,
		0b10100,
		0b11111,
		0b00100,
		0b00000
	},
	{	//��
		0b11111,
		0b00100,
		0b10101,
		0b00100,
		0b11111,
		0b00100,
		0b00100,
		0b00000
	},
	{	//��
		0b00101,
		0b11111,
		0b10100,
		0b10101,
		0b11010,
		0b11010,
		0b10101,
		0b00000
	},
	{	//AM
		0b00100,
		0b01010,
		0b11111,
		0b10001,
		0b00000,
		0b11011,
		0b10101,
		0b10001
	},
	{	//PM
		0b11110,
		0b10001,
		0b11110,
		0b10000,
		0b00000,
		0b11011,
		0b10101,
		0b10001
	}
};


#endif	//_FONT5X8_H_