#ifndef _XTAL_FREQ
#define _XTAL_FREQ 20000000
#endif

//#define _XTAL_FREQ 20000000

void SD1602_write(char c, char r)
{
  PORTB = c & 0xF0; /* RB4�`RB7�Ƀf�[�^�̏��4bit���Z�b�g���� */

  if (r == 1) /* �����R�[�h�̏ꍇ */
  {
    PORTA |= 0x02; /* RS��1�ɂ��� */
  }
  else /* ����R�[�h�̏ꍇ */
  {
    PORTA &= 0xFD; /* RS��0�ɂ��� */
  }

  PORTA &= 0xFE; /* E��0�ɂ��� */
  __delay_us(1); /* 1us�i40ns�ȏ�j�̎��ԑ҂� */
  PORTA |= 0x01; /* E��1�ɂ��� */
  __delay_us(1);  /* 1us�i230ns�ȏ�j�̎��ԑ҂� */
  PORTA &= 0xFE; /* E��0�ɂ��� */
}

void SD1602_display(char c)
{
  SD1602_write(c, 1); /* �����R�[�h�̏��4bit��n�� */
  SD1602_write(c << 4, 1); /* �����R�[�h�̉���4bit��n�� */
  __delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */

//  __delay_ms(1);

}

void SD1602_control(char c)
{
  SD1602_write(c, 0); /* ����R�[�h�̏��4bit��n�� */
  SD1602_write(c << 4, 0); /* ����R�[�h�̉���4bit��n�� */
  __delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
}

void SD1602_clear(void)
{
  SD1602_write(0x01, 0); /* ����R�[�h�̏��4bit��n�� */
  SD1602_write(0x01 << 4, 0); /* ����R�[�h�̉���4bit��n�� */
  __delay_us(2); /* 2ms�i1.64ms�ȏ�j�̎��ԑ҂� */
}

void SD1602_init(void)
{
  __delay_us(20); /* 20ms�i15ms�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  __delay_us(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  __delay_us(5); /* 5ms�i100us�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  __delay_us(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x20, 0); /* 4bit���[�h�ݒ� */
  __delay_us(5); /* 5ms�i40us�ȏ�j�̎��ԑ҂� */
  SD1602_control(0x28); /* 4bit���[�h��2�s�\���ɐݒ肷�� */
  SD1602_control(0x08); /* �e�L�X�g�\�����I�t�ɂ��� */
  SD1602_control(0x0C); /* �e�L�X�g�\�����I���ɂ��� */
  SD1602_control(0x06); /* �J�[�\���ړ����E���ɐݒ肷�� */
}

void SD1602_print(char *s)
{
  while (*s != 0x00) /* �i�������i0x00�j���������܂� */
  {
    SD1602_display(*s); /* �e�L�X�g�f�[�^��\������ */
    s++;
  }
}
