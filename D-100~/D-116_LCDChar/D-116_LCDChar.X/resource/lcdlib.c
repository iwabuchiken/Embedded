//WinAVR-20080610	-Os
//ATtiny2313

#include	"lcdlib.h"

static	uint8_t	kbuf[5] = {0};	//{6,5,5,3,5}	lcdPutUInt()で使用

//private
void	lcdCmd4bit(uint8_t data)
{
	LCD_PORT = LCD_E | data;	//dataは4bitであることが前提
	_delay_ms(1);
	LCD_PORT &= ~LCD_E;
	_delay_ms(1);
}

void	lcdCmd(uint8_t data)
{
	lcdCmd4bit((data >> 4) & 0x0F);	//上位4bit
	lcdCmd4bit(data & 0x0F);		//下位4bit
}

void	lcdInit()
{
	LCD_DDR = LCD_E | LCD_RW | LCD_RS | LCD_DATABITS;
	
	_delay_ms(15);
	lcdCmd4bit(0b0011);
	_delay_ms(5);
	lcdCmd4bit(0b0011);
	_delay_us(100);
	lcdCmd4bit(0b0011);
	
	lcdCmd4bit(0b0010);		//4-bitモードへ移行
	
	//   bit:76543210
	lcdCmd(0b00101000);		//Function Set	[bit:5]	DL=4-bit(0), N=2lines(1), F=5x8dots(0), *(0), *(0)
	lcdCmd(0b00001000);		//Display Set	[bit:3]	D=Set Display:NO(0), C=Set Cursor:NO(0), B=Cursor Blink:NO(0)
	lcdCmd(0b00001100);		//Display Set	[bit:3]	D=Set Display:YES(1), C=Set Cursor:NO(0), B=Cursor Blink:NO(0)
	lcdCmd(0b00000001);		//Clear Display	[bit:0]
	lcdCmd(0b00000110);		//Entry Mode	[bit:2]	I/D=Increment(1), S=With Display Shift:NO(0)
}

void	lcdPutChar(uint8_t c)
{
	LCD_PORT = LCD_RS | LCD_E | ((c >> 4) & 0x0F);	//上位4bit
	_delay_us(100);
	LCD_PORT &= ~LCD_E;
	_delay_us(100);
	
	LCD_PORT = LCD_RS | LCD_E | (c & 0x0F);		//下位4bit
	_delay_us(100);
	LCD_PORT &= ~LCD_E;
	_delay_us(100);
	LCD_PORT = 0;	//LCD_PORT &= ~LCD_RS;	データ4bitを0にしても問題ないので（むしろ省電力？）簡単のため「=0」とする
	_delay_us(100);
}

void	lcdPutStr(const uint8_t* s)
{
	while (*s != 0)
	{
		lcdPutChar(*s);
		s++;
	}
}

void	lcdPutUInt(uint16_t n)
{
	uint8_t	i = 0;
	
	do
	{
		kbuf[i++] = n % 10;
		n /= 10;
	}
	while (0 < n);
	
	while (i != 0)
		lcdPutChar('0' + kbuf[--i]);
}

void	lcdPutInt(int16_t n)
{
	if (n < 0)
	{
		lcdPutChar('-');
		n = -n;
	}
	lcdPutUInt(n);
}

void	lcdDefChar(uint8_t id, const uint8_t* dots)
{
	//id:	0-7（キャラクタコード）
	//dots:	uint8_t[8]（5x8のドットパターン）
	uint8_t	i;
	for (i = 0; i < 8; i++)
	{
		lcdCmd(LCD_CMD_SET_CGRAM_ADRS | (id << 3) | i);
		lcdPutChar(dots[i]);
	}
}
