/*
 * LCDモジュール(SC1602) 4bitモードライブラリー  Version 1.00
 * File:        lcd.c
 * Target:      PIC18F14K50 48Mhz
 * コンパイラ:   Microchip MPLAB XC8 C Compiler V1.20
 * 書き込み:     PICKit 3
 * リリース:     2013/09/29 15:00
 *
*/

#include <p18f14k50.h>
#include <plib\delays.h>
#include "lcd.h"

//  LCD液晶を初期化

void lcd_init(void){
    Delay1KTCYx(180);  //  15ms*(48MHz/4)=180,000

    LCD_RS=0;
    lcd_out4( LCD_FUNCM | LCD_8BIT ); //  8bit
    Delay1KTCYx( 60);  //   5ms*(48MHz/4)= 60,000

    lcd_out4( LCD_FUNCM | LCD_8BIT ); //  8bit
    Delay1KTCYx( 48);  //   4ms*(48MHz/4)= 48,000

    lcd_out4(  LCD_FUNCM | LCD_8BIT ); //  8bit
    Delay1KTCYx( 48);  //   4ms*(48MHz/4)= 48,000

    lcd_out4( LCD_FUNCM | LCD_4BIT); //  4bit
    Delay1KTCYx( 48);  //   4ms*(48MHz/4)= 48,000

    lcd_out8( LCD_FUNCM | LCD_4BIT | 0b1000 ); //  動作モード 4bit 1/Duty 5*7dot
    Delay1KTCYx( 48);  //   4ms*(48MHz/4)= 48,000

    lcd_out8( LCD_DISPM | LCD_DISPON | LCD_CURON | LCD_BLINKOFF ); // 表示on
    Delay1KTCYx( 2);  //  0.167ms*(48MHz/4)=  2,000 6th

    lcd_out8( LCD_ENTRYM | LCD_INC | LCD_NONSHIFT); // エントリーモード
    Delay1KTCYx( 2);  //  0.167ms*(48MHz/4)=  2,000

    lcd_clear();
}

//  液晶クリア

void lcd_clear(void){
    LCD_RS=0;
    lcd_out8( LCD_CLEAR );
    Delay1KTCYx(24);  //  2ms*(48MHz/4)=  24,000
}

//  液晶表示設定(ブリンク、カーソル制御)

void lcd_en(unsigned char d){
    LCD_RS=0;
    lcd_out8( LCD_DISPM | d);
    Delay10TCYx(48);  //  40μs*(48MHz/4)=  480
}

//  カレントアドレスに文字列を書き込む

void lcd_puts(const char* buf){
    LCD_RS=1;
    while(*buf){
        lcd_out8(*buf);
        Delay10TCYx(60);  //  50μs*(48MHz/4)=  600
        ++buf;
    }
}

//  カレントアドレスに1文字書き込む

void lcd_putc(unsigned char c){
    LCD_RS=1;
    lcd_out8(c);
    Delay10TCYx(60);  //  50μs*(48MHz/4)=  600
}

//  表示用メモリアドレス設定

void lcd_ddram(unsigned char ads){
    LCD_RS=0;
    lcd_out8( LCD_DDADS | ads );
    Delay10TCYx(48);  //  40μs*(48MHz/4)=  480
}

//  表示用メモリアドレス設定 列と行で指定

void lcd_ddramxy(unsigned char x,unsigned char y){
    unsigned char ads = 0x40*y - (2<=y ? (0x40*2-0x14) : 0)+x;
    lcd_ddram(ads);
}

//  ユーザー定義キャラクタを設定
//  adsはキャラクターコード*8で設定する

void lcd_cgram(unsigned char ads,unsigned char* buf){
    LCD_RS=0;
    lcd_out8( LCD_CGADS | ads );
    Delay1TCYx(480);  //  40μs*(48MHz/4)=  480
    LCD_RS=1;
    for(int n=0;n<8;n++){
       lcd_out8( buf[n] );
        Delay10TCYx(48);  //  40μs*(48MHz/4)=  480
    }
}

//  ホーム位置から文字列を液晶に表示 \nによる複数行および折り返し表示サポート

void lcd_disp(const unsigned char* buf){
    const unsigned char* p=buf;
    unsigned char x=0;    //  列位置
    unsigned char y=0;    //  行位置
    LCD_RS=0;
    lcd_out8( LCD_CURHOME );
    Delay1KTCYx( 24);  //  2ms*(48MHz/4)=  24,000

    LCD_RS=1;
    while(*p){
        if(x==LCD_CMAX || *p=='\n'){
            ++y;
            lcd_ddramxy(0,y);
            Delay10TCYx(60);  //  50μs*(48MHz/4)=  600
            LCD_RS=1;
            x=0;
        }
        if(*p!='\n'){
            lcd_out8(*p);
            Delay10TCYx(60);  //  50μs*(48MHz/4)=  600
            ++x;
        }
        ++p;
   }
}

//  4bit出力

void lcd_out4(unsigned char data){
    unsigned char t1;
    LCD_ADS=(LCD_ADS & 0x0f) | (data & 0xf0);
    LCD_E=1;
    Delay1TCY();
    Delay1TCY();
    Delay1TCY();
    LCD_E=0;
}

//  8bitを4bitに分割して出力

void lcd_out8(unsigned char data){
    lcd_out4(data);
    lcd_out4(data<<4);
}
