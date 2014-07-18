;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/07/18 20:58:15
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2835			GOTO	_main
$0071	$	__pulse:
;D_85_16F84A_Remote_v_5_3_0.c,22 :: 		void _pulse(void)
;D_85_16F84A_Remote_v_5_3_0.c,26 :: 		PORTA        = 0x01;   // RA0 => on
$0071	$3001			MOVLW	1
$0072	$1303			BCF	STATUS, RP1
$0073	$1283			BCF	STATUS, RP0
$0074	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_5_3_0.c,27 :: 		Delay_us(9);   // 8.8us
$0075	$300E			MOVLW	14
$0076	$00CA			MOVWF	STACK_10
$0077	$0BCA			DECFSZ	STACK_10, F
$0078	$2877			GOTO	$-1
$0079	$0000			NOP
$007A	$0000			NOP
;D_85_16F84A_Remote_v_5_3_0.c,29 :: 		PORTA        = 0x00;   // RA0 => off
$007B	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_3_0.c,30 :: 		Delay_us(17);   // 26.3us - 8.8us =% 17us
$007C	$301C			MOVLW	28
$007D	$00CA			MOVWF	STACK_10
$007E	$0BCA			DECFSZ	STACK_10, F
$007F	$287E			GOTO	$-1
;D_85_16F84A_Remote_v_5_3_0.c,32 :: 		}
$0080	$0008			RETURN
$0055	$	__reader:
;D_85_16F84A_Remote_v_5_3_0.c,34 :: 		void _reader(void)
;D_85_16F84A_Remote_v_5_3_0.c,37 :: 		TMR0     = 0;
$0055	$1303			BCF	STATUS, RP1
$0056	$1283			BCF	STATUS, RP0
$0057	$0181			CLRF	TMR0, 1
;D_85_16F84A_Remote_v_5_3_0.c,41 :: 		while(MS90)         // 9.0ms
$0058	$	L__reader_0:
$0058	$30B0			MOVLW	176
$0059	$0201			SUBWF	TMR0, 0
$005A	$1803			BTFSC	STATUS, C
$005B	$286A			GOTO	L__reader_1
;D_85_16F84A_Remote_v_5_3_0.c,44 :: 		PORTA        = 0x01;   // RA0 => on
$005C	$3001			MOVLW	1
$005D	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_5_3_0.c,45 :: 		Delay_us(9);   // 8.8us
$005E	$300E			MOVLW	14
$005F	$00CA			MOVWF	STACK_10
$0060	$0BCA			DECFSZ	STACK_10, F
$0061	$2860			GOTO	$-1
$0062	$0000			NOP
$0063	$0000			NOP
;D_85_16F84A_Remote_v_5_3_0.c,47 :: 		PORTA        = 0x00;   // RA0 => off
$0064	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_3_0.c,48 :: 		Delay_us(17);   // 26.3us - 8.8us =% 17us
$0065	$301C			MOVLW	28
$0066	$00CA			MOVWF	STACK_10
$0067	$0BCA			DECFSZ	STACK_10, F
$0068	$2867			GOTO	$-1
;D_85_16F84A_Remote_v_5_3_0.c,50 :: 		}
$0069	$2858			GOTO	L__reader_0
$006A	$	L__reader_1:
;D_85_16F84A_Remote_v_5_3_0.c,52 :: 		TMR0 = 0;
$006A	$0181			CLRF	TMR0, 1
;D_85_16F84A_Remote_v_5_3_0.c,53 :: 		PORTA = 0x00;
$006B	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_3_0.c,55 :: 		while(MS45)       // 4.5ms
$006C	$	L__reader_2:
$006C	$3058			MOVLW	88
$006D	$0201			SUBWF	TMR0, 0
$006E	$1C03			BTFSS	STATUS, C
$006F	$286C			GOTO	L__reader_2
;D_85_16F84A_Remote_v_5_3_0.c,59 :: 		}
$0070	$	L__reader_3:
;D_85_16F84A_Remote_v_5_3_0.c,61 :: 		}//void _reader(void)
$0070	$0008			RETURN
$0004	$	__custom_lower:
;D_85_16F84A_Remote_v_5_3_0.c,63 :: 		void _custom_lower(void)
;D_85_16F84A_Remote_v_5_3_0.c,65 :: 		usi bit_len = 4;
$0004	$3004			MOVLW	4
$0005	$1303			BCF	STATUS, RP1
$0006	$1283			BCF	STATUS, RP0
$0007	$0091			MOVWF	_custom_lower_bit_len_L0
;D_85_16F84A_Remote_v_5_3_0.c,67 :: 		custom_code_a = 0x0A;
$0008	$300A			MOVLW	10
$0009	$008C			MOVWF	_custom_code_a
;D_85_16F84A_Remote_v_5_3_0.c,69 :: 		for(i = 0; i < bit_len; i++)
$000A	$018D			CLRF	_i, 1
$000B	$	L__custom_lower_4:
$000B	$0811			MOVF	_custom_lower_bit_len_L0, 0
$000C	$020D			SUBWF	_i, 0
$000D	$1803			BTFSC	STATUS, C
$000E	$2834			GOTO	L__custom_lower_5
;D_85_16F84A_Remote_v_5_3_0.c,77 :: 		RESET_TMR;
$000F	$0181			CLRF	TMR0, 1
;D_85_16F84A_Remote_v_5_3_0.c,79 :: 		while(TMR0 < 11)	// 0.56ms
$0010	$	L__custom_lower_7:
$0010	$300B			MOVLW	11
$0011	$0201			SUBWF	TMR0, 0
$0012	$1803			BTFSC	STATUS, C
$0013	$2816			GOTO	L__custom_lower_8
;D_85_16F84A_Remote_v_5_3_0.c,81 :: 		_pulse();
$0014	$2071			CALL	__pulse
;D_85_16F84A_Remote_v_5_3_0.c,83 :: 		}
$0015	$2810			GOTO	L__custom_lower_7
$0016	$	L__custom_lower_8:
;D_85_16F84A_Remote_v_5_3_0.c,90 :: 		PORTA = 0x00;
$0016	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_3_0.c,92 :: 		if (((custom_code_a >> i) & 0x01) == 0)
$0017	$080D			MOVF	_i, 0
$0018	$00C1			MOVWF	STACK_1
$0019	$080C			MOVF	_custom_code_a, 0
$001A	$00C0			MOVWF	STACK_0
$001B	$0841			MOVF	STACK_1, 0
$001C	$	L__custom_lower_17:
$001C	$1903			BTFSC	STATUS, Z
$001D	$2822			GOTO	L__custom_lower_18
$001E	$0CC0			RRF	STACK_0, 1
$001F	$13C0			BCF	STACK_0, 7
$0020	$3FFF			ADDLW	255
$0021	$281C			GOTO	L__custom_lower_17
$0022	$	L__custom_lower_18:
$0022	$3001			MOVLW	1
$0023	$0540			ANDWF	STACK_0, 0
$0024	$00C1			MOVWF	STACK_1
$0025	$0841			MOVF	STACK_1, 0
$0026	$3A00			XORLW	0
$0027	$1D03			BTFSS	STATUS, Z
$0028	$282E			GOTO	L__custom_lower_9
;D_85_16F84A_Remote_v_5_3_0.c,95 :: 		while(TMR0 < 22)	// 1.125ms
$0029	$	L__custom_lower_10:
$0029	$3016			MOVLW	22
$002A	$0201			SUBWF	TMR0, 0
$002B	$1C03			BTFSS	STATUS, C
$002C	$2829			GOTO	L__custom_lower_10
;D_85_16F84A_Remote_v_5_3_0.c,98 :: 		}
$002D	$	L__custom_lower_11:
;D_85_16F84A_Remote_v_5_3_0.c,100 :: 		} else {
$002D	$2832			GOTO	L__custom_lower_12
$002E	$	L__custom_lower_9:
;D_85_16F84A_Remote_v_5_3_0.c,102 :: 		while(TMR0 < 44)	// 2.250ms
$002E	$	L__custom_lower_13:
$002E	$302C			MOVLW	44
$002F	$0201			SUBWF	TMR0, 0
$0030	$1C03			BTFSS	STATUS, C
$0031	$282E			GOTO	L__custom_lower_13
;D_85_16F84A_Remote_v_5_3_0.c,105 :: 		}
$0032	$	L__custom_lower_14:
;D_85_16F84A_Remote_v_5_3_0.c,107 :: 		}//if (((custom_code_a >> i) & 0x01) == 0)
$0032	$	L__custom_lower_12:
;D_85_16F84A_Remote_v_5_3_0.c,109 :: 		}//for(i = 0; i < bit_len)
$0032	$	L__custom_lower_6:
;D_85_16F84A_Remote_v_5_3_0.c,69 :: 		for(i = 0; i < bit_len; i++)
$0032	$0A8D			INCF	_i, 1
;D_85_16F84A_Remote_v_5_3_0.c,109 :: 		}//for(i = 0; i < bit_len)
$0033	$280B			GOTO	L__custom_lower_4
$0034	$	L__custom_lower_5:
;D_85_16F84A_Remote_v_5_3_0.c,112 :: 		}//_custom_lower
$0034	$0008			RETURN
$0035	$	_main:
;D_85_16F84A_Remote_v_5_3_0.c,114 :: 		void main(void)
;D_85_16F84A_Remote_v_5_3_0.c,121 :: 		TRISA     = 0x00;
$0035	$1303			BCF	STATUS, RP1
$0036	$1683			BSF	STATUS, RP0
$0037	$0185			CLRF	TRISA, 1
;D_85_16F84A_Remote_v_5_3_0.c,122 :: 		PORTA     = 0x00;		//0000 0010
$0038	$1283			BCF	STATUS, RP0
$0039	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_3_0.c,124 :: 		TRISB     = 0x00;		// Input: RB0 ~ RB7
$003A	$1683			BSF	STATUS, RP0
$003B	$0186			CLRF	TRISB, 1
;D_85_16F84A_Remote_v_5_3_0.c,125 :: 		PORTB     = 0x00;
$003C	$1283			BCF	STATUS, RP0
$003D	$0186			CLRF	PORTB, 1
;D_85_16F84A_Remote_v_5_3_0.c,127 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$003E	$30DF			MOVLW	223
$003F	$1683			BSF	STATUS, RP0
$0040	$0501			ANDWF	OPTION_REG, 0
$0041	$00C0			MOVWF	STACK_0
$0042	$0840			MOVF	STACK_0, 0
$0043	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_3_0.c,128 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$0044	$30F0			MOVLW	240
$0045	$05C0			ANDWF	STACK_0, 1
$0046	$0840			MOVF	STACK_0, 0
$0047	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_3_0.c,129 :: 		OPTION_REG |= 0x07;	// Prescaler => 1/256
$0048	$3007			MOVLW	7
$0049	$0440			IORWF	STACK_0, 0
$004A	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_3_0.c,131 :: 		custom_code_a = 0xFF;
$004B	$30FF			MOVLW	255
$004C	$008C			MOVWF	_custom_code_a
;D_85_16F84A_Remote_v_5_3_0.c,132 :: 		custom_code_b = 0x00;
$004D	$018E			CLRF	_custom_code_b, 1
;D_85_16F84A_Remote_v_5_3_0.c,133 :: 		data_code_a   = 0x00;   // Button '+'
$004E	$018F			CLRF	_data_code_a, 1
;D_85_16F84A_Remote_v_5_3_0.c,134 :: 		data_code_b   = ~data_code_a;
$004F	$30FF			MOVLW	255
$0050	$0090			MOVWF	_data_code_b
;D_85_16F84A_Remote_v_5_3_0.c,136 :: 		while(1)
$0051	$	L_main_15:
;D_85_16F84A_Remote_v_5_3_0.c,141 :: 		_reader();
$0051	$2055			CALL	__reader
;D_85_16F84A_Remote_v_5_3_0.c,146 :: 		_custom_lower();
$0052	$2004			CALL	__custom_lower
;D_85_16F84A_Remote_v_5_3_0.c,152 :: 		}//while(1)
$0053	$2851			GOTO	L_main_15
;D_85_16F84A_Remote_v_5_3_0.c,154 :: 		}//void main(void)
$0054	$2854			GOTO	$
