#include "SD1602_8bit_mode.h"

void main(void)
{
  char s[] = "Hello, world!";

  TRISA = 0x00; /* 出力端子: RA0～RA4 */
  PORTA = 0x00; /* ポートA: 0 0 0 0 0 0 0 0 */
  TRISB = 0x00; /* 出力端子: RB0～RB7 */
  PORTB = 0x00; /* ポートB: 0 0 0 0 0 0 0 0 */

  SD1602_init(); /* SD1602の初期化 */

  while (1) /* 無限ループ */
  {
    SD1602_clear(); /* 表示クリア */
    SD1602_control(0x80); /* カーソルを0行目の先頭に移動する */
    SD1602_print(s); /* テキストデータを表示する */
    Delay_ms(1000); /* 1000msの時間待ち */

    SD1602_clear(); /* 表示クリア */
    SD1602_control(0xC0); /* カーソルを1行目の先頭に移動する */
    SD1602_print(s); /* テキストデータを表示する */
    Delay_ms(1000); /* 1000msの時間待ち */
  }
}
