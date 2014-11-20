/*
 * LCDモジュール(SC1602) 4bitモードライブラリー  Version 1.00
 * File:        lcd.c
 * Target:      PIC18F14K50 48Mhz
 * コンパイラ:   Microchip MPLAB XC8 C Compiler V1.20
 * 書き込み:     PICKit 3
 * リリース:     2013/09/29 15:00
 *
*/

#ifndef LCD_H
#define	LCD_H

//  制御信号アドレス設定

#define LCD_E       PORTCbits.RC3
#define LCD_RS      PORTCbits.RC2
#define LCD_E_MASK  0b0001000
#define LCD_RS_MASK 0b0000100
#define LCD_ADS     PORTC

#define LCD_CMAX    16 //   液晶横方向文字数
#define LCD_RMAX     2 //   液晶表示行数

#define LCD_CLEAR   0b00000001
#define LCD_CURHOME 0b00000010
#define LCD_ENTRYM  0b00000100
    #define LCD_INC       0b10
    #define LCD_DEC       0b00
    #define LCD_SHIFT      0b1
    #define LCD_NONSHIFT   0b0
#define LCD_DISPM   0b00001000
    #define LCD_DISPON   0b100
    #define LCD_DISPOFF  0b000
    #define LCD_CURON     0b10
    #define LCD_CUROFF    0b00
    #define LCD_BLINKON    0b1
    #define LCD_BLINKOFF   0x0
#define LCD_SHIFTM  0b00010000
#define LCD_FUNCM   0b00100000
    #define LCD_8BIT   0b10000
    #define LCD_4BIT   0b00000
#define LCD_CGADS   0b01000000
#define LCD_DDADS   0b10000000

void lcd_init(void); //  LCD液晶を初期化
void lcd_disp(const unsigned char* buf); //  ホーム位置から文字列を液晶に表示 \nによる複数行および折り返し表示サポート
void lcd_clear(); //  液晶クリア
void lcd_puts(const char* buf); //  カレントアドレスに文字列を書き込む
void lcd_putc(char buf); //  カレントアドレスに1文字書き込む
void lcd_en(unsigned char d); //  液晶表示設定(ブリンク、カーソル制御)
void lcd_ddramxy(unsigned char x,unsigned char y); //  表示用メモリアドレス設定 列と行で指定
void lcd_ddram(unsigned char ads); //  表示用メモリアドレス設定
void lcd_cgram(unsigned char ads,unsigned char* buf); //  ユーザー定義キャラクタを設定
void lcd_out4(unsigned char data); //  4bit出力
void lcd_out8(unsigned char data); //  8bitを4bitに分割して出力

#endif	/* LCD_H */

