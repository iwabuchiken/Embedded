#ifndef	_LCDLIB_H_
#define	_LCDLIB_H_


#define		F_CPU	1000000UL	//1MHz

#include	<avr/io.h>
#include	<util/delay.h>


#define	LCD_PORT	PORTB
#define	LCD_DDR		DDRB

//�|�[�g�̃r�b�g�̊��蓖�āi4bit���[�h���O��j
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

//Instruction�̃p�����[�^
//(LCD_CMD_AAA | LCD_SUBCMD_XXX1 | LCD_SUBCMD_XXX2 | �c)�̌`�Ŏg��

//LCD_CMD_ENTRY_MODE						//���ȉ��̐����͊Ԉ���Ă��邩���m��Ȃ�
#define	LCD_SUBCMD_INCREMENT	0b00000010	//���͈ʒu��i�߂�i���w�肾��Decrement�j
#define	LCD_SUBCMD_WITH_SHIFT	0b00000001	//�\���V�t�g����𔺂��iLCD_CMD_CURSOR_MODE���ݒ肷��j

//LCD_CMD_DISPLAY_MODE
#define	LCD_SUBCMD_SET_DISPLAY	0b00000100	//��ʕ\������i���w�肾�ƕ\�����e��ۂ����܂܉�ʂ������j
#define	LCD_SUBCMD_SET_CURSOR	0b00000010	//�J�[�\����\������
#define	LCD_SUBCMD_CURSOR_BRINK	0b00000001	//�J�[�\����_�ł�����

//LCD_CMD_CURSOR_MODE
#define	LCD_SUBCMD_SHIFT_ON		0b00001000	//DDRAM�̕ύX�����ɕ\�����V�t�g������i���w�肾�ƃJ�[�\�����ړ�������j
#define	LCD_SUBCMD_RIGHT		0b00000100	//�E�փV�t�g������i���w�肾�ƍ��ցj���J�[�\���ړ����[�h���͈Ӗ��������Ȃ�

//LCD_CMD_FUNCTION_SET
#define	LCD_SUBCMD_DL8BIT		0b00010000	//Data Length 8-bit�i���w�肾��4-bit���[�h�j
#define	LCD_SUBCMD_2LINE		0b00001000	//�\����2�s�g�p����i���w�肾��1�s�̂ݎg�p�\�ɂȂ�j
#define	LCD_SUBCMD_FONT5X10		0b00000100	//Font Type 5x10�i���w�肾��5x8�j��SD1602�͕����I��5x10���\���ł��Ȃ�


#endif	//_LCDLIB_H_
