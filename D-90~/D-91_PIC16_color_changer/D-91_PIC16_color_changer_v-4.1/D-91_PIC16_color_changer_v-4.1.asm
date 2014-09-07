;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/09/07 13:08:28
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2993			GOTO	_main
$0071	$	__pulse:
;D-91_PIC16_color_changer_v-4.1.c,59 :: 		void _pulse(int num)
;D-91_PIC16_color_changer_v-4.1.c,63 :: 		for(i = 0; i < num; i++)
$0071	$1303			BCF	STATUS, RP1
$0072	$1283			BCF	STATUS, RP0
$0073	$019A			CLRF	_pulse_i_L0
$0074	$019B			CLRF	_pulse_i_L0+1
$0075	$	L__pulse_0:
$0075	$3080			MOVLW	128
$0076	$061B			XORWF	_pulse_i_L0+1, 0
$0077	$00C0			MOVWF	STACK_0
$0078	$3080			MOVLW	128
$0079	$0619			XORWF	FARG__pulse+1, 0
$007A	$0240			SUBWF	STACK_0, 0
$007B	$1D03			BTFSS	STATUS, Z
$007C	$287F			GOTO	L__pulse_48
$007D	$0818			MOVF	FARG__pulse+0, 0
$007E	$021A			SUBWF	_pulse_i_L0, 0
$007F	$	L__pulse_48:
$007F	$1803			BTFSC	STATUS, C
$0080	$28A8			GOTO	L__pulse_1
;D-91_PIC16_color_changer_v-4.1.c,66 :: 		PORTA = 0x01; Delay_ms(1);
$0081	$3001			MOVLW	1
$0082	$0085			MOVWF	PORTA
$0083	$3007			MOVLW	7
$0084	$00CB			MOVWF	STACK_11
$0085	$30FF			MOVLW	255
$0086	$00CA			MOVWF	STACK_10
$0087	$0BCB			DECFSZ	STACK_11, F
$0088	$288A			GOTO	$+2
$0089	$288D			GOTO	$+4
$008A	$0BCA			DECFSZ	STACK_10, F
$008B	$288A			GOTO	$-1
$008C	$2887			GOTO	$-5
$008D	$3078			MOVLW	120
$008E	$00CA			MOVWF	STACK_10
$008F	$0BCA			DECFSZ	STACK_10, F
$0090	$288F			GOTO	$-1
$0091	$0000			NOP
$0092	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,68 :: 		PORTA = 0x00; Delay_ms(1);
$0093	$0185			CLRF	PORTA, 1
$0094	$3007			MOVLW	7
$0095	$00CB			MOVWF	STACK_11
$0096	$30FF			MOVLW	255
$0097	$00CA			MOVWF	STACK_10
$0098	$0BCB			DECFSZ	STACK_11, F
$0099	$289B			GOTO	$+2
$009A	$289E			GOTO	$+4
$009B	$0BCA			DECFSZ	STACK_10, F
$009C	$289B			GOTO	$-1
$009D	$2898			GOTO	$-5
$009E	$3078			MOVLW	120
$009F	$00CA			MOVWF	STACK_10
$00A0	$0BCA			DECFSZ	STACK_10, F
$00A1	$28A0			GOTO	$-1
$00A2	$0000			NOP
$00A3	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,70 :: 		}
$00A4	$	L__pulse_2:
;D-91_PIC16_color_changer_v-4.1.c,63 :: 		for(i = 0; i < num; i++)
$00A4	$0A9A			INCF	_pulse_i_L0, 1
$00A5	$1903			BTFSC	STATUS, Z
$00A6	$0A9B			INCF	_pulse_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,70 :: 		}
$00A7	$2875			GOTO	L__pulse_0
$00A8	$	L__pulse_1:
;D-91_PIC16_color_changer_v-4.1.c,72 :: 		}
$00A8	$0008			RETURN
$0133	$	__pulse_u_50:
;D-91_PIC16_color_changer_v-4.1.c,126 :: 		_pulse_u_50(int num)
;D-91_PIC16_color_changer_v-4.1.c,130 :: 		for(i = 0; i < num; i++)
$0133	$1303			BCF	STATUS, RP1
$0134	$1283			BCF	STATUS, RP0
$0135	$019A			CLRF	_pulse_u_50_i_L0
$0136	$019B			CLRF	_pulse_u_50_i_L0+1
$0137	$	L__pulse_u_50_12:
$0137	$3080			MOVLW	128
$0138	$061B			XORWF	_pulse_u_50_i_L0+1, 0
$0139	$00C0			MOVWF	STACK_0
$013A	$3080			MOVLW	128
$013B	$0619			XORWF	FARG__pulse_u_50+1, 0
$013C	$0240			SUBWF	STACK_0, 0
$013D	$1D03			BTFSS	STATUS, Z
$013E	$2941			GOTO	L__pulse_u_50_52
$013F	$0818			MOVF	FARG__pulse_u_50+0, 0
$0140	$021A			SUBWF	_pulse_u_50_i_L0, 0
$0141	$	L__pulse_u_50_52:
$0141	$1803			BTFSC	STATUS, C
$0142	$2952			GOTO	L__pulse_u_50_13
;D-91_PIC16_color_changer_v-4.1.c,133 :: 		PORTA = 0x01; Delay_us(50);
$0143	$3001			MOVLW	1
$0144	$0085			MOVWF	PORTA
$0145	$3053			MOVLW	83
$0146	$00CA			MOVWF	STACK_10
$0147	$0BCA			DECFSZ	STACK_10, F
$0148	$2947			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,135 :: 		PORTA = 0x00; Delay_us(50);
$0149	$0185			CLRF	PORTA, 1
$014A	$3053			MOVLW	83
$014B	$00CA			MOVWF	STACK_10
$014C	$0BCA			DECFSZ	STACK_10, F
$014D	$294C			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,137 :: 		}
$014E	$	L__pulse_u_50_14:
;D-91_PIC16_color_changer_v-4.1.c,130 :: 		for(i = 0; i < num; i++)
$014E	$0A9A			INCF	_pulse_u_50_i_L0, 1
$014F	$1903			BTFSC	STATUS, Z
$0150	$0A9B			INCF	_pulse_u_50_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,137 :: 		}
$0151	$2937			GOTO	L__pulse_u_50_12
$0152	$	L__pulse_u_50_13:
;D-91_PIC16_color_changer_v-4.1.c,139 :: 		}//_pulse_u_50
$0152	$0008			RETURN
$0172	$	__while_PORTB_0x01:
;D-91_PIC16_color_changer_v-4.1.c,141 :: 		void _while_PORTB_0x01(int num)
;D-91_PIC16_color_changer_v-4.1.c,144 :: 		while((PORTB & 0x01) == num) //---------------------
$0172	$	L__while_PORTB_0x01_15:
$0172	$3001			MOVLW	1
$0173	$1303			BCF	STATUS, RP1
$0174	$1283			BCF	STATUS, RP0
$0175	$0506			ANDWF	PORTB, 0
$0176	$00C1			MOVWF	STACK_1
$0177	$3000			MOVLW	0
$0178	$0615			XORWF	FARG__while_PORTB_0x01+1, 0
$0179	$1D03			BTFSS	STATUS, Z
$017A	$297D			GOTO	L__while_PORTB_0x01_53
$017B	$0814			MOVF	FARG__while_PORTB_0x01+0, 0
$017C	$0641			XORWF	STACK_1, 0
$017D	$	L__while_PORTB_0x01_53:
$017D	$1D03			BTFSS	STATUS, Z
$017E	$298A			GOTO	L__while_PORTB_0x01_16
;D-91_PIC16_color_changer_v-4.1.c,147 :: 		if(TMR0 == 255)
$017F	$0801			MOVF	TMR0, 0
$0180	$3AFF			XORLW	255
$0181	$1D03			BTFSS	STATUS, Z
$0182	$2989			GOTO	L__while_PORTB_0x01_17
;D-91_PIC16_color_changer_v-4.1.c,151 :: 		_pulse(3);
$0183	$3003			MOVLW	3
$0184	$0098			MOVWF	FARG__pulse+0
$0185	$3000			MOVLW	0
$0186	$0099			MOVWF	FARG__pulse+1
$0187	$2071			CALL	__pulse
;D-91_PIC16_color_changer_v-4.1.c,154 :: 		return;
$0188	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,156 :: 		}
$0189	$	L__while_PORTB_0x01_17:
;D-91_PIC16_color_changer_v-4.1.c,158 :: 		}//while((PORTB & 0x01) == 0)
$0189	$2972			GOTO	L__while_PORTB_0x01_15
$018A	$	L__while_PORTB_0x01_16:
;D-91_PIC16_color_changer_v-4.1.c,160 :: 		return;
;D-91_PIC16_color_changer_v-4.1.c,162 :: 		}
$018A	$0008			RETURN
$00E0	$	__judge_TMR_:
;D-91_PIC16_color_changer_v-4.1.c,168 :: 		int _judge_TMR_(int low, int high) {
;D-91_PIC16_color_changer_v-4.1.c,170 :: 		if(TMR0 < low) //---------------------
$00E0	$3080			MOVLW	128
$00E1	$1303			BCF	STATUS, RP1
$00E2	$1283			BCF	STATUS, RP0
$00E3	$00C0			MOVWF	STACK_0
$00E4	$3080			MOVLW	128
$00E5	$0615			XORWF	FARG__judge_TMR_+1, 0
$00E6	$0240			SUBWF	STACK_0, 0
$00E7	$1D03			BTFSS	STATUS, Z
$00E8	$28EB			GOTO	L__judge_TMR__54
$00E9	$0814			MOVF	FARG__judge_TMR_+0, 0
$00EA	$0201			SUBWF	TMR0, 0
$00EB	$	L__judge_TMR__54:
$00EB	$1803			BTFSC	STATUS, C
$00EC	$28F7			GOTO	L__judge_TMR__18
;D-91_PIC16_color_changer_v-4.1.c,173 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00ED	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,174 :: 		INTCON |= 0x80;        // interrupt => permitted
$00EE	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,181 :: 		_pulse_u_50(3);
$00EF	$3003			MOVLW	3
$00F0	$0098			MOVWF	FARG__pulse_u_50+0
$00F1	$3000			MOVLW	0
$00F2	$0099			MOVWF	FARG__pulse_u_50+1
$00F3	$2133			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,183 :: 		return false;                // return
$00F4	$01C0			CLRF	STACK_0
$00F5	$01C1			CLRF	STACK_0+1
$00F6	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,194 :: 		} else if (TMR0 > high) {
$00F7	$	L__judge_TMR__18:
$00F7	$3080			MOVLW	128
$00F8	$0617			XORWF	FARG__judge_TMR_+3, 0
$00F9	$00C0			MOVWF	STACK_0
$00FA	$3080			MOVLW	128
$00FB	$0240			SUBWF	STACK_0, 0
$00FC	$1D03			BTFSS	STATUS, Z
$00FD	$2900			GOTO	L__judge_TMR__55
$00FE	$0801			MOVF	TMR0, 0
$00FF	$0216			SUBWF	FARG__judge_TMR_+2, 0
$0100	$	L__judge_TMR__55:
$0100	$1803			BTFSC	STATUS, C
$0101	$290C			GOTO	L__judge_TMR__20
;D-91_PIC16_color_changer_v-4.1.c,196 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0102	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,197 :: 		INTCON |= 0x80;        // interrupt => permitted
$0103	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,200 :: 		_pulse_u_50(2);
$0104	$3002			MOVLW	2
$0105	$0098			MOVWF	FARG__pulse_u_50+0
$0106	$3000			MOVLW	0
$0107	$0099			MOVWF	FARG__pulse_u_50+1
$0108	$2133			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,203 :: 		return false;
$0109	$01C0			CLRF	STACK_0
$010A	$01C1			CLRF	STACK_0+1
$010B	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,205 :: 		}
$010C	$	L__judge_TMR__20:
$010C	$	L__judge_TMR__19:
;D-91_PIC16_color_changer_v-4.1.c,207 :: 		return true;
$010C	$3001			MOVLW	1
$010D	$00C0			MOVWF	STACK_0
$010E	$3000			MOVLW	0
$010F	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,209 :: 		}//int _judge_TMR_(int low, int high)
$0110	$0008			RETURN
$0111	$	__pulse_u_100:
;D-91_PIC16_color_changer_v-4.1.c,110 :: 		void _pulse_u_100(int num)
;D-91_PIC16_color_changer_v-4.1.c,114 :: 		for(i = 0; i < num; i++)
$0111	$1303			BCF	STATUS, RP1
$0112	$1283			BCF	STATUS, RP0
$0113	$0196			CLRF	_pulse_u_100_i_L0
$0114	$0197			CLRF	_pulse_u_100_i_L0+1
$0115	$	L__pulse_u_100_9:
$0115	$3080			MOVLW	128
$0116	$0617			XORWF	_pulse_u_100_i_L0+1, 0
$0117	$00C0			MOVWF	STACK_0
$0118	$3080			MOVLW	128
$0119	$0615			XORWF	FARG__pulse_u_100+1, 0
$011A	$0240			SUBWF	STACK_0, 0
$011B	$1D03			BTFSS	STATUS, Z
$011C	$291F			GOTO	L__pulse_u_100_51
$011D	$0814			MOVF	FARG__pulse_u_100+0, 0
$011E	$0216			SUBWF	_pulse_u_100_i_L0, 0
$011F	$	L__pulse_u_100_51:
$011F	$1803			BTFSC	STATUS, C
$0120	$2932			GOTO	L__pulse_u_100_10
;D-91_PIC16_color_changer_v-4.1.c,117 :: 		PORTA = 0x01; Delay_us(100);
$0121	$3001			MOVLW	1
$0122	$0085			MOVWF	PORTA
$0123	$30A6			MOVLW	166
$0124	$00CA			MOVWF	STACK_10
$0125	$0BCA			DECFSZ	STACK_10, F
$0126	$2925			GOTO	$-1
$0127	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,119 :: 		PORTA = 0x00; Delay_us(100);
$0128	$0185			CLRF	PORTA, 1
$0129	$30A6			MOVLW	166
$012A	$00CA			MOVWF	STACK_10
$012B	$0BCA			DECFSZ	STACK_10, F
$012C	$292B			GOTO	$-1
$012D	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,121 :: 		}
$012E	$	L__pulse_u_100_11:
;D-91_PIC16_color_changer_v-4.1.c,114 :: 		for(i = 0; i < num; i++)
$012E	$0A96			INCF	_pulse_u_100_i_L0, 1
$012F	$1903			BTFSC	STATUS, Z
$0130	$0A97			INCF	_pulse_u_100_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,121 :: 		}
$0131	$2915			GOTO	L__pulse_u_100_9
$0132	$	L__pulse_u_100_10:
;D-91_PIC16_color_changer_v-4.1.c,123 :: 		}
$0132	$0008			RETURN
$00A9	$	__read_Reader:
;D-91_PIC16_color_changer_v-4.1.c,421 :: 		_read_Reader() {
;D-91_PIC16_color_changer_v-4.1.c,428 :: 		RESET_TMR;
$00A9	$1303			BCF	STATUS, RP1
$00AA	$1283			BCF	STATUS, RP0
$00AB	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,438 :: 		_while_PORTB_0x01(0);
$00AC	$0194			CLRF	FARG__while_PORTB_0x01+0
$00AD	$0195			CLRF	FARG__while_PORTB_0x01+1
$00AE	$2172			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,449 :: 		result = _judge_TMR_(156, 196);
$00AF	$309C			MOVLW	156
$00B0	$1303			BCF	STATUS, RP1
$00B1	$1283			BCF	STATUS, RP0
$00B2	$0094			MOVWF	FARG__judge_TMR_+0
$00B3	$0195			CLRF	FARG__judge_TMR_+1
$00B4	$30C4			MOVLW	196
$00B5	$0096			MOVWF	FARG__judge_TMR_+2
$00B6	$0197			CLRF	FARG__judge_TMR_+3
$00B7	$20E0			CALL	__judge_TMR_
$00B8	$0840			MOVF	STACK_0, 0
$00B9	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,451 :: 		if (result == false) {
$00BA	$0840			MOVF	STACK_0, 0
$00BB	$3A00			XORLW	0
$00BC	$1D03			BTFSS	STATUS, Z
$00BD	$28C1			GOTO	L__read_Reader_35
;D-91_PIC16_color_changer_v-4.1.c,455 :: 		return false;
$00BE	$01C0			CLRF	STACK_0
$00BF	$01C1			CLRF	STACK_0+1
$00C0	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,457 :: 		}
$00C1	$	L__read_Reader_35:
;D-91_PIC16_color_changer_v-4.1.c,469 :: 		RESET_TMR;
$00C1	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,476 :: 		_while_PORTB_0x01(1);
$00C2	$3001			MOVLW	1
$00C3	$0094			MOVWF	FARG__while_PORTB_0x01+0
$00C4	$3000			MOVLW	0
$00C5	$0095			MOVWF	FARG__while_PORTB_0x01+1
$00C6	$2172			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,483 :: 		result = _judge_TMR_(68, 108);
$00C7	$3044			MOVLW	68
$00C8	$1303			BCF	STATUS, RP1
$00C9	$1283			BCF	STATUS, RP0
$00CA	$0094			MOVWF	FARG__judge_TMR_+0
$00CB	$3000			MOVLW	0
$00CC	$0095			MOVWF	FARG__judge_TMR_+1
$00CD	$306C			MOVLW	108
$00CE	$0096			MOVWF	FARG__judge_TMR_+2
$00CF	$3000			MOVLW	0
$00D0	$0097			MOVWF	FARG__judge_TMR_+3
$00D1	$20E0			CALL	__judge_TMR_
$00D2	$0840			MOVF	STACK_0, 0
$00D3	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,485 :: 		if (result == false) {
$00D4	$0840			MOVF	STACK_0, 0
$00D5	$3A00			XORLW	0
$00D6	$1D03			BTFSS	STATUS, Z
$00D7	$28DB			GOTO	L__read_Reader_36
;D-91_PIC16_color_changer_v-4.1.c,489 :: 		return false;
$00D8	$01C0			CLRF	STACK_0
$00D9	$01C1			CLRF	STACK_0+1
$00DA	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,491 :: 		}
$00DB	$	L__read_Reader_36:
;D-91_PIC16_color_changer_v-4.1.c,498 :: 		return true;
$00DB	$3001			MOVLW	1
$00DC	$00C0			MOVWF	STACK_0
$00DD	$3000			MOVLW	0
$00DE	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,500 :: 		}//_read_Reader
$00DF	$0008			RETURN
$002D	$	__read_Custom:
;D-91_PIC16_color_changer_v-4.1.c,503 :: 		_read_Custom() {
;D-91_PIC16_color_changer_v-4.1.c,505 :: 		custom_code_a = 0x00;
$002D	$1303			BCF	STATUS, RP1
$002E	$1283			BCF	STATUS, RP0
$002F	$018D			CLRF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,509 :: 		for(i = 0; i < bit_len; i++)
$0030	$018E			CLRF	_i, 1
$0031	$	L__read_Custom_37:
$0031	$080F			MOVF	_bit_len, 0
$0032	$020E			SUBWF	_i, 0
$0033	$1803			BTFSC	STATUS, C
$0034	$2870			GOTO	L__read_Custom_38
;D-91_PIC16_color_changer_v-4.1.c,511 :: 		RESET_TMR;
$0035	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,513 :: 		while((PORTB & 0x01) == 0)
$0036	$	L__read_Custom_40:
$0036	$3001			MOVLW	1
$0037	$0506			ANDWF	PORTB, 0
$0038	$00C1			MOVWF	STACK_1
$0039	$0841			MOVF	STACK_1, 0
$003A	$3A00			XORLW	0
$003B	$1D03			BTFSS	STATUS, Z
$003C	$2842			GOTO	L__read_Custom_41
;D-91_PIC16_color_changer_v-4.1.c,516 :: 		TIME_OUT;
$003D	$0801			MOVF	TMR0, 0
$003E	$3AFF			XORLW	255
$003F	$1903			BTFSC	STATUS, Z
$0040	$2842			GOTO	L__read_Custom_41
$0041	$	L__read_Custom_42:
;D-91_PIC16_color_changer_v-4.1.c,518 :: 		}
$0041	$2836			GOTO	L__read_Custom_40
$0042	$	L__read_Custom_41:
;D-91_PIC16_color_changer_v-4.1.c,520 :: 		while((PORTB & 0x01) == 1)
$0042	$	L__read_Custom_43:
$0042	$3001			MOVLW	1
$0043	$0506			ANDWF	PORTB, 0
$0044	$00C1			MOVWF	STACK_1
$0045	$0841			MOVF	STACK_1, 0
$0046	$3A01			XORLW	1
$0047	$1D03			BTFSS	STATUS, Z
$0048	$284E			GOTO	L__read_Custom_44
;D-91_PIC16_color_changer_v-4.1.c,523 :: 		TIME_OUT;
$0049	$0801			MOVF	TMR0, 0
$004A	$3AFF			XORLW	255
$004B	$1903			BTFSC	STATUS, Z
$004C	$284E			GOTO	L__read_Custom_44
$004D	$	L__read_Custom_45:
;D-91_PIC16_color_changer_v-4.1.c,525 :: 		}
$004D	$2842			GOTO	L__read_Custom_43
$004E	$	L__read_Custom_44:
;D-91_PIC16_color_changer_v-4.1.c,527 :: 		if (TMR0 < 33)
$004E	$3021			MOVLW	33
$004F	$0201			SUBWF	TMR0, 0
$0050	$1803			BTFSC	STATUS, C
$0051	$2861			GOTO	L__read_Custom_46
;D-91_PIC16_color_changer_v-4.1.c,530 :: 		custom_code_a &= ~(0x01 << i);
$0052	$080E			MOVF	_i, 0
$0053	$00C1			MOVWF	STACK_1
$0054	$3001			MOVLW	1
$0055	$00C0			MOVWF	STACK_0
$0056	$0841			MOVF	STACK_1, 0
$0057	$	L__read_Custom_60:
$0057	$1903			BTFSC	STATUS, Z
$0058	$285D			GOTO	L__read_Custom_61
$0059	$0DC0			RLF	STACK_0, 1
$005A	$1040			BCF	STACK_0, 0
$005B	$3FFF			ADDLW	255
$005C	$2857			GOTO	L__read_Custom_60
$005D	$	L__read_Custom_61:
$005D	$09C0			COMF	STACK_0, F
$005E	$0840			MOVF	STACK_0, 0
$005F	$058D			ANDWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,532 :: 		}
$0060	$286E			GOTO	L__read_Custom_47
$0061	$	L__read_Custom_46:
;D-91_PIC16_color_changer_v-4.1.c,536 :: 		custom_code_a |= (0x01 << i);
$0061	$080E			MOVF	_i, 0
$0062	$00C1			MOVWF	STACK_1
$0063	$3001			MOVLW	1
$0064	$00C0			MOVWF	STACK_0
$0065	$0841			MOVF	STACK_1, 0
$0066	$	L__read_Custom_62:
$0066	$1903			BTFSC	STATUS, Z
$0067	$286C			GOTO	L__read_Custom_63
$0068	$0DC0			RLF	STACK_0, 1
$0069	$1040			BCF	STACK_0, 0
$006A	$3FFF			ADDLW	255
$006B	$2866			GOTO	L__read_Custom_62
$006C	$	L__read_Custom_63:
$006C	$0840			MOVF	STACK_0, 0
$006D	$048D			IORWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,538 :: 		}//if (TMR0 < 33)
$006E	$	L__read_Custom_47:
;D-91_PIC16_color_changer_v-4.1.c,540 :: 		}//for(i = 0; i < bit_len; i++)
$006E	$	L__read_Custom_39:
;D-91_PIC16_color_changer_v-4.1.c,509 :: 		for(i = 0; i < bit_len; i++)
$006E	$0A8E			INCF	_i, 1
;D-91_PIC16_color_changer_v-4.1.c,540 :: 		}//for(i = 0; i < bit_len; i++)
$006F	$2831			GOTO	L__read_Custom_37
$0070	$	L__read_Custom_38:
;D-91_PIC16_color_changer_v-4.1.c,543 :: 		}//_read_Custom
$0070	$0008			RETURN
$018B	$	__response:
;D-91_PIC16_color_changer_v-4.1.c,211 :: 		void _response(void)
;D-91_PIC16_color_changer_v-4.1.c,214 :: 		_pulse_u_100(5);
$018B	$3005			MOVLW	5
$018C	$1303			BCF	STATUS, RP1
$018D	$1283			BCF	STATUS, RP0
$018E	$0094			MOVWF	FARG__pulse_u_100+0
$018F	$3000			MOVLW	0
$0190	$0095			MOVWF	FARG__pulse_u_100+1
$0191	$2111			CALL	__pulse_u_100
;D-91_PIC16_color_changer_v-4.1.c,258 :: 		}
$0192	$0008			RETURN
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$0092			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$0091			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$0093			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$0840			MOVF	STACK_0, 0
$000E	$009C			MOVWF	STSAVED_0
;D-91_PIC16_color_changer_v-4.1.c,311 :: 		void interrupt(void)
;D-91_PIC16_color_changer_v-4.1.c,322 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,323 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,324 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,331 :: 		PORTA = 0x00;
$0015	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,338 :: 		result = _read_Reader();
$0016	$20A9			CALL	__read_Reader
$0017	$0840			MOVF	STACK_0, 0
$0018	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,345 :: 		if (result == false) {
$0019	$0840			MOVF	STACK_0, 0
$001A	$3A00			XORLW	0
$001B	$1D03			BTFSS	STATUS, Z
$001C	$281E			GOTO	L_interrupt_32
;D-91_PIC16_color_changer_v-4.1.c,349 :: 		return;
$001D	$2822			GOTO	L_Interrupt_end
;D-91_PIC16_color_changer_v-4.1.c,351 :: 		}
$001E	$	L_interrupt_32:
;D-91_PIC16_color_changer_v-4.1.c,358 :: 		_read_Custom();
$001E	$202D			CALL	__read_Custom
;D-91_PIC16_color_changer_v-4.1.c,368 :: 		_response();
$001F	$218B			CALL	__response
;D-91_PIC16_color_changer_v-4.1.c,376 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0020	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,377 :: 		INTCON |= 0x80;
$0021	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,379 :: 		}//void interrupt(void)
$0022	$	L_Interrupt_end:
$0022	$081C			MOVF	STSAVED_0, 0
$0023	$00C0			MOVWF	STACK_0
$0024	$0813			MOVF	?savePCLATH, 0
$0025	$008A			MOVWF	PCLATH
$0026	$0811			MOVF	?saveFSR, 0
$0027	$0084			MOVWF	FSR
$0028	$0E12			SWAPF	?saveSTATUS, 0
$0029	$0083			MOVWF	STATUS
$002A	$0ECF			SWAPF	STACK_15, 1
$002B	$0E4F			SWAPF	STACK_15, 0
$002C	$0009			RETFIE
$0153	$	__main_Setup:
;D-91_PIC16_color_changer_v-4.1.c,546 :: 		_main_Setup() {
;D-91_PIC16_color_changer_v-4.1.c,549 :: 		TRISA     = 0x00;
$0153	$1303			BCF	STATUS, RP1
$0154	$1683			BSF	STATUS, RP0
$0155	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-4.1.c,550 :: 		PORTA     = 0x00;		//0000 0010
$0156	$1283			BCF	STATUS, RP0
$0157	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,552 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$0158	$30FF			MOVLW	255
$0159	$1683			BSF	STATUS, RP0
$015A	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-4.1.c,554 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$015B	$307F			MOVLW	127
$015C	$0501			ANDWF	OPTION_REG, 0
$015D	$00C0			MOVWF	STACK_0
$015E	$0840			MOVF	STACK_0, 0
$015F	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,556 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$0160	$30BF			MOVLW	191
$0161	$05C0			ANDWF	STACK_0, 1
$0162	$0840			MOVF	STACK_0, 0
$0163	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,558 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$0164	$30DF			MOVLW	223
$0165	$05C0			ANDWF	STACK_0, 1
$0166	$0840			MOVF	STACK_0, 0
$0167	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,559 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$0168	$30F0			MOVLW	240
$0169	$05C0			ANDWF	STACK_0, 1
$016A	$0840			MOVF	STACK_0, 0
$016B	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,560 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$016C	$3007			MOVLW	7
$016D	$0440			IORWF	STACK_0, 0
$016E	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,567 :: 		bit_len = 4;
$016F	$3004			MOVLW	4
$0170	$008F			MOVWF	_bit_len
;D-91_PIC16_color_changer_v-4.1.c,569 :: 		}//_main_Setup
$0171	$0008			RETURN
$0198	$	GlobalIniD-91_PIC16_color_changer_v-4:
$0198	$3001			MOVLW	1
$0199	$1303			BCF	STATUS, RP1
$019A	$1283			BCF	STATUS, RP0
$019B	$0090			MOVWF	_LED_FLAG+0
$019C	$0008			RETURN
$0193	$	_main:
;D-91_PIC16_color_changer_v-4.1.c,382 :: 		void main(void)
;D-91_PIC16_color_changer_v-4.1.c,385 :: 		_main_Setup();
$0193	$2153			CALL	__main_Setup
;D-91_PIC16_color_changer_v-4.1.c,407 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0194	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,408 :: 		INTCON |= 0x80;
$0195	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,410 :: 		while(1)
$0196	$	L_main_33:
$0196	$2996			GOTO	L_main_33
;D-91_PIC16_color_changer_v-4.1.c,418 :: 		}//void main(void)
$0197	$2997			GOTO	$
