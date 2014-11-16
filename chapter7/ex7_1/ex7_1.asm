;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2010/01/07 19:29:20
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2804			GOTO	_main
$00D4	$	_SD1602_write:
;sd1602_8bit_mode.h,1 :: 		void SD1602_write(char c, char r)
;sd1602_8bit_mode.h,3 :: 		PORTB = c; /* RB0�`RB7�Ƀf�[�^���Z�b�g���� */
$00D4	$1303			BCF	STATUS, RP1
$00D5	$1283			BCF	STATUS, RP0
$00D6	$081C			MOVF	FARG_SD1602_write+0, 0
$00D7	$0086			MOVWF	PORTB
;sd1602_8bit_mode.h,5 :: 		if (r == 1) /* �����R�[�h�̏ꍇ */
$00D8	$081D			MOVF	FARG_SD1602_write+1, 0
$00D9	$3A01			XORLW	1
$00DA	$1D03			BTFSS	STATUS, Z
$00DB	$28DE			GOTO	L_SD1602_write_0
;sd1602_8bit_mode.h,7 :: 		PORTA |= 0x02; /* RS��1�ɂ��� */
$00DC	$1485			BSF	PORTA, 1
;sd1602_8bit_mode.h,8 :: 		}
$00DD	$28E0			GOTO	L_SD1602_write_1
$00DE	$	L_SD1602_write_0:
;sd1602_8bit_mode.h,11 :: 		PORTA &= 0xFD; /* RS��0�ɂ��� */
$00DE	$30FD			MOVLW	253
$00DF	$0585			ANDWF	PORTA, 1
;sd1602_8bit_mode.h,12 :: 		}
$00E0	$	L_SD1602_write_1:
;sd1602_8bit_mode.h,14 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$00E0	$30FE			MOVLW	254
$00E1	$0585			ANDWF	PORTA, 1
;sd1602_8bit_mode.h,15 :: 		Delay_us(1); /* 1us�i40ns�ȏ�j�̎��ԑ҂� */
$00E2	$3001			MOVLW	1
$00E3	$00CA			MOVWF	STACK_10
$00E4	$0BCA			DECFSZ	STACK_10, F
$00E5	$28E4			GOTO	$-1
$00E6	$0000			NOP
;sd1602_8bit_mode.h,16 :: 		PORTA |= 0x01; /* E��1�ɂ��� */
$00E7	$1405			BSF	PORTA, 0
;sd1602_8bit_mode.h,17 :: 		Delay_us(1);  /* 1us�i230ns�ȏ�j�̎��ԑ҂� */
$00E8	$3001			MOVLW	1
$00E9	$00CA			MOVWF	STACK_10
$00EA	$0BCA			DECFSZ	STACK_10, F
$00EB	$28EA			GOTO	$-1
$00EC	$0000			NOP
;sd1602_8bit_mode.h,18 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$00ED	$30FE			MOVLW	254
$00EE	$0585			ANDWF	PORTA, 1
;sd1602_8bit_mode.h,19 :: 		}
$00EF	$0008			RETURN
$0124	$	_SD1602_control:
;sd1602_8bit_mode.h,27 :: 		void SD1602_control(char c)
;sd1602_8bit_mode.h,29 :: 		SD1602_write(c, 0); /* ����R�[�h��n�� */
$0124	$1303			BCF	STATUS, RP1
$0125	$1283			BCF	STATUS, RP0
$0126	$081B			MOVF	FARG_SD1602_control+0, 0
$0127	$009C			MOVWF	FARG_SD1602_write+0
$0128	$019D			CLRF	FARG_SD1602_write+1, 1
$0129	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,30 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$012A	$3053			MOVLW	83
$012B	$00CA			MOVWF	STACK_10
$012C	$0BCA			DECFSZ	STACK_10, F
$012D	$292C			GOTO	$-1
;sd1602_8bit_mode.h,31 :: 		}
$012E	$0008			RETURN
$0118	$	_SD1602_display:
;sd1602_8bit_mode.h,21 :: 		void SD1602_display(char c)
;sd1602_8bit_mode.h,23 :: 		SD1602_write(c, 1); /* �����R�[�h��n�� */
$0118	$1303			BCF	STATUS, RP1
$0119	$1283			BCF	STATUS, RP0
$011A	$081B			MOVF	FARG_SD1602_display+0, 0
$011B	$009C			MOVWF	FARG_SD1602_write+0
$011C	$3001			MOVLW	1
$011D	$009D			MOVWF	FARG_SD1602_write+1
$011E	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,24 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$011F	$3053			MOVLW	83
$0120	$00CA			MOVWF	STACK_10
$0121	$0BCA			DECFSZ	STACK_10, F
$0122	$2921			GOTO	$-1
;sd1602_8bit_mode.h,25 :: 		}
$0123	$0008			RETURN
$007A	$	_SD1602_init:
;sd1602_8bit_mode.h,39 :: 		void SD1602_init(void)
;sd1602_8bit_mode.h,41 :: 		Delay_ms(20); /* 20ms�i15ms�ȏ�j�̎��ԑ҂� */
$007A	$3082			MOVLW	130
$007B	$1303			BCF	STATUS, RP1
$007C	$1283			BCF	STATUS, RP0
$007D	$00CB			MOVWF	STACK_11
$007E	$30FF			MOVLW	255
$007F	$00CA			MOVWF	STACK_10
$0080	$0BCB			DECFSZ	STACK_11, F
$0081	$2883			GOTO	$+2
$0082	$2886			GOTO	$+4
$0083	$0BCA			DECFSZ	STACK_10, F
$0084	$2883			GOTO	$-1
$0085	$2880			GOTO	$-5
$0086	$3087			MOVLW	135
$0087	$00CA			MOVWF	STACK_10
$0088	$0BCA			DECFSZ	STACK_10, F
$0089	$2888			GOTO	$-1
$008A	$0000			NOP
;sd1602_8bit_mode.h,42 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$008B	$3030			MOVLW	48
$008C	$009C			MOVWF	FARG_SD1602_write+0
$008D	$019D			CLRF	FARG_SD1602_write+1, 1
$008E	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,43 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$008F	$3021			MOVLW	33
$0090	$00CB			MOVWF	STACK_11
$0091	$30FF			MOVLW	255
$0092	$00CA			MOVWF	STACK_10
$0093	$0BCB			DECFSZ	STACK_11, F
$0094	$2896			GOTO	$+2
$0095	$2899			GOTO	$+4
$0096	$0BCA			DECFSZ	STACK_10, F
$0097	$2896			GOTO	$-1
$0098	$2893			GOTO	$-5
$0099	$3060			MOVLW	96
$009A	$00CA			MOVWF	STACK_10
$009B	$0BCA			DECFSZ	STACK_10, F
$009C	$289B			GOTO	$-1
$009D	$0000			NOP
$009E	$0000			NOP
;sd1602_8bit_mode.h,44 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$009F	$3030			MOVLW	48
$00A0	$009C			MOVWF	FARG_SD1602_write+0
$00A1	$019D			CLRF	FARG_SD1602_write+1, 1
$00A2	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,45 :: 		Delay_ms(5); /* 5ms�i100us�ȏ�j�̎��ԑ҂� */
$00A3	$3021			MOVLW	33
$00A4	$00CB			MOVWF	STACK_11
$00A5	$30FF			MOVLW	255
$00A6	$00CA			MOVWF	STACK_10
$00A7	$0BCB			DECFSZ	STACK_11, F
$00A8	$28AA			GOTO	$+2
$00A9	$28AD			GOTO	$+4
$00AA	$0BCA			DECFSZ	STACK_10, F
$00AB	$28AA			GOTO	$-1
$00AC	$28A7			GOTO	$-5
$00AD	$3060			MOVLW	96
$00AE	$00CA			MOVWF	STACK_10
$00AF	$0BCA			DECFSZ	STACK_10, F
$00B0	$28AF			GOTO	$-1
$00B1	$0000			NOP
$00B2	$0000			NOP
;sd1602_8bit_mode.h,46 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$00B3	$3030			MOVLW	48
$00B4	$009C			MOVWF	FARG_SD1602_write+0
$00B5	$019D			CLRF	FARG_SD1602_write+1, 1
$00B6	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,47 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$00B7	$3021			MOVLW	33
$00B8	$00CB			MOVWF	STACK_11
$00B9	$30FF			MOVLW	255
$00BA	$00CA			MOVWF	STACK_10
$00BB	$0BCB			DECFSZ	STACK_11, F
$00BC	$28BE			GOTO	$+2
$00BD	$28C1			GOTO	$+4
$00BE	$0BCA			DECFSZ	STACK_10, F
$00BF	$28BE			GOTO	$-1
$00C0	$28BB			GOTO	$-5
$00C1	$3060			MOVLW	96
$00C2	$00CA			MOVWF	STACK_10
$00C3	$0BCA			DECFSZ	STACK_10, F
$00C4	$28C3			GOTO	$-1
$00C5	$0000			NOP
$00C6	$0000			NOP
;sd1602_8bit_mode.h,48 :: 		SD1602_control(0x38); /* 8bit���[�h��2�s�\���ɐݒ肷�� */
$00C7	$3038			MOVLW	56
$00C8	$009B			MOVWF	FARG_SD1602_control+0
$00C9	$2124			CALL	_SD1602_control
;sd1602_8bit_mode.h,49 :: 		SD1602_control(0x08); /* �e�L�X�g�\�����I�t�ɂ��� */
$00CA	$3008			MOVLW	8
$00CB	$009B			MOVWF	FARG_SD1602_control+0
$00CC	$2124			CALL	_SD1602_control
;sd1602_8bit_mode.h,50 :: 		SD1602_control(0x0C); /* �e�L�X�g�\�����I���ɂ��� */
$00CD	$300C			MOVLW	12
$00CE	$009B			MOVWF	FARG_SD1602_control+0
$00CF	$2124			CALL	_SD1602_control
;sd1602_8bit_mode.h,51 :: 		SD1602_control(0x06); /* �J�[�\���ړ����E�����ɐݒ肷�� */
$00D0	$3006			MOVLW	6
$00D1	$009B			MOVWF	FARG_SD1602_control+0
$00D2	$2124			CALL	_SD1602_control
;sd1602_8bit_mode.h,52 :: 		}
$00D3	$0008			RETURN
$00F0	$	_SD1602_clear:
;sd1602_8bit_mode.h,33 :: 		void SD1602_clear(void)
;sd1602_8bit_mode.h,35 :: 		SD1602_write(0x01, 0); /* ����R�[�h��n�� */
$00F0	$3001			MOVLW	1
$00F1	$1303			BCF	STATUS, RP1
$00F2	$1283			BCF	STATUS, RP0
$00F3	$009C			MOVWF	FARG_SD1602_write+0
$00F4	$019D			CLRF	FARG_SD1602_write+1, 1
$00F5	$20D4			CALL	_SD1602_write
;sd1602_8bit_mode.h,36 :: 		Delay_ms(2); /* 2ms�i1.64ms�ȏ�j�̎��ԑ҂� */
$00F6	$300D			MOVLW	13
$00F7	$00CB			MOVWF	STACK_11
$00F8	$30FF			MOVLW	255
$00F9	$00CA			MOVWF	STACK_10
$00FA	$0BCB			DECFSZ	STACK_11, F
$00FB	$28FD			GOTO	$+2
$00FC	$2900			GOTO	$+4
$00FD	$0BCA			DECFSZ	STACK_10, F
$00FE	$28FD			GOTO	$-1
$00FF	$28FA			GOTO	$-5
$0100	$30F3			MOVLW	243
$0101	$00CA			MOVWF	STACK_10
$0102	$0BCA			DECFSZ	STACK_10, F
$0103	$2902			GOTO	$-1
$0104	$0000			NOP
;sd1602_8bit_mode.h,37 :: 		}
$0105	$0008			RETURN
$0106	$	_SD1602_print:
;sd1602_8bit_mode.h,54 :: 		void SD1602_print(char *s)
;sd1602_8bit_mode.h,56 :: 		while (*s != 0x00) /* �i�������i0x00�j���������܂� */
$0106	$	L_SD1602_print_2:
$0106	$1303			BCF	STATUS, RP1
$0107	$1283			BCF	STATUS, RP0
$0108	$081A			MOVF	FARG_SD1602_print+0, 0
$0109	$0084			MOVWF	FSR
$010A	$0800			MOVF	INDF, 0
$010B	$00C1			MOVWF	STACK_1
$010C	$0841			MOVF	STACK_1, 0
$010D	$3A00			XORLW	0
$010E	$1903			BTFSC	STATUS, Z
$010F	$2917			GOTO	L_SD1602_print_3
;sd1602_8bit_mode.h,58 :: 		SD1602_display(*s); /* �e�L�X�g�f�[�^��\������ */
$0110	$081A			MOVF	FARG_SD1602_print+0, 0
$0111	$0084			MOVWF	FSR
$0112	$0800			MOVF	INDF, 0
$0113	$009B			MOVWF	FARG_SD1602_display+0
$0114	$2118			CALL	_SD1602_display
;sd1602_8bit_mode.h,59 :: 		s++;
$0115	$0A9A			INCF	FARG_SD1602_print+0, 1
;sd1602_8bit_mode.h,60 :: 		}
$0116	$2906			GOTO	L_SD1602_print_2
$0117	$	L_SD1602_print_3:
;sd1602_8bit_mode.h,61 :: 		}
$0117	$0008			RETURN
$0004	$	_main:
$0004	$3048			MOVLW	72
$0005	$1303			BCF	STATUS, RP1
$0006	$1283			BCF	STATUS, RP0
$0007	$008C			MOVWF	main_s_L0+0
$0008	$3065			MOVLW	101
$0009	$008D			MOVWF	main_s_L0+1
$000A	$306C			MOVLW	108
$000B	$008E			MOVWF	main_s_L0+2
$000C	$306C			MOVLW	108
$000D	$008F			MOVWF	main_s_L0+3
$000E	$306F			MOVLW	111
$000F	$0090			MOVWF	main_s_L0+4
$0010	$302C			MOVLW	44
$0011	$0091			MOVWF	main_s_L0+5
$0012	$3020			MOVLW	32
$0013	$0092			MOVWF	main_s_L0+6
$0014	$3077			MOVLW	119
$0015	$0093			MOVWF	main_s_L0+7
$0016	$306F			MOVLW	111
$0017	$0094			MOVWF	main_s_L0+8
$0018	$3072			MOVLW	114
$0019	$0095			MOVWF	main_s_L0+9
$001A	$306C			MOVLW	108
$001B	$0096			MOVWF	main_s_L0+10
$001C	$3064			MOVLW	100
$001D	$0097			MOVWF	main_s_L0+11
$001E	$3021			MOVLW	33
$001F	$0098			MOVWF	main_s_L0+12
$0020	$0199			CLRF	main_s_L0+13
;ex7_1.c,3 :: 		void main(void)
;ex7_1.c,7 :: 		TRISA = 0x00; /* �o�͒[�q: RA0�`RA4 */
$0021	$1683			BSF	STATUS, RP0
$0022	$0185			CLRF	TRISA, 1
;ex7_1.c,8 :: 		PORTA = 0x00; /* �|�[�gA: 0 0 0 0 0 0 0 0 */
$0023	$1283			BCF	STATUS, RP0
$0024	$0185			CLRF	PORTA, 1
;ex7_1.c,9 :: 		TRISB = 0x00; /* �o�͒[�q: RB0�`RB7 */
$0025	$1683			BSF	STATUS, RP0
$0026	$0186			CLRF	TRISB, 1
;ex7_1.c,10 :: 		PORTB = 0x00; /* �|�[�gB: 0 0 0 0 0 0 0 0 */
$0027	$1283			BCF	STATUS, RP0
$0028	$0186			CLRF	PORTB, 1
;ex7_1.c,12 :: 		SD1602_init(); /* SD1602�̏����� */
$0029	$207A			CALL	_SD1602_init
;ex7_1.c,14 :: 		while (1) /* �������[�v */
$002A	$	L_main_4:
;ex7_1.c,16 :: 		SD1602_clear(); /* �\���N���A */
$002A	$20F0			CALL	_SD1602_clear
;ex7_1.c,17 :: 		SD1602_control(0x80); /* �J�[�\����0�s�ڂ̐擪�Ɉړ����� */
$002B	$3080			MOVLW	128
$002C	$009B			MOVWF	FARG_SD1602_control+0
$002D	$2124			CALL	_SD1602_control
;ex7_1.c,18 :: 		SD1602_print(s); /* �e�L�X�g�f�[�^��\������ */
$002E	$300C			MOVLW	main_s_L0
$002F	$009A			MOVWF	FARG_SD1602_print+0
$0030	$2106			CALL	_SD1602_print
;ex7_1.c,19 :: 		Delay_ms(1000); /* 1000ms�̎��ԑ҂� */
$0031	$301A			MOVLW	26
$0032	$00CC			MOVWF	STACK_12
$0033	$30FF			MOVLW	255
$0034	$00CB			MOVWF	STACK_11
$0035	$30FF			MOVLW	255
$0036	$00CA			MOVWF	STACK_10
$0037	$0BCC			DECFSZ	STACK_12, F
$0038	$283A			GOTO	$+2
$0039	$2841			GOTO	$+8
$003A	$0BCB			DECFSZ	STACK_11, F
$003B	$283D			GOTO	$+2
$003C	$2840			GOTO	$+4
$003D	$0BCA			DECFSZ	STACK_10, F
$003E	$283D			GOTO	$-1
$003F	$283A			GOTO	$-5
$0040	$2837			GOTO	$-9
$0041	$307F			MOVLW	127
$0042	$00CB			MOVWF	STACK_11
$0043	$30FF			MOVLW	255
$0044	$00CA			MOVWF	STACK_10
$0045	$0BCB			DECFSZ	STACK_11, F
$0046	$2848			GOTO	$+2
$0047	$284B			GOTO	$+4
$0048	$0BCA			DECFSZ	STACK_10, F
$0049	$2848			GOTO	$-1
$004A	$2845			GOTO	$-5
$004B	$3058			MOVLW	88
$004C	$00CA			MOVWF	STACK_10
$004D	$0BCA			DECFSZ	STACK_10, F
$004E	$284D			GOTO	$-1
$004F	$0000			NOP
$0050	$0000			NOP
;ex7_1.c,21 :: 		SD1602_clear(); /* �\���N���A */
$0051	$20F0			CALL	_SD1602_clear
;ex7_1.c,22 :: 		SD1602_control(0xC0); /* �J�[�\����1�s�ڂ̐擪�Ɉړ����� */
$0052	$30C0			MOVLW	192
$0053	$009B			MOVWF	FARG_SD1602_control+0
$0054	$2124			CALL	_SD1602_control
;ex7_1.c,23 :: 		SD1602_print(s); /* �e�L�X�g�f�[�^��\������ */
$0055	$300C			MOVLW	main_s_L0
$0056	$009A			MOVWF	FARG_SD1602_print+0
$0057	$2106			CALL	_SD1602_print
;ex7_1.c,24 :: 		Delay_ms(1000); /* 1000ms�̎��ԑ҂� */
$0058	$301A			MOVLW	26
$0059	$00CC			MOVWF	STACK_12
$005A	$30FF			MOVLW	255
$005B	$00CB			MOVWF	STACK_11
$005C	$30FF			MOVLW	255
$005D	$00CA			MOVWF	STACK_10
$005E	$0BCC			DECFSZ	STACK_12, F
$005F	$2861			GOTO	$+2
$0060	$2868			GOTO	$+8
$0061	$0BCB			DECFSZ	STACK_11, F
$0062	$2864			GOTO	$+2
$0063	$2867			GOTO	$+4
$0064	$0BCA			DECFSZ	STACK_10, F
$0065	$2864			GOTO	$-1
$0066	$2861			GOTO	$-5
$0067	$285E			GOTO	$-9
$0068	$307F			MOVLW	127
$0069	$00CB			MOVWF	STACK_11
$006A	$30FF			MOVLW	255
$006B	$00CA			MOVWF	STACK_10
$006C	$0BCB			DECFSZ	STACK_11, F
$006D	$286F			GOTO	$+2
$006E	$2872			GOTO	$+4
$006F	$0BCA			DECFSZ	STACK_10, F
$0070	$286F			GOTO	$-1
$0071	$286C			GOTO	$-5
$0072	$3058			MOVLW	88
$0073	$00CA			MOVWF	STACK_10
$0074	$0BCA			DECFSZ	STACK_10, F
$0075	$2874			GOTO	$-1
$0076	$0000			NOP
$0077	$0000			NOP
;ex7_1.c,25 :: 		}
$0078	$282A			GOTO	L_main_4
;ex7_1.c,26 :: 		}
$0079	$2879			GOTO	$