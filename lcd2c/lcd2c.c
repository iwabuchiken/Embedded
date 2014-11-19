/*
 * LCDモジュールのユーザー定義キャラクタの使用例  Version 1.00
 * File:        lcd2c.c
 * Target:      PIC18F14K50 48Mhz
 * コンパイラ:   Microchip MPLAB XC8 C Compiler V1.20
 * 書き込み:     PICKit 3
 * リリース:     2013/10/9 21:00
 *
 * 表示例
 *
 *   1行目    CGRAM ■◆◆
 *   2行目    ■■■■
 *
 *   ■◆がユーザー定義キャラクタを使用しています。
 * 　1行目の■は液晶表示では網掛けとなります
 *   2行目の■は縦の長さが時間とともに変化します。
*/

#include <stdio.h>
#include <stdlib.h>
#include <p18f14k50.h>
#include <plib\delays.h>
#include "lcd.h"

#pragma config  FOSC = HS,CPUDIV = NOCLKDIV,PLLEN=ON,WDTEN=OFF,LVP=OFF

unsigned char lcd_font1[]={  // 50% ハッチ
    0b00010100,
    0b00001010,
    0b00010100,
    0b00001010,
    0b00010100,
    0b00001010,
    0b00010100,
    0b00000000 };

unsigned char lcd_font2[]={ // □
    0b00011111,
    0b00010001,
    0b00010001,
    0b00010001,
    0b00010001,
    0b00010001,
    0b00011111,
    0b00000000 };

unsigned char lcd_font3[]={ // ◆
    0b00000000,
    0b00000100,
    0b00001110,
    0b00011111,
    0b00001110,
    0b00000100,
    0b00000000,
    0b00000000 };

unsigned char lcd_font4[8]; // プログラムで書き換える

void main(void) {
    signed char data;

    ANSEL=0;
    ANSELH=0;
    SLRCON=0;
    TRISA=0;
    TRISB=0b11110000;
    TRISC=0;
    PORTC=0;

    lcd_init();
            //0123456789abcdef  0123456789abcdef
    lcd_disp("HelloPIC18F14K50\nXC8 LCD SAMPLE ");

    lcd_disp(rs232c_buf);

        Delay10KTCYx(240);
        Delay10KTCYx(240);
        Delay10KTCYx(240);
        Delay10KTCYx(240);

        lcd_clear();

    lcd_cgram(0x00,lcd_font3);
    lcd_cgram(0x08,lcd_font2);
    lcd_cgram(0x10,lcd_font1);
    lcd_cgram(0x18,lcd_font3);
        
    lcd_ddramxy(0,0);
    lcd_puts("CGRAM \x2\x3");
    lcd_putc(0);

    lcd_ddramxy(0,1);
    lcd_puts("\x1\x1\x1\x1");
    lcd_en(LCD_DISPON | LCD_BLINKON);

      for(;;){
        for(int n=0;n<7;n++){

            for(int y=0;y<8;y++)
                lcd_font4[y]=0;
            for(int y=0;y<n;y++){
                lcd_font4[6-y]=0b00011111;
            }
            lcd_cgram(0x08,lcd_font4);
            
            Delay10KTCYx(240);

        }
      }
}

