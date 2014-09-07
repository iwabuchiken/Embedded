;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/09/07 13:36:29
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2999			GOTO	_main
$0077	$	__pulse:
;D-91_PIC16_color_changer_v-4.1.c,59 :: 		void _pulse(int num)
;D-91_PIC16_color_changer_v-4.1.c,63 :: 		for(i = 0; i < num; i++)
$0077	$1303			BCF	STATUS, RP1
$0078	$1283			BCF	STATUS, RP0
$0079	$019A			CLRF	_pulse_i_L0
$007A	$019B			CLRF	_pulse_i_L0+1
$007B	$	L__pulse_0:
$007B	$3080			MOVLW	128
$007C	$061B			XORWF	_pulse_i_L0+1, 0
$007D	$00C0			MOVWF	STACK_0
$007E	$3080			MOVLW	128
$007F	$0619			XORWF	FARG__pulse+1, 0
$0080	$0240			SUBWF	STACK_0, 0
$0081	$1D03			BTFSS	STATUS, Z
$0082	$2885			GOTO	L__pulse_48
$0083	$0818			MOVF	FARG__pulse+0, 0
$0084	$021A			SUBWF	_pulse_i_L0, 0
$0085	$	L__pulse_48:
$0085	$1803			BTFSC	STATUS, C
$0086	$28AE			GOTO	L__pulse_1
;D-91_PIC16_color_changer_v-4.1.c,66 :: 		PORTA = 0x01; Delay_ms(1);
$0087	$3001			MOVLW	1
$0088	$0085			MOVWF	PORTA
$0089	$3007			MOVLW	7
$008A	$00CB			MOVWF	STACK_11
$008B	$30FF			MOVLW	255
$008C	$00CA			MOVWF	STACK_10
$008D	$0BCB			DECFSZ	STACK_11, F
$008E	$2890			GOTO	$+2
$008F	$2893			GOTO	$+4
$0090	$0BCA			DECFSZ	STACK_10, F
$0091	$2890			GOTO	$-1
$0092	$288D			GOTO	$-5
$0093	$3078			MOVLW	120
$0094	$00CA			MOVWF	STACK_10
$0095	$0BCA			DECFSZ	STACK_10, F
$0096	$2895			GOTO	$-1
$0097	$0000			NOP
$0098	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,68 :: 		PORTA = 0x00; Delay_ms(1);
$0099	$0185			CLRF	PORTA, 1
$009A	$3007			MOVLW	7
$009B	$00CB			MOVWF	STACK_11
$009C	$30FF			MOVLW	255
$009D	$00CA			MOVWF	STACK_10
$009E	$0BCB			DECFSZ	STACK_11, F
$009F	$28A1			GOTO	$+2
$00A0	$28A4			GOTO	$+4
$00A1	$0BCA			DECFSZ	STACK_10, F
$00A2	$28A1			GOTO	$-1
$00A3	$289E			GOTO	$-5
$00A4	$3078			MOVLW	120
$00A5	$00CA			MOVWF	STACK_10
$00A6	$0BCA			DECFSZ	STACK_10, F
$00A7	$28A6			GOTO	$-1
$00A8	$0000			NOP
$00A9	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,70 :: 		}
$00AA	$	L__pulse_2:
;D-91_PIC16_color_changer_v-4.1.c,63 :: 		for(i = 0; i < num; i++)
$00AA	$0A9A			INCF	_pulse_i_L0, 1
$00AB	$1903			BTFSC	STATUS, Z
$00AC	$0A9B			INCF	_pulse_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,70 :: 		}
$00AD	$287B			GOTO	L__pulse_0
$00AE	$	L__pulse_1:
;D-91_PIC16_color_changer_v-4.1.c,72 :: 		}
$00AE	$0008			RETURN
$0139	$	__pulse_u_50:
;D-91_PIC16_color_changer_v-4.1.c,126 :: 		_pulse_u_50(int num)
;D-91_PIC16_color_changer_v-4.1.c,130 :: 		for(i = 0; i < num; i++)
$0139	$1303			BCF	STATUS, RP1
$013A	$1283			BCF	STATUS, RP0
$013B	$019A			CLRF	_pulse_u_50_i_L0
$013C	$019B			CLRF	_pulse_u_50_i_L0+1
$013D	$	L__pulse_u_50_12:
$013D	$3080			MOVLW	128
$013E	$061B			XORWF	_pulse_u_50_i_L0+1, 0
$013F	$00C0			MOVWF	STACK_0
$0140	$3080			MOVLW	128
$0141	$0619			XORWF	FARG__pulse_u_50+1, 0
$0142	$0240			SUBWF	STACK_0, 0
$0143	$1D03			BTFSS	STATUS, Z
$0144	$2947			GOTO	L__pulse_u_50_52
$0145	$0818			MOVF	FARG__pulse_u_50+0, 0
$0146	$021A			SUBWF	_pulse_u_50_i_L0, 0
$0147	$	L__pulse_u_50_52:
$0147	$1803			BTFSC	STATUS, C
$0148	$2958			GOTO	L__pulse_u_50_13
;D-91_PIC16_color_changer_v-4.1.c,133 :: 		PORTA = 0x01; Delay_us(50);
$0149	$3001			MOVLW	1
$014A	$0085			MOVWF	PORTA
$014B	$3053			MOVLW	83
$014C	$00CA			MOVWF	STACK_10
$014D	$0BCA			DECFSZ	STACK_10, F
$014E	$294D			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,135 :: 		PORTA = 0x00; Delay_us(50);
$014F	$0185			CLRF	PORTA, 1
$0150	$3053			MOVLW	83
$0151	$00CA			MOVWF	STACK_10
$0152	$0BCA			DECFSZ	STACK_10, F
$0153	$2952			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,137 :: 		}
$0154	$	L__pulse_u_50_14:
;D-91_PIC16_color_changer_v-4.1.c,130 :: 		for(i = 0; i < num; i++)
$0154	$0A9A			INCF	_pulse_u_50_i_L0, 1
$0155	$1903			BTFSC	STATUS, Z
$0156	$0A9B			INCF	_pulse_u_50_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,137 :: 		}
$0157	$293D			GOTO	L__pulse_u_50_12
$0158	$	L__pulse_u_50_13:
;D-91_PIC16_color_changer_v-4.1.c,139 :: 		}//_pulse_u_50
$0158	$0008			RETURN
$0178	$	__while_PORTB_0x01:
;D-91_PIC16_color_changer_v-4.1.c,141 :: 		void _while_PORTB_0x01(int num)
;D-91_PIC16_color_changer_v-4.1.c,144 :: 		while((PORTB & 0x01) == num) //---------------------
$0178	$	L__while_PORTB_0x01_15:
$0178	$3001			MOVLW	1
$0179	$1303			BCF	STATUS, RP1
$017A	$1283			BCF	STATUS, RP0
$017B	$0506			ANDWF	PORTB, 0
$017C	$00C1			MOVWF	STACK_1
$017D	$3000			MOVLW	0
$017E	$0615			XORWF	FARG__while_PORTB_0x01+1, 0
$017F	$1D03			BTFSS	STATUS, Z
$0180	$2983			GOTO	L__while_PORTB_0x01_53
$0181	$0814			MOVF	FARG__while_PORTB_0x01+0, 0
$0182	$0641			XORWF	STACK_1, 0
$0183	$	L__while_PORTB_0x01_53:
$0183	$1D03			BTFSS	STATUS, Z
$0184	$2990			GOTO	L__while_PORTB_0x01_16
;D-91_PIC16_color_changer_v-4.1.c,147 :: 		if(TMR0 == 255)
$0185	$0801			MOVF	TMR0, 0
$0186	$3AFF			XORLW	255
$0187	$1D03			BTFSS	STATUS, Z
$0188	$298F			GOTO	L__while_PORTB_0x01_17
;D-91_PIC16_color_changer_v-4.1.c,151 :: 		_pulse(3);
$0189	$3003			MOVLW	3
$018A	$0098			MOVWF	FARG__pulse+0
$018B	$3000			MOVLW	0
$018C	$0099			MOVWF	FARG__pulse+1
$018D	$2077			CALL	__pulse
;D-91_PIC16_color_changer_v-4.1.c,154 :: 		return;
$018E	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,156 :: 		}
$018F	$	L__while_PORTB_0x01_17:
;D-91_PIC16_color_changer_v-4.1.c,158 :: 		}//while((PORTB & 0x01) == 0)
$018F	$2978			GOTO	L__while_PORTB_0x01_15
$0190	$	L__while_PORTB_0x01_16:
;D-91_PIC16_color_changer_v-4.1.c,160 :: 		return;
;D-91_PIC16_color_changer_v-4.1.c,162 :: 		}
$0190	$0008			RETURN
$00E6	$	__judge_TMR_:
;D-91_PIC16_color_changer_v-4.1.c,168 :: 		int _judge_TMR_(int low, int high) {
;D-91_PIC16_color_changer_v-4.1.c,170 :: 		if(TMR0 < low) //---------------------
$00E6	$3080			MOVLW	128
$00E7	$1303			BCF	STATUS, RP1
$00E8	$1283			BCF	STATUS, RP0
$00E9	$00C0			MOVWF	STACK_0
$00EA	$3080			MOVLW	128
$00EB	$0615			XORWF	FARG__judge_TMR_+1, 0
$00EC	$0240			SUBWF	STACK_0, 0
$00ED	$1D03			BTFSS	STATUS, Z
$00EE	$28F1			GOTO	L__judge_TMR__54
$00EF	$0814			MOVF	FARG__judge_TMR_+0, 0
$00F0	$0201			SUBWF	TMR0, 0
$00F1	$	L__judge_TMR__54:
$00F1	$1803			BTFSC	STATUS, C
$00F2	$28FD			GOTO	L__judge_TMR__18
;D-91_PIC16_color_changer_v-4.1.c,173 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00F3	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,174 :: 		INTCON |= 0x80;        // interrupt => permitted
$00F4	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,181 :: 		_pulse_u_50(3);
$00F5	$3003			MOVLW	3
$00F6	$0098			MOVWF	FARG__pulse_u_50+0
$00F7	$3000			MOVLW	0
$00F8	$0099			MOVWF	FARG__pulse_u_50+1
$00F9	$2139			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,183 :: 		return false;                // return
$00FA	$01C0			CLRF	STACK_0
$00FB	$01C1			CLRF	STACK_0+1
$00FC	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,194 :: 		} else if (TMR0 > high) {
$00FD	$	L__judge_TMR__18:
$00FD	$3080			MOVLW	128
$00FE	$0617			XORWF	FARG__judge_TMR_+3, 0
$00FF	$00C0			MOVWF	STACK_0
$0100	$3080			MOVLW	128
$0101	$0240			SUBWF	STACK_0, 0
$0102	$1D03			BTFSS	STATUS, Z
$0103	$2906			GOTO	L__judge_TMR__55
$0104	$0801			MOVF	TMR0, 0
$0105	$0216			SUBWF	FARG__judge_TMR_+2, 0
$0106	$	L__judge_TMR__55:
$0106	$1803			BTFSC	STATUS, C
$0107	$2912			GOTO	L__judge_TMR__20
;D-91_PIC16_color_changer_v-4.1.c,196 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0108	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,197 :: 		INTCON |= 0x80;        // interrupt => permitted
$0109	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,200 :: 		_pulse_u_50(2);
$010A	$3002			MOVLW	2
$010B	$0098			MOVWF	FARG__pulse_u_50+0
$010C	$3000			MOVLW	0
$010D	$0099			MOVWF	FARG__pulse_u_50+1
$010E	$2139			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,203 :: 		return false;
$010F	$01C0			CLRF	STACK_0
$0110	$01C1			CLRF	STACK_0+1
$0111	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,205 :: 		}
$0112	$	L__judge_TMR__20:
$0112	$	L__judge_TMR__19:
;D-91_PIC16_color_changer_v-4.1.c,207 :: 		return true;
$0112	$3001			MOVLW	1
$0113	$00C0			MOVWF	STACK_0
$0114	$3000			MOVLW	0
$0115	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,209 :: 		}//int _judge_TMR_(int low, int high)
$0116	$0008			RETURN
$0117	$	__pulse_u_100:
;D-91_PIC16_color_changer_v-4.1.c,110 :: 		void _pulse_u_100(int num)
;D-91_PIC16_color_changer_v-4.1.c,114 :: 		for(i = 0; i < num; i++)
$0117	$1303			BCF	STATUS, RP1
$0118	$1283			BCF	STATUS, RP0
$0119	$0196			CLRF	_pulse_u_100_i_L0
$011A	$0197			CLRF	_pulse_u_100_i_L0+1
$011B	$	L__pulse_u_100_9:
$011B	$3080			MOVLW	128
$011C	$0617			XORWF	_pulse_u_100_i_L0+1, 0
$011D	$00C0			MOVWF	STACK_0
$011E	$3080			MOVLW	128
$011F	$0615			XORWF	FARG__pulse_u_100+1, 0
$0120	$0240			SUBWF	STACK_0, 0
$0121	$1D03			BTFSS	STATUS, Z
$0122	$2925			GOTO	L__pulse_u_100_51
$0123	$0814			MOVF	FARG__pulse_u_100+0, 0
$0124	$0216			SUBWF	_pulse_u_100_i_L0, 0
$0125	$	L__pulse_u_100_51:
$0125	$1803			BTFSC	STATUS, C
$0126	$2938			GOTO	L__pulse_u_100_10
;D-91_PIC16_color_changer_v-4.1.c,117 :: 		PORTA = 0x01; Delay_us(100);
$0127	$3001			MOVLW	1
$0128	$0085			MOVWF	PORTA
$0129	$30A6			MOVLW	166
$012A	$00CA			MOVWF	STACK_10
$012B	$0BCA			DECFSZ	STACK_10, F
$012C	$292B			GOTO	$-1
$012D	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,119 :: 		PORTA = 0x00; Delay_us(100);
$012E	$0185			CLRF	PORTA, 1
$012F	$30A6			MOVLW	166
$0130	$00CA			MOVWF	STACK_10
$0131	$0BCA			DECFSZ	STACK_10, F
$0132	$2931			GOTO	$-1
$0133	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,121 :: 		}
$0134	$	L__pulse_u_100_11:
;D-91_PIC16_color_changer_v-4.1.c,114 :: 		for(i = 0; i < num; i++)
$0134	$0A96			INCF	_pulse_u_100_i_L0, 1
$0135	$1903			BTFSC	STATUS, Z
$0136	$0A97			INCF	_pulse_u_100_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,121 :: 		}
$0137	$291B			GOTO	L__pulse_u_100_9
$0138	$	L__pulse_u_100_10:
;D-91_PIC16_color_changer_v-4.1.c,123 :: 		}
$0138	$0008			RETURN
$00AF	$	__read_Reader:
;D-91_PIC16_color_changer_v-4.1.c,445 :: 		_read_Reader() {
;D-91_PIC16_color_changer_v-4.1.c,452 :: 		RESET_TMR;
$00AF	$1303			BCF	STATUS, RP1
$00B0	$1283			BCF	STATUS, RP0
$00B1	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,462 :: 		_while_PORTB_0x01(0);
$00B2	$0194			CLRF	FARG__while_PORTB_0x01+0
$00B3	$0195			CLRF	FARG__while_PORTB_0x01+1
$00B4	$2178			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,473 :: 		result = _judge_TMR_(156, 196);
$00B5	$309C			MOVLW	156
$00B6	$1303			BCF	STATUS, RP1
$00B7	$1283			BCF	STATUS, RP0
$00B8	$0094			MOVWF	FARG__judge_TMR_+0
$00B9	$0195			CLRF	FARG__judge_TMR_+1
$00BA	$30C4			MOVLW	196
$00BB	$0096			MOVWF	FARG__judge_TMR_+2
$00BC	$0197			CLRF	FARG__judge_TMR_+3
$00BD	$20E6			CALL	__judge_TMR_
$00BE	$0840			MOVF	STACK_0, 0
$00BF	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,475 :: 		if (result == false) {
$00C0	$0840			MOVF	STACK_0, 0
$00C1	$3A00			XORLW	0
$00C2	$1D03			BTFSS	STATUS, Z
$00C3	$28C7			GOTO	L__read_Reader_35
;D-91_PIC16_color_changer_v-4.1.c,479 :: 		return false;
$00C4	$01C0			CLRF	STACK_0
$00C5	$01C1			CLRF	STACK_0+1
$00C6	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,481 :: 		}
$00C7	$	L__read_Reader_35:
;D-91_PIC16_color_changer_v-4.1.c,493 :: 		RESET_TMR;
$00C7	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,500 :: 		_while_PORTB_0x01(1);
$00C8	$3001			MOVLW	1
$00C9	$0094			MOVWF	FARG__while_PORTB_0x01+0
$00CA	$3000			MOVLW	0
$00CB	$0095			MOVWF	FARG__while_PORTB_0x01+1
$00CC	$2178			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,507 :: 		result = _judge_TMR_(68, 108);
$00CD	$3044			MOVLW	68
$00CE	$1303			BCF	STATUS, RP1
$00CF	$1283			BCF	STATUS, RP0
$00D0	$0094			MOVWF	FARG__judge_TMR_+0
$00D1	$3000			MOVLW	0
$00D2	$0095			MOVWF	FARG__judge_TMR_+1
$00D3	$306C			MOVLW	108
$00D4	$0096			MOVWF	FARG__judge_TMR_+2
$00D5	$3000			MOVLW	0
$00D6	$0097			MOVWF	FARG__judge_TMR_+3
$00D7	$20E6			CALL	__judge_TMR_
$00D8	$0840			MOVF	STACK_0, 0
$00D9	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,509 :: 		if (result == false) {
$00DA	$0840			MOVF	STACK_0, 0
$00DB	$3A00			XORLW	0
$00DC	$1D03			BTFSS	STATUS, Z
$00DD	$28E1			GOTO	L__read_Reader_36
;D-91_PIC16_color_changer_v-4.1.c,513 :: 		return false;
$00DE	$01C0			CLRF	STACK_0
$00DF	$01C1			CLRF	STACK_0+1
$00E0	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,515 :: 		}
$00E1	$	L__read_Reader_36:
;D-91_PIC16_color_changer_v-4.1.c,522 :: 		return true;
$00E1	$3001			MOVLW	1
$00E2	$00C0			MOVWF	STACK_0
$00E3	$3000			MOVLW	0
$00E4	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,524 :: 		}//_read_Reader
$00E5	$0008			RETURN
$0033	$	__read_Custom:
;D-91_PIC16_color_changer_v-4.1.c,527 :: 		_read_Custom() {
;D-91_PIC16_color_changer_v-4.1.c,529 :: 		custom_code_a = 0x00;
$0033	$1303			BCF	STATUS, RP1
$0034	$1283			BCF	STATUS, RP0
$0035	$018D			CLRF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,533 :: 		for(i = 0; i < bit_len; i++)
$0036	$018E			CLRF	_i, 1
$0037	$	L__read_Custom_37:
$0037	$080F			MOVF	_bit_len, 0
$0038	$020E			SUBWF	_i, 0
$0039	$1803			BTFSC	STATUS, C
$003A	$2876			GOTO	L__read_Custom_38
;D-91_PIC16_color_changer_v-4.1.c,535 :: 		RESET_TMR;
$003B	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,537 :: 		while((PORTB & 0x01) == 0)
$003C	$	L__read_Custom_40:
$003C	$3001			MOVLW	1
$003D	$0506			ANDWF	PORTB, 0
$003E	$00C1			MOVWF	STACK_1
$003F	$0841			MOVF	STACK_1, 0
$0040	$3A00			XORLW	0
$0041	$1D03			BTFSS	STATUS, Z
$0042	$2848			GOTO	L__read_Custom_41
;D-91_PIC16_color_changer_v-4.1.c,540 :: 		TIME_OUT;
$0043	$0801			MOVF	TMR0, 0
$0044	$3AFF			XORLW	255
$0045	$1903			BTFSC	STATUS, Z
$0046	$2848			GOTO	L__read_Custom_41
$0047	$	L__read_Custom_42:
;D-91_PIC16_color_changer_v-4.1.c,542 :: 		}
$0047	$283C			GOTO	L__read_Custom_40
$0048	$	L__read_Custom_41:
;D-91_PIC16_color_changer_v-4.1.c,544 :: 		while((PORTB & 0x01) == 1)
$0048	$	L__read_Custom_43:
$0048	$3001			MOVLW	1
$0049	$0506			ANDWF	PORTB, 0
$004A	$00C1			MOVWF	STACK_1
$004B	$0841			MOVF	STACK_1, 0
$004C	$3A01			XORLW	1
$004D	$1D03			BTFSS	STATUS, Z
$004E	$2854			GOTO	L__read_Custom_44
;D-91_PIC16_color_changer_v-4.1.c,547 :: 		TIME_OUT;
$004F	$0801			MOVF	TMR0, 0
$0050	$3AFF			XORLW	255
$0051	$1903			BTFSC	STATUS, Z
$0052	$2854			GOTO	L__read_Custom_44
$0053	$	L__read_Custom_45:
;D-91_PIC16_color_changer_v-4.1.c,549 :: 		}
$0053	$2848			GOTO	L__read_Custom_43
$0054	$	L__read_Custom_44:
;D-91_PIC16_color_changer_v-4.1.c,551 :: 		if (TMR0 < 33)
$0054	$3021			MOVLW	33
$0055	$0201			SUBWF	TMR0, 0
$0056	$1803			BTFSC	STATUS, C
$0057	$2867			GOTO	L__read_Custom_46
;D-91_PIC16_color_changer_v-4.1.c,554 :: 		custom_code_a &= ~(0x01 << i);
$0058	$080E			MOVF	_i, 0
$0059	$00C1			MOVWF	STACK_1
$005A	$3001			MOVLW	1
$005B	$00C0			MOVWF	STACK_0
$005C	$0841			MOVF	STACK_1, 0
$005D	$	L__read_Custom_60:
$005D	$1903			BTFSC	STATUS, Z
$005E	$2863			GOTO	L__read_Custom_61
$005F	$0DC0			RLF	STACK_0, 1
$0060	$1040			BCF	STACK_0, 0
$0061	$3FFF			ADDLW	255
$0062	$285D			GOTO	L__read_Custom_60
$0063	$	L__read_Custom_61:
$0063	$09C0			COMF	STACK_0, F
$0064	$0840			MOVF	STACK_0, 0
$0065	$058D			ANDWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,556 :: 		}
$0066	$2874			GOTO	L__read_Custom_47
$0067	$	L__read_Custom_46:
;D-91_PIC16_color_changer_v-4.1.c,560 :: 		custom_code_a |= (0x01 << i);
$0067	$080E			MOVF	_i, 0
$0068	$00C1			MOVWF	STACK_1
$0069	$3001			MOVLW	1
$006A	$00C0			MOVWF	STACK_0
$006B	$0841			MOVF	STACK_1, 0
$006C	$	L__read_Custom_62:
$006C	$1903			BTFSC	STATUS, Z
$006D	$2872			GOTO	L__read_Custom_63
$006E	$0DC0			RLF	STACK_0, 1
$006F	$1040			BCF	STACK_0, 0
$0070	$3FFF			ADDLW	255
$0071	$286C			GOTO	L__read_Custom_62
$0072	$	L__read_Custom_63:
$0072	$0840			MOVF	STACK_0, 0
$0073	$048D			IORWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,562 :: 		}//if (TMR0 < 33)
$0074	$	L__read_Custom_47:
;D-91_PIC16_color_changer_v-4.1.c,564 :: 		}//for(i = 0; i < bit_len; i++)
$0074	$	L__read_Custom_39:
;D-91_PIC16_color_changer_v-4.1.c,533 :: 		for(i = 0; i < bit_len; i++)
$0074	$0A8E			INCF	_i, 1
;D-91_PIC16_color_changer_v-4.1.c,564 :: 		}//for(i = 0; i < bit_len; i++)
$0075	$2837			GOTO	L__read_Custom_37
$0076	$	L__read_Custom_38:
;D-91_PIC16_color_changer_v-4.1.c,567 :: 		}//_read_Custom
$0076	$0008			RETURN
$0191	$	__response:
;D-91_PIC16_color_changer_v-4.1.c,211 :: 		void _response(void)
;D-91_PIC16_color_changer_v-4.1.c,214 :: 		_pulse_u_100(5);
$0191	$3005			MOVLW	5
$0192	$1303			BCF	STATUS, RP1
$0193	$1283			BCF	STATUS, RP0
$0194	$0094			MOVWF	FARG__pulse_u_100+0
$0195	$3000			MOVLW	0
$0196	$0095			MOVWF	FARG__pulse_u_100+1
$0197	$2117			CALL	__pulse_u_100
;D-91_PIC16_color_changer_v-4.1.c,258 :: 		}
$0198	$0008			RETURN
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
$0016	$20AF			CALL	__read_Reader
$0017	$0840			MOVF	STACK_0, 0
$0018	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,345 :: 		if (result == false) {
$0019	$0840			MOVF	STACK_0, 0
$001A	$3A00			XORLW	0
$001B	$1D03			BTFSS	STATUS, Z
$001C	$281E			GOTO	L_interrupt_32
;D-91_PIC16_color_changer_v-4.1.c,349 :: 		return;
$001D	$2828			GOTO	L_Interrupt_end
;D-91_PIC16_color_changer_v-4.1.c,351 :: 		}
$001E	$	L_interrupt_32:
;D-91_PIC16_color_changer_v-4.1.c,358 :: 		_read_Custom();
$001E	$2033			CALL	__read_Custom
;D-91_PIC16_color_changer_v-4.1.c,375 :: 		_response();
$001F	$2191			CALL	__response
;D-91_PIC16_color_changer_v-4.1.c,382 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$0020	$307F			MOVLW	127
$0021	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,383 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0022	$30EF			MOVLW	239
$0023	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,384 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0024	$30FD			MOVLW	253
$0025	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,400 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0026	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,401 :: 		INTCON |= 0x80;
$0027	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,403 :: 		}//void interrupt(void)
$0028	$	L_Interrupt_end:
$0028	$081C			MOVF	STSAVED_0, 0
$0029	$00C0			MOVWF	STACK_0
$002A	$0813			MOVF	?savePCLATH, 0
$002B	$008A			MOVWF	PCLATH
$002C	$0811			MOVF	?saveFSR, 0
$002D	$0084			MOVWF	FSR
$002E	$0E12			SWAPF	?saveSTATUS, 0
$002F	$0083			MOVWF	STATUS
$0030	$0ECF			SWAPF	STACK_15, 1
$0031	$0E4F			SWAPF	STACK_15, 0
$0032	$0009			RETFIE
$0159	$	__main_Setup:
;D-91_PIC16_color_changer_v-4.1.c,570 :: 		_main_Setup() {
;D-91_PIC16_color_changer_v-4.1.c,573 :: 		TRISA     = 0x00;
$0159	$1303			BCF	STATUS, RP1
$015A	$1683			BSF	STATUS, RP0
$015B	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-4.1.c,574 :: 		PORTA     = 0x00;		//0000 0010
$015C	$1283			BCF	STATUS, RP0
$015D	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,576 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$015E	$30FF			MOVLW	255
$015F	$1683			BSF	STATUS, RP0
$0160	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-4.1.c,578 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$0161	$307F			MOVLW	127
$0162	$0501			ANDWF	OPTION_REG, 0
$0163	$00C0			MOVWF	STACK_0
$0164	$0840			MOVF	STACK_0, 0
$0165	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,580 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$0166	$30BF			MOVLW	191
$0167	$05C0			ANDWF	STACK_0, 1
$0168	$0840			MOVF	STACK_0, 0
$0169	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,582 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$016A	$30DF			MOVLW	223
$016B	$05C0			ANDWF	STACK_0, 1
$016C	$0840			MOVF	STACK_0, 0
$016D	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,583 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$016E	$30F0			MOVLW	240
$016F	$05C0			ANDWF	STACK_0, 1
$0170	$0840			MOVF	STACK_0, 0
$0171	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,584 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$0172	$3007			MOVLW	7
$0173	$0440			IORWF	STACK_0, 0
$0174	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,591 :: 		bit_len = 4;
$0175	$3004			MOVLW	4
$0176	$008F			MOVWF	_bit_len
;D-91_PIC16_color_changer_v-4.1.c,593 :: 		}//_main_Setup
$0177	$0008			RETURN
$019E	$	GlobalIniD-91_PIC16_color_changer_v-4:
$019E	$3001			MOVLW	1
$019F	$1303			BCF	STATUS, RP1
$01A0	$1283			BCF	STATUS, RP0
$01A1	$0090			MOVWF	_LED_FLAG+0
$01A2	$0008			RETURN
$0199	$	_main:
;D-91_PIC16_color_changer_v-4.1.c,406 :: 		void main(void)
;D-91_PIC16_color_changer_v-4.1.c,409 :: 		_main_Setup();
$0199	$2159			CALL	__main_Setup
;D-91_PIC16_color_changer_v-4.1.c,431 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$019A	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,432 :: 		INTCON |= 0x80;
$019B	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,434 :: 		while(1)
$019C	$	L_main_33:
$019C	$299C			GOTO	L_main_33
;D-91_PIC16_color_changer_v-4.1.c,442 :: 		}//void main(void)
$019D	$299D			GOTO	$
