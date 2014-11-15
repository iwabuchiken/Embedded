#include "SD1602_8bit_mode.h"

void main(void)
{
  char s[] = "Hello, world!";

  TRISA = 0x00; /* �o�͒[�q: RA0�`RA4 */
  PORTA = 0x00; /* �|�[�gA: 0 0 0 0 0 0 0 0 */
  TRISB = 0x00; /* �o�͒[�q: RB0�`RB7 */
  PORTB = 0x00; /* �|�[�gB: 0 0 0 0 0 0 0 0 */

  SD1602_init(); /* SD1602�̏����� */

  while (1) /* �������[�v */
  {
    SD1602_clear(); /* �\���N���A */
    SD1602_control(0x80); /* �J�[�\����0�s�ڂ̐擪�Ɉړ����� */
    SD1602_print(s); /* �e�L�X�g�f�[�^��\������ */
    Delay_ms(1000); /* 1000ms�̎��ԑ҂� */

    SD1602_clear(); /* �\���N���A */
    SD1602_control(0xC0); /* �J�[�\����1�s�ڂ̐擪�Ɉړ����� */
    SD1602_print(s); /* �e�L�X�g�f�[�^��\������ */
    Delay_ms(1000); /* 1000ms�̎��ԑ҂� */
  }
}
