#ifndef	_LCDLIB_H_
#define	_LCDLIB_H_


#define		F_CPU	1000000UL	//1MHz

#include	<avr/io.h>
#include	<util/delay.h>


#define	LCD_PORT	PORTB
#define	LCD_DDR		DDRB

//ポートのビットの割り当て（4bitモードが前提）
#define	LCD_DATABITS	0b00001111	//PB3-PB0
#define	LCD_RS	(1 << PB4)	//Register Select	H:data	L:command
#define	LCD_RW	(1 << PB5)	//Read/Write		H:read	L:write
#define	LCD_E	(1 << PB6)	//Enable Signal		H->L:strobe


void	lcdInit();
void	lcdCmd(uint8_t bits);
void	lcdPutChar(uint8_t c);
void	lcdPutStr(const uint8_t* s);
void	lcdPutUInt(uint16_t n);
void	lcdPutInt(int16_t n);
void	lcdDefChar(uint8_t id, const uint8_t* dots);

#define	lcdCls()		lcdCmd(LCD_CMD_CLEAR_DISPLAY)
#define	lcdSetPos(x, y)	lcdCmd(LCD_CMD_SET_DDRAM_ADRS | ((y) ? 0x40 + (x) : (x)))

//Instruction
#define	LCD_CMD_CLEAR_DISPLAY	0b00000001
#define	LCD_CMD_RETURN_HOME		0b00000010
#define	LCD_CMD_ENTRY_MODE		0b00000100
#define	LCD_CMD_DISPLAY_MODE	0b00001000
#define	LCD_CMD_CURSOR_MODE		0b00010000
#define	LCD_CMD_FUNCTION_SET	0b00100000
#define	LCD_CMD_SET_CGRAM_ADRS	0b01000000
#define	LCD_CMD_SET_DDRAM_ADRS	0b10000000

//Instructionのパラメータ
//(LCD_CMD_AAA | LCD_SUBCMD_XXX1 | LCD_SUBCMD_XXX2 | …)の形で使う

//LCD_CMD_ENTRY_MODE						//※以下の説明は間違っているかも知れない
#define	LCD_SUBCMD_INCREMENT	0b00000010	//入力位置を進める（無指定だとDecrement）
#define	LCD_SUBCMD_WITH_SHIFT	0b00000001	//表示シフト動作を伴う（LCD_CMD_CURSOR_MODEも設定する）

//LCD_CMD_DISPLAY_MODE
#define	LCD_SUBCMD_SET_DISPLAY	0b00000100	//画面表示する（無指定だと表示内容を保ったまま画面を消す）
#define	LCD_SUBCMD_SET_CURSOR	0b00000010	//カーソルを表示する
#define	LCD_SUBCMD_CURSOR_BRINK	0b00000001	//カーソルを点滅させる

//LCD_CMD_CURSOR_MODE
#define	LCD_SUBCMD_SHIFT_ON		0b00001000	//DDRAMの変更無しに表示をシフトさせる（無指定だとカーソルを移動させる）
#define	LCD_SUBCMD_RIGHT		0b00000100	//右へシフトさせる（無指定だと左へ）※カーソル移動モード時は意味を持たない

//LCD_CMD_FUNCTION_SET
#define	LCD_SUBCMD_DL8BIT		0b00010000	//Data Length 8-bit（無指定だと4-bitモード）
#define	LCD_SUBCMD_2LINE		0b00001000	//表示で2行使用する（無指定だと1行のみ使用可能になる）
#define	LCD_SUBCMD_FONT5X10		0b00000100	//Font Type 5x10（無指定だと5x8）※SD1602は物理的に5x10が表示できない


#endif	//_LCDLIB_H_
