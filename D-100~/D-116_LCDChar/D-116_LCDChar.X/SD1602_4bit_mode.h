#ifndef SD1602_4BIT_H
#define SD1602_4BIT_H

#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

#define RS	RA1	// PORTA,RA1
#define ENABLE	RA0	// PORTA,RA0

//#define _XTAL_FREQ 20000000

void SD1602_write(char c, char r) {
  PORTB = c & 0xF0; /* RB4～RB7にデータの上位4bitをセットする */

  if (r == 1) /* 文字コードの場合 */
  {
    PORTA |= 0x02; /* RSを1にする */
  }
  else /* 制御コードの場合 */
  {
    PORTA &= 0xFD; /* RSを0にする */
  }

  PORTA &= 0xFE; /* Eを0にする */
  __delay_us(1); /* 1us（40ns以上）の時間待ち */
  PORTA |= 0x01; /* Eを1にする */
  __delay_us(1);  /* 1us（230ns以上）の時間待ち */
  PORTA &= 0xFE; /* Eを0にする */

}

void SD1602_write_2(char c, char r) {
  PORTB = c & 0xF0; /* RB4～RB7にデータの上位4bitをセットする */

  if (r == 1) /* 文字コードの場合 */
  {
    PORTA |= 0x02; /* RSを1にする */
  }
  else /* 制御コードの場合 */
  {
    PORTA &= 0xFD; /* RSを0にする */
  }

  PORTA &= 0xFE; /* Eを0にする */
  __delay_us(1); /* 1us（40ns以上）の時間待ち */
  PORTA |= 0x01; /* Eを1にする */
  __delay_us(1);  /* 1us（230ns以上）の時間待ち */
  PORTA &= 0xFE; /* Eを0にする */

}

void SD1602_display(char c) {
  SD1602_write(c, 1); /* 文字コードの上位4bitを渡す */
  SD1602_write(c << 4, 1); /* 文字コードの下位4bitを渡す */
  __delay_us(50); /* 50us（40us以上）の時間待ち */
}

void SD1602_control(char c) {

  SD1602_write(c, 0); /* 制御コードの上位4bitを渡す */
  SD1602_write(c << 4, 0); /* 制御コードの下位4bitを渡す */
  __delay_us(50); /* 50us（40us以上）の時間待ち */

}

void SD1602_clear(void) {

  SD1602_write(0x01, 0); /* 制御コードの上位4bitを渡す */
  SD1602_write(0x01 << 4, 0); /* 制御コードの下位4bitを渡す */
  __delay_ms(2); /* 2ms（1.64ms以上）の時間待ち */

}

void SD1602_init(void) {

  __delay_ms(20); /* 20ms（15ms以上）の時間待ち */
  SD1602_write(0x30, 0); /* 8bitモード設定 */
  __delay_ms(5); /* 5ms（4.1ms以上）の時間待ち */
  SD1602_write(0x30, 0); /* 8bitモード設定 */
  __delay_ms(5); /* 5ms（100us以上）の時間待ち */
  SD1602_write(0x30, 0); /* 8bitモード設定 */
  __delay_ms(5); /* 5ms（4.1ms以上）の時間待ち */
  SD1602_write(0x20, 0); /* 4bitモード設定 */
  __delay_ms(5); /* 5ms（40us以上）の時間待ち */

  SD1602_control(0x28); /* 4bitモードで2行表示に設定する */
  SD1602_control(0x08); /* テキスト表示をオフにする */
  SD1602_control(0x0C); /* テキスト表示をオンにする */
  SD1602_control(0x06); /* カーソル移動を右方向に設定する */

}

void SD1602_print(char *s) {
  while (*s != 0x00) /* ナル文字（0x00）があらわれるまで */
  {
    SD1602_display(*s); /* テキストデータを表示する */
    s++;
  }
}

//REF http://homepage3.nifty.com/mitt/pic/pic5_17_1.html
void
SD1602_init_2(void) {

	__delay_ms(20);

	PORTAbits.RS		= 0;
	PORTAbits.ENABLE	= 0;

	///////////////////////

	// 8-bit: 1

	///////////////////////
//	PORTB = PORTB & 0x0F;	// get upper 4 bits
//	PORTB = PORTB | 0x30;	// set 03h to the upper
//							//	=> lower 4 bits unchanged
//
//	PORTAbits.ENABLE	= 0;
//	__delay_us(1);
//
//	PORTAbits.ENABLE	= 1;
//	__delay_us(1);
//
//	PORTAbits.ENABLE	= 0;

	SD1602_write(0x30, 0); /* 8bitモード設定 */

	__delay_ms(5);			// wait: 5 ms

	///////////////////////

	// 8-bit: 2

	///////////////////////
	SD1602_write(0x30, 0); /* 8bitモード設定 */

	__delay_ms(5);			// wait: 5 ms

	///////////////////////

	// 8-bit: 3

	///////////////////////
	SD1602_write(0x30, 0); /* 8bitモード設定 */

	__delay_ms(5);			// wait: 5 ms

	///////////////////////

	// 4-bit

	///////////////////////
	SD1602_write(0x20, 0); /* 4bitモード設定 */

	__delay_ms(1);			// wait: 1 ms

	///////////////////////

	// settings

	///////////////////////
	SD1602_control(0x28);	// function setting
							// 0010 1000

	SD1602_control(0x08);	// display => off
							// 0000 1000

	SD1602_control(0x01);	// LCD => clear

	__delay_ms(2);			// "Execute time(max.)" => 1.64 ms

	SD1602_control(0x06);	// entry mode (cursor mode)
							// 0000 0110

	SD1602_control(0x0C);	// display => on; cursor => off
							// 0000 1100
							// (LCD_on)

}//SD1602_init_2

#endif  /* #ifndef SD1602_4BIT_H */