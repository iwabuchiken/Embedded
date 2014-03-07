;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/03/07 15:29:19
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$28D5			GOTO	_main
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$00AE			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$00AD			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$00AF			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$084C			MOVF	STACK_12, 0
$000E	$00BA			MOVWF	STSAVED_12
$000F	$084B			MOVF	STACK_11, 0
$0010	$00B9			MOVWF	STSAVED_11
$0011	$084A			MOVF	STACK_10, 0
$0012	$00B8			MOVWF	STSAVED_10
$0013	$0841			MOVF	STACK_1, 0
$0014	$00B7			MOVWF	STSAVED_1
$0015	$0840			MOVF	STACK_0, 0
$0016	$00B6			MOVWF	STSAVED_0
;D_82_16F84A_SD1602_v_4_1.c,13 :: 		void interrupt(void)
;D_82_16F84A_SD1602_v_4_1.c,15 :: 		INTCON         &= 0x7F;
$0017	$307F			MOVLW	127
$0018	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,16 :: 		INTCON         &= 0xEF;
$0019	$30EF			MOVLW	239
$001A	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,17 :: 		INTCON         &= 0xFD;
$001B	$30FD			MOVLW	253
$001C	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,19 :: 		Delay_ms(20);
$001D	$3082			MOVLW	130
$001E	$00CB			MOVWF	STACK_11
$001F	$30FF			MOVLW	255
$0020	$00CA			MOVWF	STACK_10
$0021	$0BCB			DECFSZ	STACK_11, F
$0022	$2824			GOTO	$+2
$0023	$2827			GOTO	$+4
$0024	$0BCA			DECFSZ	STACK_10, F
$0025	$2824			GOTO	$-1
$0026	$2821			GOTO	$-5
$0027	$3087			MOVLW	135
$0028	$00CA			MOVWF	STACK_10
$0029	$0BCA			DECFSZ	STACK_10, F
$002A	$2829			GOTO	$-1
$002B	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,21 :: 		if((PORTB & 0x01) == 0)
$002C	$3001			MOVLW	1
$002D	$0506			ANDWF	PORTB, 0
$002E	$00C1			MOVWF	STACK_1
$002F	$0841			MOVF	STACK_1, 0
$0030	$3A00			XORLW	0
$0031	$1D03			BTFSS	STATUS, Z
$0032	$2852			GOTO	L_interrupt_6
;D_82_16F84A_SD1602_v_4_1.c,23 :: 		Delay_ms(2000);
$0033	$3033			MOVLW	51
$0034	$00CC			MOVWF	STACK_12
$0035	$30FF			MOVLW	255
$0036	$00CB			MOVWF	STACK_11
$0037	$30FF			MOVLW	255
$0038	$00CA			MOVWF	STACK_10
$0039	$0BCC			DECFSZ	STACK_12, F
$003A	$283C			GOTO	$+2
$003B	$2843			GOTO	$+8
$003C	$0BCB			DECFSZ	STACK_11, F
$003D	$283F			GOTO	$+2
$003E	$2842			GOTO	$+4
$003F	$0BCA			DECFSZ	STACK_10, F
$0040	$283F			GOTO	$-1
$0041	$283C			GOTO	$-5
$0042	$2839			GOTO	$-9
$0043	$30FD			MOVLW	253
$0044	$00CB			MOVWF	STACK_11
$0045	$30FF			MOVLW	255
$0046	$00CA			MOVWF	STACK_10
$0047	$0BCB			DECFSZ	STACK_11, F
$0048	$284A			GOTO	$+2
$0049	$284D			GOTO	$+4
$004A	$0BCA			DECFSZ	STACK_10, F
$004B	$284A			GOTO	$-1
$004C	$2847			GOTO	$-5
$004D	$30B5			MOVLW	181
$004E	$00CA			MOVWF	STACK_10
$004F	$0BCA			DECFSZ	STACK_10, F
$0050	$284F			GOTO	$-1
$0051	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,31 :: 		}
$0052	$	L_interrupt_6:
;D_82_16F84A_SD1602_v_4_1.c,33 :: 		INTCON         |= 0x10;
$0052	$160B			BSF	INTCON, 4
;D_82_16F84A_SD1602_v_4_1.c,34 :: 		INTCON         |= 0x80;
$0053	$178B			BSF	INTCON, 7
;D_82_16F84A_SD1602_v_4_1.c,36 :: 		}//void interrupt(void)
$0054	$	L_Interrupt_end:
$0054	$083A			MOVF	STSAVED_12, 0
$0055	$00CC			MOVWF	STACK_12
$0056	$0839			MOVF	STSAVED_11, 0
$0057	$00CB			MOVWF	STACK_11
$0058	$0838			MOVF	STSAVED_10, 0
$0059	$00CA			MOVWF	STACK_10
$005A	$0837			MOVF	STSAVED_1, 0
$005B	$00C1			MOVWF	STACK_1
$005C	$0836			MOVF	STSAVED_0, 0
$005D	$00C0			MOVWF	STACK_0
$005E	$082F			MOVF	?savePCLATH, 0
$005F	$008A			MOVWF	PCLATH
$0060	$082D			MOVF	?saveFSR, 0
$0061	$0084			MOVWF	FSR
$0062	$0E2E			SWAPF	?saveSTATUS, 0
$0063	$0083			MOVWF	STATUS
$0064	$0ECF			SWAPF	STACK_15, 1
$0065	$0E4F			SWAPF	STACK_15, 0
$0066	$0009			RETFIE
$0164	$	_SD1602_write:
;sd1602_4bit_mode.h,1 :: 		void SD1602_write(char c, char r)
;sd1602_4bit_mode.h,3 :: 		PORTB = c & 0xF0; /* RB4�`RB7�Ƀf�[�^�̏��4bit���Z�b�g���� */
$0164	$30F0			MOVLW	240
$0165	$1303			BCF	STATUS, RP1
$0166	$1283			BCF	STATUS, RP0
$0167	$0534			ANDWF	FARG_SD1602_write+0, 0
$0168	$0086			MOVWF	PORTB
;sd1602_4bit_mode.h,5 :: 		if (r == 1) /* �����R�[�h�̏ꍇ */
$0169	$0835			MOVF	FARG_SD1602_write+1, 0
$016A	$3A01			XORLW	1
$016B	$1D03			BTFSS	STATUS, Z
$016C	$296F			GOTO	L_SD1602_write_0
;sd1602_4bit_mode.h,7 :: 		PORTA |= 0x02; /* RS��1�ɂ��� */
$016D	$1485			BSF	PORTA, 1
;sd1602_4bit_mode.h,8 :: 		}
$016E	$2971			GOTO	L_SD1602_write_1
$016F	$	L_SD1602_write_0:
;sd1602_4bit_mode.h,11 :: 		PORTA &= 0xFD; /* RS��0�ɂ��� */
$016F	$30FD			MOVLW	253
$0170	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,12 :: 		}
$0171	$	L_SD1602_write_1:
;sd1602_4bit_mode.h,14 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$0171	$30FE			MOVLW	254
$0172	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,15 :: 		Delay_us(1); /* 1us�i40ns�ȏ�j�̎��ԑ҂� */
$0173	$3001			MOVLW	1
$0174	$00CA			MOVWF	STACK_10
$0175	$0BCA			DECFSZ	STACK_10, F
$0176	$2975			GOTO	$-1
$0177	$0000			NOP
;sd1602_4bit_mode.h,16 :: 		PORTA |= 0x01; /* E��1�ɂ��� */
$0178	$1405			BSF	PORTA, 0
;sd1602_4bit_mode.h,17 :: 		Delay_us(1);  /* 1us�i230ns�ȏ�j�̎��ԑ҂� */
$0179	$3001			MOVLW	1
$017A	$00CA			MOVWF	STACK_10
$017B	$0BCA			DECFSZ	STACK_10, F
$017C	$297B			GOTO	$-1
$017D	$0000			NOP
;sd1602_4bit_mode.h,18 :: 		PORTA &= 0xFE; /* E��0�ɂ��� */
$017E	$30FE			MOVLW	254
$017F	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,19 :: 		}
$0180	$0008			RETURN
$01B4	$	_SD1602_control:
;sd1602_4bit_mode.h,28 :: 		void SD1602_control(char c)
;sd1602_4bit_mode.h,30 :: 		SD1602_write(c, 0); /* ����R�[�h�̏��4bit��n�� */
$01B4	$1303			BCF	STATUS, RP1
$01B5	$1283			BCF	STATUS, RP0
$01B6	$0833			MOVF	FARG_SD1602_control+0, 0
$01B7	$00B4			MOVWF	FARG_SD1602_write+0
$01B8	$01B5			CLRF	FARG_SD1602_write+1, 1
$01B9	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,31 :: 		SD1602_write(c << 4, 0); /* ����R�[�h�̉���4bit��n�� */
$01BA	$0833			MOVF	FARG_SD1602_control+0, 0
$01BB	$00B4			MOVWF	FARG_SD1602_write+0
$01BC	$0DB4			RLF	FARG_SD1602_write+0, 1
$01BD	$1034			BCF	FARG_SD1602_write+0, 0
$01BE	$0DB4			RLF	FARG_SD1602_write+0, 1
$01BF	$1034			BCF	FARG_SD1602_write+0, 0
$01C0	$0DB4			RLF	FARG_SD1602_write+0, 1
$01C1	$1034			BCF	FARG_SD1602_write+0, 0
$01C2	$0DB4			RLF	FARG_SD1602_write+0, 1
$01C3	$1034			BCF	FARG_SD1602_write+0, 0
$01C4	$01B5			CLRF	FARG_SD1602_write+1, 1
$01C5	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,32 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$01C6	$3053			MOVLW	83
$01C7	$00CA			MOVWF	STACK_10
$01C8	$0BCA			DECFSZ	STACK_10, F
$01C9	$29C8			GOTO	$-1
;sd1602_4bit_mode.h,33 :: 		}
$01CA	$0008			RETURN
$01E8	$	_____DoICP:
$01E8	$1303			BCF	STATUS, RP1
$01E9	$1283			BCF	STATUS, RP0
$01EA	$080D			MOVF	___DoICPHiAddr, 0
$01EB	$008A			MOVWF	PCLATH
$01EC	$080E			MOVF	___DoICPLoAddr, 0
$01ED	$0082			MOVWF	PCL
$01EE	$0008			RETURN
$019B	$	_SD1602_display:
;sd1602_4bit_mode.h,21 :: 		void SD1602_display(char c)
;sd1602_4bit_mode.h,23 :: 		SD1602_write(c, 1); /* �����R�[�h�̏��4bit��n�� */
$019B	$1303			BCF	STATUS, RP1
$019C	$1283			BCF	STATUS, RP0
$019D	$0833			MOVF	FARG_SD1602_display+0, 0
$019E	$00B4			MOVWF	FARG_SD1602_write+0
$019F	$3001			MOVLW	1
$01A0	$00B5			MOVWF	FARG_SD1602_write+1
$01A1	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,24 :: 		SD1602_write(c << 4, 1); /* �����R�[�h�̉���4bit��n�� */
$01A2	$0833			MOVF	FARG_SD1602_display+0, 0
$01A3	$00B4			MOVWF	FARG_SD1602_write+0
$01A4	$0DB4			RLF	FARG_SD1602_write+0, 1
$01A5	$1034			BCF	FARG_SD1602_write+0, 0
$01A6	$0DB4			RLF	FARG_SD1602_write+0, 1
$01A7	$1034			BCF	FARG_SD1602_write+0, 0
$01A8	$0DB4			RLF	FARG_SD1602_write+0, 1
$01A9	$1034			BCF	FARG_SD1602_write+0, 0
$01AA	$0DB4			RLF	FARG_SD1602_write+0, 1
$01AB	$1034			BCF	FARG_SD1602_write+0, 0
$01AC	$3001			MOVLW	1
$01AD	$00B5			MOVWF	FARG_SD1602_write+1
$01AE	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,25 :: 		Delay_us(50); /* 50us�i40us�ȏ�j�̎��ԑ҂� */
$01AF	$3053			MOVLW	83
$01B0	$00CA			MOVWF	STACK_10
$01B1	$0BCA			DECFSZ	STACK_10, F
$01B2	$29B1			GOTO	$-1
;sd1602_4bit_mode.h,26 :: 		}
$01B3	$0008			RETURN
$0067	$	_SD1602_init:
;sd1602_4bit_mode.h,42 :: 		void SD1602_init(void)
;sd1602_4bit_mode.h,44 :: 		Delay_ms(20); /* 20ms�i15ms�ȏ�j�̎��ԑ҂� */
$0067	$3082			MOVLW	130
$0068	$1303			BCF	STATUS, RP1
$0069	$1283			BCF	STATUS, RP0
$006A	$00CB			MOVWF	STACK_11
$006B	$30FF			MOVLW	255
$006C	$00CA			MOVWF	STACK_10
$006D	$0BCB			DECFSZ	STACK_11, F
$006E	$2870			GOTO	$+2
$006F	$2873			GOTO	$+4
$0070	$0BCA			DECFSZ	STACK_10, F
$0071	$2870			GOTO	$-1
$0072	$286D			GOTO	$-5
$0073	$3087			MOVLW	135
$0074	$00CA			MOVWF	STACK_10
$0075	$0BCA			DECFSZ	STACK_10, F
$0076	$2875			GOTO	$-1
$0077	$0000			NOP
;sd1602_4bit_mode.h,45 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$0078	$3030			MOVLW	48
$0079	$00B4			MOVWF	FARG_SD1602_write+0
$007A	$01B5			CLRF	FARG_SD1602_write+1, 1
$007B	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,46 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$007C	$3021			MOVLW	33
$007D	$00CB			MOVWF	STACK_11
$007E	$30FF			MOVLW	255
$007F	$00CA			MOVWF	STACK_10
$0080	$0BCB			DECFSZ	STACK_11, F
$0081	$2883			GOTO	$+2
$0082	$2886			GOTO	$+4
$0083	$0BCA			DECFSZ	STACK_10, F
$0084	$2883			GOTO	$-1
$0085	$2880			GOTO	$-5
$0086	$3060			MOVLW	96
$0087	$00CA			MOVWF	STACK_10
$0088	$0BCA			DECFSZ	STACK_10, F
$0089	$2888			GOTO	$-1
$008A	$0000			NOP
$008B	$0000			NOP
;sd1602_4bit_mode.h,47 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$008C	$3030			MOVLW	48
$008D	$00B4			MOVWF	FARG_SD1602_write+0
$008E	$01B5			CLRF	FARG_SD1602_write+1, 1
$008F	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,48 :: 		Delay_ms(5); /* 5ms�i100us�ȏ�j�̎��ԑ҂� */
$0090	$3021			MOVLW	33
$0091	$00CB			MOVWF	STACK_11
$0092	$30FF			MOVLW	255
$0093	$00CA			MOVWF	STACK_10
$0094	$0BCB			DECFSZ	STACK_11, F
$0095	$2897			GOTO	$+2
$0096	$289A			GOTO	$+4
$0097	$0BCA			DECFSZ	STACK_10, F
$0098	$2897			GOTO	$-1
$0099	$2894			GOTO	$-5
$009A	$3060			MOVLW	96
$009B	$00CA			MOVWF	STACK_10
$009C	$0BCA			DECFSZ	STACK_10, F
$009D	$289C			GOTO	$-1
$009E	$0000			NOP
$009F	$0000			NOP
;sd1602_4bit_mode.h,49 :: 		SD1602_write(0x30, 0); /* 8bit���[�h�ݒ� */
$00A0	$3030			MOVLW	48
$00A1	$00B4			MOVWF	FARG_SD1602_write+0
$00A2	$01B5			CLRF	FARG_SD1602_write+1, 1
$00A3	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,50 :: 		Delay_ms(5); /* 5ms�i4.1ms�ȏ�j�̎��ԑ҂� */
$00A4	$3021			MOVLW	33
$00A5	$00CB			MOVWF	STACK_11
$00A6	$30FF			MOVLW	255
$00A7	$00CA			MOVWF	STACK_10
$00A8	$0BCB			DECFSZ	STACK_11, F
$00A9	$28AB			GOTO	$+2
$00AA	$28AE			GOTO	$+4
$00AB	$0BCA			DECFSZ	STACK_10, F
$00AC	$28AB			GOTO	$-1
$00AD	$28A8			GOTO	$-5
$00AE	$3060			MOVLW	96
$00AF	$00CA			MOVWF	STACK_10
$00B0	$0BCA			DECFSZ	STACK_10, F
$00B1	$28B0			GOTO	$-1
$00B2	$0000			NOP
$00B3	$0000			NOP
;sd1602_4bit_mode.h,51 :: 		SD1602_write(0x20, 0); /* 4bit���[�h�ݒ� */
$00B4	$3020			MOVLW	32
$00B5	$00B4			MOVWF	FARG_SD1602_write+0
$00B6	$01B5			CLRF	FARG_SD1602_write+1, 1
$00B7	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,52 :: 		Delay_ms(5); /* 5ms�i40us�ȏ�j�̎��ԑ҂� */
$00B8	$3021			MOVLW	33
$00B9	$00CB			MOVWF	STACK_11
$00BA	$30FF			MOVLW	255
$00BB	$00CA			MOVWF	STACK_10
$00BC	$0BCB			DECFSZ	STACK_11, F
$00BD	$28BF			GOTO	$+2
$00BE	$28C2			GOTO	$+4
$00BF	$0BCA			DECFSZ	STACK_10, F
$00C0	$28BF			GOTO	$-1
$00C1	$28BC			GOTO	$-5
$00C2	$3060			MOVLW	96
$00C3	$00CA			MOVWF	STACK_10
$00C4	$0BCA			DECFSZ	STACK_10, F
$00C5	$28C4			GOTO	$-1
$00C6	$0000			NOP
$00C7	$0000			NOP
;sd1602_4bit_mode.h,53 :: 		SD1602_control(0x28); /* 4bit���[�h��2�s�\���ɐݒ肷�� */
$00C8	$3028			MOVLW	40
$00C9	$00B3			MOVWF	FARG_SD1602_control+0
$00CA	$21B4			CALL	_SD1602_control
;sd1602_4bit_mode.h,54 :: 		SD1602_control(0x08); /* �e�L�X�g�\�����I�t�ɂ��� */
$00CB	$3008			MOVLW	8
$00CC	$00B3			MOVWF	FARG_SD1602_control+0
$00CD	$21B4			CALL	_SD1602_control
;sd1602_4bit_mode.h,55 :: 		SD1602_control(0x0C); /* �e�L�X�g�\�����I���ɂ��� */
$00CE	$300C			MOVLW	12
$00CF	$00B3			MOVWF	FARG_SD1602_control+0
$00D0	$21B4			CALL	_SD1602_control
;sd1602_4bit_mode.h,56 :: 		SD1602_control(0x06); /* �J�[�\���ړ����E�����ɐݒ肷�� */
$00D1	$3006			MOVLW	6
$00D2	$00B3			MOVWF	FARG_SD1602_control+0
$00D3	$21B4			CALL	_SD1602_control
;sd1602_4bit_mode.h,57 :: 		}
$00D4	$0008			RETURN
$0181	$	_SD1602_clear:
;sd1602_4bit_mode.h,35 :: 		void SD1602_clear(void)
;sd1602_4bit_mode.h,37 :: 		SD1602_write(0x01, 0); /* ����R�[�h�̏��4bit��n�� */
$0181	$3001			MOVLW	1
$0182	$1303			BCF	STATUS, RP1
$0183	$1283			BCF	STATUS, RP0
$0184	$00B4			MOVWF	FARG_SD1602_write+0
$0185	$01B5			CLRF	FARG_SD1602_write+1, 1
$0186	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,38 :: 		SD1602_write(0x01 << 4, 0); /* ����R�[�h�̉���4bit��n�� */
$0187	$3010			MOVLW	16
$0188	$00B4			MOVWF	FARG_SD1602_write+0
$0189	$01B5			CLRF	FARG_SD1602_write+1, 1
$018A	$2164			CALL	_SD1602_write
;sd1602_4bit_mode.h,39 :: 		Delay_ms(2); /* 2ms�i1.64ms�ȏ�j�̎��ԑ҂� */
$018B	$300D			MOVLW	13
$018C	$00CB			MOVWF	STACK_11
$018D	$30FF			MOVLW	255
$018E	$00CA			MOVWF	STACK_10
$018F	$0BCB			DECFSZ	STACK_11, F
$0190	$2992			GOTO	$+2
$0191	$2995			GOTO	$+4
$0192	$0BCA			DECFSZ	STACK_10, F
$0193	$2992			GOTO	$-1
$0194	$298F			GOTO	$-5
$0195	$30F3			MOVLW	243
$0196	$00CA			MOVWF	STACK_10
$0197	$0BCA			DECFSZ	STACK_10, F
$0198	$2997			GOTO	$-1
$0199	$0000			NOP
;sd1602_4bit_mode.h,40 :: 		}
$019A	$0008			RETURN
$013E	$	_strConstCpy:
;utils.h,3 :: 		(char *dest, const char *source)
;utils.h,5 :: 		while(*source)
$013E	$	L_strConstCpy_4:
$013E	$1303			BCF	STATUS, RP1
$013F	$1283			BCF	STATUS, RP0
$0140	$0831			MOVF	FARG_strConstCpy+1, 0
$0141	$008E			MOVWF	___DoICPLoAddr
$0142	$0832			MOVF	FARG_strConstCpy+2, 0
$0143	$008D			MOVWF	___DoICPHiAddr
$0144	$080A			MOVF	PCLATH, 0
$0145	$008C			MOVWF	___DoICPSavePCLATH
$0146	$21E8			CALL	_____DoICP
$0147	$00C0			MOVWF	STACK_0
$0148	$080C			MOVF	___DoICPSavePCLATH, 0
$0149	$008A			MOVWF	PCLATH
$014A	$0840			MOVF	STACK_0, 0
$014B	$1903			BTFSC	STATUS, Z
$014C	$2960			GOTO	L_strConstCpy_5
;utils.h,6 :: 		*dest++ = *source++ ;
$014D	$0831			MOVF	FARG_strConstCpy+1, 0
$014E	$008E			MOVWF	___DoICPLoAddr
$014F	$0832			MOVF	FARG_strConstCpy+2, 0
$0150	$008D			MOVWF	___DoICPHiAddr
$0151	$080A			MOVF	PCLATH, 0
$0152	$008C			MOVWF	___DoICPSavePCLATH
$0153	$21E8			CALL	_____DoICP
$0154	$00C0			MOVWF	STACK_0
$0155	$080C			MOVF	___DoICPSavePCLATH, 0
$0156	$008A			MOVWF	PCLATH
$0157	$0830			MOVF	FARG_strConstCpy+0, 0
$0158	$0084			MOVWF	FSR
$0159	$0840			MOVF	STACK_0, 0
$015A	$0080			MOVWF	INDF
$015B	$0AB0			INCF	FARG_strConstCpy+0, 1
$015C	$0AB1			INCF	FARG_strConstCpy+1, 1
$015D	$1903			BTFSC	STATUS, Z
$015E	$0AB2			INCF	FARG_strConstCpy+2, 1
$015F	$293E			GOTO	L_strConstCpy_4
$0160	$	L_strConstCpy_5:
;utils.h,8 :: 		*dest = 0 ;
$0160	$0830			MOVF	FARG_strConstCpy+0, 0
$0161	$0084			MOVWF	FSR
$0162	$0180			CLRF	INDF, 1
;utils.h,9 :: 		}
$0163	$0008			RETURN
$01DD	$	table___s2:
;D_82_16F84A_SD1602_v_4_1.c,6 :: 		const char s2[]  = "xylophone";
$01DD	$3478			RETLW	120
$01DE	$3479			RETLW	121
$01DF	$346C			RETLW	108
$01E0	$346F			RETLW	111
$01E1	$3470			RETLW	112
$01E2	$3468			RETLW	104
$01E3	$346F			RETLW	111
$01E4	$346E			RETLW	110
$01E5	$3465			RETLW	101
$01E6	$3400			RETLW	0
$01E7	$0008			RETURN
$01CB	$	_SD1602_print:
;sd1602_4bit_mode.h,59 :: 		void SD1602_print(char *s)
;sd1602_4bit_mode.h,61 :: 		while (*s != 0x00) /* �i�������i0x00�j���������܂� */
$01CB	$	L_SD1602_print_2:
$01CB	$1303			BCF	STATUS, RP1
$01CC	$1283			BCF	STATUS, RP0
$01CD	$0830			MOVF	FARG_SD1602_print+0, 0
$01CE	$0084			MOVWF	FSR
$01CF	$0800			MOVF	INDF, 0
$01D0	$00C1			MOVWF	STACK_1
$01D1	$0841			MOVF	STACK_1, 0
$01D2	$3A00			XORLW	0
$01D3	$1903			BTFSC	STATUS, Z
$01D4	$29DC			GOTO	L_SD1602_print_3
;sd1602_4bit_mode.h,63 :: 		SD1602_display(*s); /* �e�L�X�g�f�[�^��\������ */
$01D5	$0830			MOVF	FARG_SD1602_print+0, 0
$01D6	$0084			MOVWF	FSR
$01D7	$0800			MOVF	INDF, 0
$01D8	$00B3			MOVWF	FARG_SD1602_display+0
$01D9	$219B			CALL	_SD1602_display
;sd1602_4bit_mode.h,64 :: 		s++;
$01DA	$0AB0			INCF	FARG_SD1602_print+0, 1
;sd1602_4bit_mode.h,65 :: 		}
$01DB	$29CB			GOTO	L_SD1602_print_2
$01DC	$	L_SD1602_print_3:
;sd1602_4bit_mode.h,66 :: 		}
$01DC	$0008			RETURN
$00D5	$	_main:
;D_82_16F84A_SD1602_v_4_1.c,39 :: 		void main(void)
;D_82_16F84A_SD1602_v_4_1.c,46 :: 		TRISA     = 0x00;
$00D5	$1303			BCF	STATUS, RP1
$00D6	$1683			BSF	STATUS, RP0
$00D7	$0185			CLRF	TRISA, 1
;D_82_16F84A_SD1602_v_4_1.c,47 :: 		PORTA     = 0x00;
$00D8	$1283			BCF	STATUS, RP0
$00D9	$0185			CLRF	PORTA, 1
;D_82_16F84A_SD1602_v_4_1.c,50 :: 		TRISB     = 0x01;
$00DA	$3001			MOVLW	1
$00DB	$1683			BSF	STATUS, RP0
$00DC	$0086			MOVWF	TRISB
;D_82_16F84A_SD1602_v_4_1.c,53 :: 		PORTB     = 0x80;  // 1000 0000
$00DD	$3080			MOVLW	128
$00DE	$1283			BCF	STATUS, RP0
$00DF	$0086			MOVWF	PORTB
;D_82_16F84A_SD1602_v_4_1.c,55 :: 		OPTION_REG &= 0x7F;
$00E0	$307F			MOVLW	127
$00E1	$1683			BSF	STATUS, RP0
$00E2	$0501			ANDWF	OPTION_REG, 0
$00E3	$00C0			MOVWF	STACK_0
$00E4	$0840			MOVF	STACK_0, 0
$00E5	$0081			MOVWF	OPTION_REG
;D_82_16F84A_SD1602_v_4_1.c,56 :: 		OPTION_REG &= 0xBF;
$00E6	$30BF			MOVLW	191
$00E7	$0540			ANDWF	STACK_0, 0
$00E8	$0081			MOVWF	OPTION_REG
;D_82_16F84A_SD1602_v_4_1.c,58 :: 		INTCON         |= 0x10;
$00E9	$160B			BSF	INTCON, 4
;D_82_16F84A_SD1602_v_4_1.c,59 :: 		INTCON         |= 0x80;
$00EA	$178B			BSF	INTCON, 7
;D_82_16F84A_SD1602_v_4_1.c,62 :: 		SD1602_init();
$00EB	$2067			CALL	_SD1602_init
;D_82_16F84A_SD1602_v_4_1.c,64 :: 		SD1602_clear();
$00EC	$2181			CALL	_SD1602_clear
;D_82_16F84A_SD1602_v_4_1.c,68 :: 		strConstCpy(s, s2);
$00ED	$300F			MOVLW	_s
$00EE	$00B0			MOVWF	FARG_strConstCpy+0
$00EF	$30DD			MOVLW	#_s2
$00F0	$00B1			MOVWF	FARG_strConstCpy+1
$00F1	$3001			MOVLW	@#_s2
$00F2	$00B2			MOVWF	FARG_strConstCpy+2
$00F3	$213E			CALL	_strConstCpy
;D_82_16F84A_SD1602_v_4_1.c,70 :: 		while(1)
$00F4	$	L_main_7:
;D_82_16F84A_SD1602_v_4_1.c,76 :: 		SD1602_control(0x80);
$00F4	$3080			MOVLW	128
$00F5	$00B3			MOVWF	FARG_SD1602_control+0
$00F6	$21B4			CALL	_SD1602_control
;D_82_16F84A_SD1602_v_4_1.c,77 :: 		SD1602_print(s);
$00F7	$300F			MOVLW	_s
$00F8	$00B0			MOVWF	FARG_SD1602_print+0
$00F9	$21CB			CALL	_SD1602_print
;D_82_16F84A_SD1602_v_4_1.c,79 :: 		Delay_ms(1000);
$00FA	$301A			MOVLW	26
$00FB	$00CC			MOVWF	STACK_12
$00FC	$30FF			MOVLW	255
$00FD	$00CB			MOVWF	STACK_11
$00FE	$30FF			MOVLW	255
$00FF	$00CA			MOVWF	STACK_10
$0100	$0BCC			DECFSZ	STACK_12, F
$0101	$2903			GOTO	$+2
$0102	$290A			GOTO	$+8
$0103	$0BCB			DECFSZ	STACK_11, F
$0104	$2906			GOTO	$+2
$0105	$2909			GOTO	$+4
$0106	$0BCA			DECFSZ	STACK_10, F
$0107	$2906			GOTO	$-1
$0108	$2903			GOTO	$-5
$0109	$2900			GOTO	$-9
$010A	$307F			MOVLW	127
$010B	$00CB			MOVWF	STACK_11
$010C	$30FF			MOVLW	255
$010D	$00CA			MOVWF	STACK_10
$010E	$0BCB			DECFSZ	STACK_11, F
$010F	$2911			GOTO	$+2
$0110	$2914			GOTO	$+4
$0111	$0BCA			DECFSZ	STACK_10, F
$0112	$2911			GOTO	$-1
$0113	$290E			GOTO	$-5
$0114	$3058			MOVLW	88
$0115	$00CA			MOVWF	STACK_10
$0116	$0BCA			DECFSZ	STACK_10, F
$0117	$2916			GOTO	$-1
$0118	$0000			NOP
$0119	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,81 :: 		SD1602_clear();
$011A	$2181			CALL	_SD1602_clear
;D_82_16F84A_SD1602_v_4_1.c,83 :: 		Delay_ms(500);
$011B	$300D			MOVLW	13
$011C	$00CC			MOVWF	STACK_12
$011D	$30FF			MOVLW	255
$011E	$00CB			MOVWF	STACK_11
$011F	$30FF			MOVLW	255
$0120	$00CA			MOVWF	STACK_10
$0121	$0BCC			DECFSZ	STACK_12, F
$0122	$2924			GOTO	$+2
$0123	$292B			GOTO	$+8
$0124	$0BCB			DECFSZ	STACK_11, F
$0125	$2927			GOTO	$+2
$0126	$292A			GOTO	$+4
$0127	$0BCA			DECFSZ	STACK_10, F
$0128	$2927			GOTO	$-1
$0129	$2924			GOTO	$-5
$012A	$2921			GOTO	$-9
$012B	$30BF			MOVLW	191
$012C	$00CB			MOVWF	STACK_11
$012D	$30FF			MOVLW	255
$012E	$00CA			MOVWF	STACK_10
$012F	$0BCB			DECFSZ	STACK_11, F
$0130	$2932			GOTO	$+2
$0131	$2935			GOTO	$+4
$0132	$0BCA			DECFSZ	STACK_10, F
$0133	$2932			GOTO	$-1
$0134	$292F			GOTO	$-5
$0135	$302B			MOVLW	43
$0136	$00CA			MOVWF	STACK_10
$0137	$0BCA			DECFSZ	STACK_10, F
$0138	$2937			GOTO	$-1
$0139	$0000			NOP
$013A	$0000			NOP
$013B	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,100 :: 		}//while(1)
$013C	$28F4			GOTO	L_main_7
;D_82_16F84A_SD1602_v_4_1.c,102 :: 		}
$013D	$293D			GOTO	$