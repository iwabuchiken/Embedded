#define _LEGACY_HEADERS
#include "pic.h"
#include "stdlib.h"
#define _XTAL_FREQ 4000000
__CONFIG(CCPRB3 & DEBUGDIS & LVPDIS & BOREN & MCLRDIS & PWRTEN & WDTDIS & INTIO);

void main() {

	OSCCON = 0b0110000; // 内蔵OSC 4MHz
//	ADCS2 = 0;	//AD変換クロック値設定
//	ADCS1 = 0;
//	ADCS0 = 1;
//	ADFM = 1; // AD変換結果は右詰めで格納
//	VCFG1 = 0; // 基準電圧はVddとVss
//	VCFG0 = 0;
	ANSEL = 0b00000000; // RA0(AN0)はアナログ
	TRISA = 0b00000000; // RA0(AN0)入力
	TRISB = 0b00000000; // すべて出力
	PORTA = 0b00000000;
	PORTB = 0b00000000;
	
	while(1) {

		PORTA = 0x01;

		__delay_ms(50);

		PORTA = 0x02;

		__delay_ms(50);

	}

}
