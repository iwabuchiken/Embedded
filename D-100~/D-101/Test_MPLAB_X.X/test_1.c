/*
 * File:   test_1.c
 * Author: iwabuchik
 *
 * Created on 2014/11/05, 14:26
 */


#include <xc.h>
#include "pic.h"

#define _XTAL_FREQ 20000000

//void main(void) {
//    return;
//}

// ========================== ここから ==============================
// ファイル名　timer0.c
// 作成日　　　2009.8.22
// 更新日　　　2012.5.12
// 作成者　　　mit.ueno
// 機種　　　　PIC16F84A
// CLOCK 　　　20MHz
// コンパイラ　MPLAB XC8
// 概要
//		TMR0のテスト
//		PORTBのLEDを500mS間隔で点滅させる
//TMR0割り込み
//		1/20MHz*4*64*256=3.2768mS
//		TMR0割込み内で500mSの時間を作る
//I/Oポート
//		RB3:LED
//


//#include "pic.h"
//XC8	__CONFIG(HS & WDTDIS & PWRTEN & UNPROTECT);
//__CONFIG(FOSC_HS & WDTE_OFF & PWRTE_ON & CP_OFF);

#pragma config FOSC = HS
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config CP = OFF


static	bit T500mS;	// 500mS経過フラグ
static	unsigned char cnt500mS;	// 500mSカウンタ


// =================== 割り込み処理 ====================
static void interrupt intr(void) {
	TMR0IF = 0;	// TMR0割り込みクリア
//	T0IF = 0;	// TMR0割り込みクリア

	cnt500mS--;
	if	(cnt500mS == 0) {
		cnt500mS = 153;	// 3.2768mS*153=501mS
		T500mS = 1;		// 500mSフラグセット
	}
}

// ==================== メイン処理 =======================
main()	{
	TRISB = 0x00;	// RB3:output
//	TRISB = 0xF7;	// RB3:output

//XC8	OPTION = 0x85;	// プリスケーラ:64
//	OPTION_REG = 0x85;	// プリスケーラ:64
//	TMR0 = 0x00;
//	TMR0IE = 1;		// TMR0割り込み許可
////	T0IE = 1;		// TMR0割り込み許可
//	GIE = 1;		// 全体割り込み許可

	PORTB = 0x00;

	cnt500mS = 153;	// 3.2768mS*153=501mS
	T500mS = 0;

	while(1) {

            //REF binary http://www.microchip.com/forums/m504764.aspx
            PORTB = 0b00000001;

            __delay_ms(500);
            
            PORTB = 0b00000000;

            __delay_ms(500);
            
//		if  (T500mS) {
//			T500mS = 0;
//			PORTB ^= 0x08;	// RB3のLEDを点滅
//		}
	}
}
// ========================== ここまで ==============================