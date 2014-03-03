void SD1602_write(char c, char r)
{
  PORTB = c; /* RB0�`RB7�Ƀf�[�^���Z�b�g���� */


  if (r == 1) /* �����R�[�h�̏ꍇ */
  {
    PORTA |= 0x02; /* RS��1�ɂ��� */
  }
  else /* ����R�[�h�̏ꍇ */
  {
    PORTA &= 0xFD; /* RS��0�ɂ��� */
  }

  PORTA &= 0xFE; /* E��0�ɂ��� */
  Delay_us(1); /* 1us�i40ns�ȏ�j�̎��ԑ҂� */
  PORTA |= 0x01; /* E��1�ɂ��� */
  Delay_us(1);  /* 1us�i230ns�ȏ�j�̎��ԑ҂� */
  PORTA &= 0xFE; /* E��0�ɂ��� */
}

void SD1602_display(char c)
{
  SD1602_write(c, 1); /* �����R�[�h��n�� */
  Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
}

void SD1602_control(char c)
{
  SD1602_write(c, 0); /* ����R�[�h��n�� */
  Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
}

void SD1602_clear(void)
{
  SD1602_write(0x01, 0); /* ����R�[�h��n�� */
  Delay_ms(2); /* 2ms�i1.64ms�ȏ�j�̎��ԑ҂� */
}

void SD1602_init(void)
{
  Delay_ms(20); /* 20ms�i15ms�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  Delay_ms(5); /* 5ms�i100us�ȏ�j�̎��ԑ҂� */
  SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
  Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
  SD1602_control(0x38); /* 8bit���[�h��2�s�\���ɐݒ肷�� */
  SD1602_control(0x08); /* �e�L�X�g�\�����I�t�ɂ��� */
  SD1602_control(0x0C); /* �e�L�X�g�\�����I���ɂ��� */
  SD1602_control(0x06); /* �J�[�\���ړ����E�����ɐݒ肷�� */
}

void SD1602_print(char *s)
{
  while (*s != 0x00) /* �i�������i0x00�j���������܂� */
  {
    SD1602_display(*s); /* �e�L�X�g�f�[�^��\������ */
    s++;
  	
  	Delay_ms(250);
  	
  }
}
