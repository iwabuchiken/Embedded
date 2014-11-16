;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/11/16 20:17:15
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2872			GOTO	_main
$00B3	$	_SD1602_write:
;sd1602_4bit_mode.h,1 :: 		void SD1602_write(char c, char r)
;sd1602_4bit_mode.h,3 :: 		PORTB = c & 0xF0; /* RB4�`RB7�Ƀf�[�^�̏��4bit���Z�b�g���� */
$00B3	$30F0			MOVLW	240
$00B4	$1303			BCF	STATUS, RP1
$00B5	$1283			BCF	STATUS, RP0
$00B6	$0515			ANDWF	FARG_SD1602_write+0, 0
$00B7	$0086			MOVWF	PORTB
;sd1602_4bit_mode.h,5 :: 		if (r == 1) /* �����R�[�h�̏ꍇ */
$00B8	$0816			MOVF	FARG_SD1602_write+1, 0
$00B9	$3A01			XORLW	1
$00BA	$1D03			BTFSS	STATUS, Z
$00BB	$28BE			GOTO	L_SD1602_write_0
;sd1602_4bit_mode.h,7 :: 		PORTA |= 0x02; /* RS��1�ɂ��� */
$00BC	$1485			BSF	PORTA, 1
;sd1602_4bit_mode.h,8 :: 		}
$00BD	$28C0			GOTO	L_SD1602_write_1
$00BE	$	L_SD1602_write_0:
;sd1602_4bit_mode.h,11 :: 		PORTA &= 0xFD; /* RS��0�ɂ��� */
$00BE	$30FD			MOVLW	253
$00BF	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,12 :: 		}
$00C0	$	L_SD1602_write_1:
;sd1602_4bit_mode.h,14 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$00C0	$30FE			MOVLW	254
$00C1	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,15 :: 		Delay_us(1); /* 1us�i40ns�ȏ�j�̎��ԑ҂� */
$00C2	$3001			MOVLW	1
$00C3	$00CA			MOVWF	STACK_10
$00C4	$0BCA			DECFSZ	STACK_10, F
$00C5	$28C4			GOTO	$-1
$00C6	$0000			NOP
;sd1602_4bit_mode.h,16 :: 		PORTA |= 0x01; /* E��1�ɂ��� */
$00C7	$1405			BSF	PORTA, 0
;sd1602_4bit_mode.h,17 :: 		Delay_us(1);  /* 1us�i230ns�ȏ�j�̎��ԑ҂� */
$00C8	$3001			MOVLW	1
$00C9	$00CA			MOVWF	STACK_10
$00CA	$0BCA			DECFSZ	STACK_10, F
$00CB	$28CA			GOTO	$-1
$00CC	$0000			NOP
;sd1602_4bit_mode.h,18 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$00CD	$30FE			MOVLW	254
$00CE	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,19 :: 		}
$00CF	$0008			RETURN
$0103	$	_SD1602_control:
;sd1602_4bit_mode.h,28 :: 		void SD1602_control(char c)
;sd1602_4bit_mode.h,30 :: 		SD1602_write(c, 0); /* ����R�[�h�̏��4bit��n�� */
$0103	$1303			BCF	STATUS, RP1
$0104	$1283			BCF	STATUS, RP0
$0105	$0814			MOVF	FARG_SD1602_control+0, 0
$0106	$0095			MOVWF	FARG_SD1602_write+0
$0107	$0196			CLRF	FARG_SD1602_write+1, 1
$0108	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,31 :: 		SD1602_write(c << 4, 0); /* ����R�[�h�̉���4bit��n�� */
$0109	$0814			MOVF	FARG_SD1602_control+0, 0
$010A	$0095			MOVWF	FARG_SD1602_write+0
$010B	$0D95			RLF	FARG_SD1602_write+0, 1
$010C	$1015			BCF	FARG_SD1602_write+0, 0
$010D	$0D95			RLF	FARG_SD1602_write+0, 1
$010E	$1015			BCF	FARG_SD1602_write+0, 0
$010F	$0D95			RLF	FARG_SD1602_write+0, 1
$0110	$1015			BCF	FARG_SD1602_write+0, 0
$0111	$0D95			RLF	FARG_SD1602_write+0, 1
$0112	$1015			BCF	FARG_SD1602_write+0, 0
$0113	$0196			CLRF	FARG_SD1602_write+1, 1
$0114	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,32 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$0115	$3053			MOVLW	83
$0116	$00CA			MOVWF	STACK_10
$0117	$0BCA			DECFSZ	STACK_10, F
$0118	$2917			GOTO	$-1
;sd1602_4bit_mode.h,33 :: 		}
$0119	$0008			RETURN
$00EA	$	_SD1602_display:
;sd1602_4bit_mode.h,21 :: 		void SD1602_display(char c)
;sd1602_4bit_mode.h,23 :: 		SD1602_write(c, 1); /* �����R�[�h�̏��4bit��n�� */
$00EA	$1303			BCF	STATUS, RP1
$00EB	$1283			BCF	STATUS, RP0
$00EC	$0814			MOVF	FARG_SD1602_display+0, 0
$00ED	$0095			MOVWF	FARG_SD1602_write+0
$00EE	$3001			MOVLW	1
$00EF	$0096			MOVWF	FARG_SD1602_write+1
$00F0	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,24 :: 		SD1602_write(c << 4, 1); /* �����R�[�h�̉���4bit��n�� */
$00F1	$0814			MOVF	FARG_SD1602_display+0, 0
$00F2	$0095			MOVWF	FARG_SD1602_write+0
$00F3	$0D95			RLF	FARG_SD1602_write+0, 1
$00F4	$1015			BCF	FARG_SD1602_write+0, 0
$00F5	$0D95			RLF	FARG_SD1602_write+0, 1
$00F6	$1015			BCF	FARG_SD1602_write+0, 0
$00F7	$0D95			RLF	FARG_SD1602_write+0, 1
$00F8	$1015			BCF	FARG_SD1602_write+0, 0
$00F9	$0D95			RLF	FARG_SD1602_write+0, 1
$00FA	$1015			BCF	FARG_SD1602_write+0, 0
$00FB	$3001			MOVLW	1
$00FC	$0096			MOVWF	FARG_SD1602_write+1
$00FD	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,25 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$00FE	$3053			MOVLW	83
$00FF	$00CA			MOVWF	STACK_10
$0100	$0BCA			DECFSZ	STACK_10, F
$0101	$2900			GOTO	$-1
;sd1602_4bit_mode.h,26 :: 		}
$0102	$0008			RETURN
$0004	$	_SD1602_init:
;sd1602_4bit_mode.h,42 :: 		void SD1602_init(void)
;sd1602_4bit_mode.h,44 :: 		Delay_ms(20); /* 20ms�i15ms�ȏ�j�̎��ԑ҂� */
$0004	$3082			MOVLW	130
$0005	$1303			BCF	STATUS, RP1
$0006	$1283			BCF	STATUS, RP0
$0007	$00CB			MOVWF	STACK_11
$0008	$30FF			MOVLW	255
$0009	$00CA			MOVWF	STACK_10
$000A	$0BCB			DECFSZ	STACK_11, F
$000B	$280D			GOTO	$+2
$000C	$2810			GOTO	$+4
$000D	$0BCA			DECFSZ	STACK_10, F
$000E	$280D			GOTO	$-1
$000F	$280A			GOTO	$-5
$0010	$3087			MOVLW	135
$0011	$00CA			MOVWF	STACK_10
$0012	$0BCA			DECFSZ	STACK_10, F
$0013	$2812			GOTO	$-1
$0014	$0000			NOP
;sd1602_4bit_mode.h,45 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$0015	$3030			MOVLW	48
$0016	$0095			MOVWF	FARG_SD1602_write+0
$0017	$0196			CLRF	FARG_SD1602_write+1, 1
$0018	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,46 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$0019	$3021			MOVLW	33
$001A	$00CB			MOVWF	STACK_11
$001B	$30FF			MOVLW	255
$001C	$00CA			MOVWF	STACK_10
$001D	$0BCB			DECFSZ	STACK_11, F
$001E	$2820			GOTO	$+2
$001F	$2823			GOTO	$+4
$0020	$0BCA			DECFSZ	STACK_10, F
$0021	$2820			GOTO	$-1
$0022	$281D			GOTO	$-5
$0023	$3060			MOVLW	96
$0024	$00CA			MOVWF	STACK_10
$0025	$0BCA			DECFSZ	STACK_10, F
$0026	$2825			GOTO	$-1
$0027	$0000			NOP
$0028	$0000			NOP
;sd1602_4bit_mode.h,47 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$0029	$3030			MOVLW	48
$002A	$0095			MOVWF	FARG_SD1602_write+0
$002B	$0196			CLRF	FARG_SD1602_write+1, 1
$002C	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,48 :: 		Delay_ms(5); /* 5ms�i100us�ȏ�j�̎��ԑ҂� */
$002D	$3021			MOVLW	33
$002E	$00CB			MOVWF	STACK_11
$002F	$30FF			MOVLW	255
$0030	$00CA			MOVWF	STACK_10
$0031	$0BCB			DECFSZ	STACK_11, F
$0032	$2834			GOTO	$+2
$0033	$2837			GOTO	$+4
$0034	$0BCA			DECFSZ	STACK_10, F
$0035	$2834			GOTO	$-1
$0036	$2831			GOTO	$-5
$0037	$3060			MOVLW	96
$0038	$00CA			MOVWF	STACK_10
$0039	$0BCA			DECFSZ	STACK_10, F
$003A	$2839			GOTO	$-1
$003B	$0000			NOP
$003C	$0000			NOP
;sd1602_4bit_mode.h,49 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$003D	$3030			MOVLW	48
$003E	$0095			MOVWF	FARG_SD1602_write+0
$003F	$0196			CLRF	FARG_SD1602_write+1, 1
$0040	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,50 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$0041	$3021			MOVLW	33
$0042	$00CB			MOVWF	STACK_11
$0043	$30FF			MOVLW	255
$0044	$00CA			MOVWF	STACK_10
$0045	$0BCB			DECFSZ	STACK_11, F
$0046	$2848			GOTO	$+2
$0047	$284B			GOTO	$+4
$0048	$0BCA			DECFSZ	STACK_10, F
$0049	$2848			GOTO	$-1
$004A	$2845			GOTO	$-5
$004B	$3060			MOVLW	96
$004C	$00CA			MOVWF	STACK_10
$004D	$0BCA			DECFSZ	STACK_10, F
$004E	$284D			GOTO	$-1
$004F	$0000			NOP
$0050	$0000			NOP
;sd1602_4bit_mode.h,51 :: 		SD1602_write(0x20, 0); /* 4bit���[�h�ݒ� */
$0051	$3020			MOVLW	32
$0052	$0095			MOVWF	FARG_SD1602_write+0
$0053	$0196			CLRF	FARG_SD1602_write+1, 1
$0054	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,52 :: 		Delay_ms(5); /* 5ms�i40us�ȏ�j�̎��ԑ҂� */
$0055	$3021			MOVLW	33
$0056	$00CB			MOVWF	STACK_11
$0057	$30FF			MOVLW	255
$0058	$00CA			MOVWF	STACK_10
$0059	$0BCB			DECFSZ	STACK_11, F
$005A	$285C			GOTO	$+2
$005B	$285F			GOTO	$+4
$005C	$0BCA			DECFSZ	STACK_10, F
$005D	$285C			GOTO	$-1
$005E	$2859			GOTO	$-5
$005F	$3060			MOVLW	96
$0060	$00CA			MOVWF	STACK_10
$0061	$0BCA			DECFSZ	STACK_10, F
$0062	$2861			GOTO	$-1
$0063	$0000			NOP
$0064	$0000			NOP
;sd1602_4bit_mode.h,53 :: 		SD1602_control(0x28); /* 4bit���[�h��2�s�\���ɐݒ肷�� */
$0065	$3028			MOVLW	40
$0066	$0094			MOVWF	FARG_SD1602_control+0
$0067	$2103			CALL	_SD1602_control
;sd1602_4bit_mode.h,54 :: 		SD1602_control(0x08); /* �e�L�X�g�\�����I�t�ɂ��� */
$0068	$3008			MOVLW	8
$0069	$0094			MOVWF	FARG_SD1602_control+0
$006A	$2103			CALL	_SD1602_control
;sd1602_4bit_mode.h,55 :: 		SD1602_control(0x0C); /* �e�L�X�g�\�����I���ɂ��� */
$006B	$300C			MOVLW	12
$006C	$0094			MOVWF	FARG_SD1602_control+0
$006D	$2103			CALL	_SD1602_control
;sd1602_4bit_mode.h,56 :: 		SD1602_control(0x06); /* �J�[�\���ړ����E�����ɐݒ肷�� */
$006E	$3006			MOVLW	6
$006F	$0094			MOVWF	FARG_SD1602_control+0
$0070	$2103			CALL	_SD1602_control
;sd1602_4bit_mode.h,57 :: 		}
$0071	$0008			RETURN
$00D0	$	_SD1602_clear:
;sd1602_4bit_mode.h,35 :: 		void SD1602_clear(void)
;sd1602_4bit_mode.h,37 :: 		SD1602_write(0x01, 0); /* ����R�[�h�̏��4bit��n�� */
$00D0	$3001			MOVLW	1
$00D1	$1303			BCF	STATUS, RP1
$00D2	$1283			BCF	STATUS, RP0
$00D3	$0095			MOVWF	FARG_SD1602_write+0
$00D4	$0196			CLRF	FARG_SD1602_write+1, 1
$00D5	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,38 :: 		SD1602_write(0x01 << 4, 0); /* ����R�[�h�̉���4bit��n�� */
$00D6	$3010			MOVLW	16
$00D7	$0095			MOVWF	FARG_SD1602_write+0
$00D8	$0196			CLRF	FARG_SD1602_write+1, 1
$00D9	$20B3			CALL	_SD1602_write
;sd1602_4bit_mode.h,39 :: 		Delay_ms(2); /* 2ms�i1.64ms�ȏ�j�̎��ԑ҂� */
$00DA	$300D			MOVLW	13
$00DB	$00CB			MOVWF	STACK_11
$00DC	$30FF			MOVLW	255
$00DD	$00CA			MOVWF	STACK_10
$00DE	$0BCB			DECFSZ	STACK_11, F
$00DF	$28E1			GOTO	$+2
$00E0	$28E4			GOTO	$+4
$00E1	$0BCA			DECFSZ	STACK_10, F
$00E2	$28E1			GOTO	$-1
$00E3	$28DE			GOTO	$-5
$00E4	$30F3			MOVLW	243
$00E5	$00CA			MOVWF	STACK_10
$00E6	$0BCA			DECFSZ	STACK_10, F
$00E7	$28E6			GOTO	$-1
$00E8	$0000			NOP
;sd1602_4bit_mode.h,40 :: 		}
$00E9	$0008			RETURN
$011A	$	_SD1602_print:
;sd1602_4bit_mode.h,59 :: 		void SD1602_print(char *s)
;sd1602_4bit_mode.h,61 :: 		while (*s != 0x00) /* �i�������i0x00�j���������܂� */
$011A	$	L_SD1602_print_2:
$011A	$1303			BCF	STATUS, RP1
$011B	$1283			BCF	STATUS, RP0
$011C	$0813			MOVF	FARG_SD1602_print+0, 0
$011D	$0084			MOVWF	FSR
$011E	$0800			MOVF	INDF, 0
$011F	$00C1			MOVWF	STACK_1
$0120	$0841			MOVF	STACK_1, 0
$0121	$3A00			XORLW	0
$0122	$1903			BTFSC	STATUS, Z
$0123	$292B			GOTO	L_SD1602_print_3
;sd1602_4bit_mode.h,63 :: 		SD1602_display(*s); /* �e�L�X�g�f�[�^��\������ */
$0124	$0813			MOVF	FARG_SD1602_print+0, 0
$0125	$0084			MOVWF	FSR
$0126	$0800			MOVF	INDF, 0
$0127	$0094			MOVWF	FARG_SD1602_display+0
$0128	$20EA			CALL	_SD1602_display
;sd1602_4bit_mode.h,64 :: 		s++;
$0129	$0A93			INCF	FARG_SD1602_print+0, 1
;sd1602_4bit_mode.h,65 :: 		}
$012A	$291A			GOTO	L_SD1602_print_2
$012B	$	L_SD1602_print_3:
;sd1602_4bit_mode.h,66 :: 		}
$012B	$0008			RETURN
$0072	$	_main:
$0072	$3048			MOVLW	72
$0073	$1303			BCF	STATUS, RP1
$0074	$1283			BCF	STATUS, RP0
$0075	$008C			MOVWF	main_s_L0+0
$0076	$3065			MOVLW	101
$0077	$008D			MOVWF	main_s_L0+1
$0078	$306C			MOVLW	108
$0079	$008E			MOVWF	main_s_L0+2
$007A	$306C			MOVLW	108
$007B	$008F			MOVWF	main_s_L0+3
$007C	$306F			MOVLW	111
$007D	$0090			MOVWF	main_s_L0+4
$007E	$3021			MOVLW	33
$007F	$0091			MOVWF	main_s_L0+5
$0080	$0192			CLRF	main_s_L0+6
;D-97_LCD_v-2.2.c,3 :: 		void main(void)
;D-97_LCD_v-2.2.c,7 :: 		TRISA     = 0x00;
$0081	$1683			BSF	STATUS, RP0
$0082	$0185			CLRF	TRISA, 1
;D-97_LCD_v-2.2.c,8 :: 		PORTA     = 0x00;
$0083	$1283			BCF	STATUS, RP0
$0084	$0185			CLRF	PORTA, 1
;D-97_LCD_v-2.2.c,9 :: 		TRISB     = 0x00;
$0085	$1683			BSF	STATUS, RP0
$0086	$0186			CLRF	TRISB, 1
;D-97_LCD_v-2.2.c,10 :: 		PORTB     = 0x00;
$0087	$1283			BCF	STATUS, RP0
$0088	$0186			CLRF	PORTB, 1
;D-97_LCD_v-2.2.c,13 :: 		SD1602_init();
$0089	$2004			CALL	_SD1602_init
;D-97_LCD_v-2.2.c,15 :: 		SD1602_clear();
$008A	$20D0			CALL	_SD1602_clear
;D-97_LCD_v-2.2.c,18 :: 		while(1)
$008B	$	L_main_4:
;D-97_LCD_v-2.2.c,21 :: 		SD1602_control(0x80);
$008B	$3080			MOVLW	128
$008C	$0094			MOVWF	FARG_SD1602_control+0
$008D	$2103			CALL	_SD1602_control
;D-97_LCD_v-2.2.c,22 :: 		SD1602_print(s);
$008E	$300C			MOVLW	main_s_L0
$008F	$0093			MOVWF	FARG_SD1602_print+0
$0090	$211A			CALL	_SD1602_print
;D-97_LCD_v-2.2.c,24 :: 		Delay_ms(1000);
$0091	$301A			MOVLW	26
$0092	$00CC			MOVWF	STACK_12
$0093	$30FF			MOVLW	255
$0094	$00CB			MOVWF	STACK_11
$0095	$30FF			MOVLW	255
$0096	$00CA			MOVWF	STACK_10
$0097	$0BCC			DECFSZ	STACK_12, F
$0098	$289A			GOTO	$+2
$0099	$28A1			GOTO	$+8
$009A	$0BCB			DECFSZ	STACK_11, F
$009B	$289D			GOTO	$+2
$009C	$28A0			GOTO	$+4
$009D	$0BCA			DECFSZ	STACK_10, F
$009E	$289D			GOTO	$-1
$009F	$289A			GOTO	$-5
$00A0	$2897			GOTO	$-9
$00A1	$307F			MOVLW	127
$00A2	$00CB			MOVWF	STACK_11
$00A3	$30FF			MOVLW	255
$00A4	$00CA			MOVWF	STACK_10
$00A5	$0BCB			DECFSZ	STACK_11, F
$00A6	$28A8			GOTO	$+2
$00A7	$28AB			GOTO	$+4
$00A8	$0BCA			DECFSZ	STACK_10, F
$00A9	$28A8			GOTO	$-1
$00AA	$28A5			GOTO	$-5
$00AB	$3058			MOVLW	88
$00AC	$00CA			MOVWF	STACK_10
$00AD	$0BCA			DECFSZ	STACK_10, F
$00AE	$28AD			GOTO	$-1
$00AF	$0000			NOP
$00B0	$0000			NOP
;D-97_LCD_v-2.2.c,25 :: 		}
$00B1	$288B			GOTO	L_main_4
;D-97_LCD_v-2.2.c,27 :: 		}
$00B2	$28B2			GOTO	$