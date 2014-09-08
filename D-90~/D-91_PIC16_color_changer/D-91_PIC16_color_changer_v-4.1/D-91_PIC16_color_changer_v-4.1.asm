;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/09/08 9:47:03
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$29DF			GOTO	_main
$00C5	$	__pulse:
;D-91_PIC16_color_changer_v-4.1.c,61 :: 		void _pulse(int num)
;D-91_PIC16_color_changer_v-4.1.c,65 :: 		for(i = 0; i < num; i++)
$00C5	$1303			BCF	STATUS, RP1
$00C6	$1283			BCF	STATUS, RP0
$00C7	$019A			CLRF	_pulse_i_L0
$00C8	$019B			CLRF	_pulse_i_L0+1
$00C9	$	L__pulse_0:
$00C9	$3080			MOVLW	128
$00CA	$061B			XORWF	_pulse_i_L0+1, 0
$00CB	$00C0			MOVWF	STACK_0
$00CC	$3080			MOVLW	128
$00CD	$0619			XORWF	FARG__pulse+1, 0
$00CE	$0240			SUBWF	STACK_0, 0
$00CF	$1D03			BTFSS	STATUS, Z
$00D0	$28D3			GOTO	L__pulse_64
$00D1	$0818			MOVF	FARG__pulse+0, 0
$00D2	$021A			SUBWF	_pulse_i_L0, 0
$00D3	$	L__pulse_64:
$00D3	$1803			BTFSC	STATUS, C
$00D4	$28FC			GOTO	L__pulse_1
;D-91_PIC16_color_changer_v-4.1.c,68 :: 		PORTA = 0x01; Delay_ms(1);
$00D5	$3001			MOVLW	1
$00D6	$0085			MOVWF	PORTA
$00D7	$3007			MOVLW	7
$00D8	$00CB			MOVWF	STACK_11
$00D9	$30FF			MOVLW	255
$00DA	$00CA			MOVWF	STACK_10
$00DB	$0BCB			DECFSZ	STACK_11, F
$00DC	$28DE			GOTO	$+2
$00DD	$28E1			GOTO	$+4
$00DE	$0BCA			DECFSZ	STACK_10, F
$00DF	$28DE			GOTO	$-1
$00E0	$28DB			GOTO	$-5
$00E1	$3078			MOVLW	120
$00E2	$00CA			MOVWF	STACK_10
$00E3	$0BCA			DECFSZ	STACK_10, F
$00E4	$28E3			GOTO	$-1
$00E5	$0000			NOP
$00E6	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,70 :: 		PORTA = 0x00; Delay_ms(1);
$00E7	$0185			CLRF	PORTA, 1
$00E8	$3007			MOVLW	7
$00E9	$00CB			MOVWF	STACK_11
$00EA	$30FF			MOVLW	255
$00EB	$00CA			MOVWF	STACK_10
$00EC	$0BCB			DECFSZ	STACK_11, F
$00ED	$28EF			GOTO	$+2
$00EE	$28F2			GOTO	$+4
$00EF	$0BCA			DECFSZ	STACK_10, F
$00F0	$28EF			GOTO	$-1
$00F1	$28EC			GOTO	$-5
$00F2	$3078			MOVLW	120
$00F3	$00CA			MOVWF	STACK_10
$00F4	$0BCA			DECFSZ	STACK_10, F
$00F5	$28F4			GOTO	$-1
$00F6	$0000			NOP
$00F7	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,72 :: 		}
$00F8	$	L__pulse_2:
;D-91_PIC16_color_changer_v-4.1.c,65 :: 		for(i = 0; i < num; i++)
$00F8	$0A9A			INCF	_pulse_i_L0, 1
$00F9	$1903			BTFSC	STATUS, Z
$00FA	$0A9B			INCF	_pulse_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,72 :: 		}
$00FB	$28C9			GOTO	L__pulse_0
$00FC	$	L__pulse_1:
;D-91_PIC16_color_changer_v-4.1.c,74 :: 		}
$00FC	$0008			RETURN
$0187	$	__pulse_u_50:
;D-91_PIC16_color_changer_v-4.1.c,128 :: 		_pulse_u_50(int num)
;D-91_PIC16_color_changer_v-4.1.c,132 :: 		for(i = 0; i < num; i++)
$0187	$1303			BCF	STATUS, RP1
$0188	$1283			BCF	STATUS, RP0
$0189	$019A			CLRF	_pulse_u_50_i_L0
$018A	$019B			CLRF	_pulse_u_50_i_L0+1
$018B	$	L__pulse_u_50_12:
$018B	$3080			MOVLW	128
$018C	$061B			XORWF	_pulse_u_50_i_L0+1, 0
$018D	$00C0			MOVWF	STACK_0
$018E	$3080			MOVLW	128
$018F	$0619			XORWF	FARG__pulse_u_50+1, 0
$0190	$0240			SUBWF	STACK_0, 0
$0191	$1D03			BTFSS	STATUS, Z
$0192	$2995			GOTO	L__pulse_u_50_68
$0193	$0818			MOVF	FARG__pulse_u_50+0, 0
$0194	$021A			SUBWF	_pulse_u_50_i_L0, 0
$0195	$	L__pulse_u_50_68:
$0195	$1803			BTFSC	STATUS, C
$0196	$29A6			GOTO	L__pulse_u_50_13
;D-91_PIC16_color_changer_v-4.1.c,135 :: 		PORTA = 0x01; Delay_us(50);
$0197	$3001			MOVLW	1
$0198	$0085			MOVWF	PORTA
$0199	$3053			MOVLW	83
$019A	$00CA			MOVWF	STACK_10
$019B	$0BCA			DECFSZ	STACK_10, F
$019C	$299B			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,137 :: 		PORTA = 0x00; Delay_us(50);
$019D	$0185			CLRF	PORTA, 1
$019E	$3053			MOVLW	83
$019F	$00CA			MOVWF	STACK_10
$01A0	$0BCA			DECFSZ	STACK_10, F
$01A1	$29A0			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,139 :: 		}
$01A2	$	L__pulse_u_50_14:
;D-91_PIC16_color_changer_v-4.1.c,132 :: 		for(i = 0; i < num; i++)
$01A2	$0A9A			INCF	_pulse_u_50_i_L0, 1
$01A3	$1903			BTFSC	STATUS, Z
$01A4	$0A9B			INCF	_pulse_u_50_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,139 :: 		}
$01A5	$298B			GOTO	L__pulse_u_50_12
$01A6	$	L__pulse_u_50_13:
;D-91_PIC16_color_changer_v-4.1.c,141 :: 		}//_pulse_u_50
$01A6	$0008			RETURN
$01C6	$	__while_PORTB_0x01:
;D-91_PIC16_color_changer_v-4.1.c,143 :: 		void _while_PORTB_0x01(int num)
;D-91_PIC16_color_changer_v-4.1.c,146 :: 		while((PORTB & 0x01) == num) //---------------------
$01C6	$	L__while_PORTB_0x01_15:
$01C6	$3001			MOVLW	1
$01C7	$1303			BCF	STATUS, RP1
$01C8	$1283			BCF	STATUS, RP0
$01C9	$0506			ANDWF	PORTB, 0
$01CA	$00C1			MOVWF	STACK_1
$01CB	$3000			MOVLW	0
$01CC	$0615			XORWF	FARG__while_PORTB_0x01+1, 0
$01CD	$1D03			BTFSS	STATUS, Z
$01CE	$29D1			GOTO	L__while_PORTB_0x01_69
$01CF	$0814			MOVF	FARG__while_PORTB_0x01+0, 0
$01D0	$0641			XORWF	STACK_1, 0
$01D1	$	L__while_PORTB_0x01_69:
$01D1	$1D03			BTFSS	STATUS, Z
$01D2	$29DE			GOTO	L__while_PORTB_0x01_16
;D-91_PIC16_color_changer_v-4.1.c,149 :: 		if(TMR0 == 255)
$01D3	$0801			MOVF	TMR0, 0
$01D4	$3AFF			XORLW	255
$01D5	$1D03			BTFSS	STATUS, Z
$01D6	$29DD			GOTO	L__while_PORTB_0x01_17
;D-91_PIC16_color_changer_v-4.1.c,153 :: 		_pulse(3);
$01D7	$3003			MOVLW	3
$01D8	$0098			MOVWF	FARG__pulse+0
$01D9	$3000			MOVLW	0
$01DA	$0099			MOVWF	FARG__pulse+1
$01DB	$20C5			CALL	__pulse
;D-91_PIC16_color_changer_v-4.1.c,156 :: 		return;
$01DC	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,158 :: 		}
$01DD	$	L__while_PORTB_0x01_17:
;D-91_PIC16_color_changer_v-4.1.c,160 :: 		}//while((PORTB & 0x01) == 0)
$01DD	$29C6			GOTO	L__while_PORTB_0x01_15
$01DE	$	L__while_PORTB_0x01_16:
;D-91_PIC16_color_changer_v-4.1.c,162 :: 		return;
;D-91_PIC16_color_changer_v-4.1.c,164 :: 		}
$01DE	$0008			RETURN
$0134	$	__judge_TMR_:
;D-91_PIC16_color_changer_v-4.1.c,170 :: 		int _judge_TMR_(int low, int high) {
;D-91_PIC16_color_changer_v-4.1.c,172 :: 		if(TMR0 < low) //---------------------
$0134	$3080			MOVLW	128
$0135	$1303			BCF	STATUS, RP1
$0136	$1283			BCF	STATUS, RP0
$0137	$00C0			MOVWF	STACK_0
$0138	$3080			MOVLW	128
$0139	$0615			XORWF	FARG__judge_TMR_+1, 0
$013A	$0240			SUBWF	STACK_0, 0
$013B	$1D03			BTFSS	STATUS, Z
$013C	$293F			GOTO	L__judge_TMR__70
$013D	$0814			MOVF	FARG__judge_TMR_+0, 0
$013E	$0201			SUBWF	TMR0, 0
$013F	$	L__judge_TMR__70:
$013F	$1803			BTFSC	STATUS, C
$0140	$294B			GOTO	L__judge_TMR__18
;D-91_PIC16_color_changer_v-4.1.c,175 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0141	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,176 :: 		INTCON |= 0x80;        // interrupt => permitted
$0142	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,183 :: 		_pulse_u_50(3);
$0143	$3003			MOVLW	3
$0144	$0098			MOVWF	FARG__pulse_u_50+0
$0145	$3000			MOVLW	0
$0146	$0099			MOVWF	FARG__pulse_u_50+1
$0147	$2187			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,185 :: 		return false;                // return
$0148	$01C0			CLRF	STACK_0
$0149	$01C1			CLRF	STACK_0+1
$014A	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,196 :: 		} else if (TMR0 > high) {
$014B	$	L__judge_TMR__18:
$014B	$3080			MOVLW	128
$014C	$0617			XORWF	FARG__judge_TMR_+3, 0
$014D	$00C0			MOVWF	STACK_0
$014E	$3080			MOVLW	128
$014F	$0240			SUBWF	STACK_0, 0
$0150	$1D03			BTFSS	STATUS, Z
$0151	$2954			GOTO	L__judge_TMR__71
$0152	$0801			MOVF	TMR0, 0
$0153	$0216			SUBWF	FARG__judge_TMR_+2, 0
$0154	$	L__judge_TMR__71:
$0154	$1803			BTFSC	STATUS, C
$0155	$2960			GOTO	L__judge_TMR__20
;D-91_PIC16_color_changer_v-4.1.c,198 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0156	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,199 :: 		INTCON |= 0x80;        // interrupt => permitted
$0157	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,202 :: 		_pulse_u_50(2);
$0158	$3002			MOVLW	2
$0159	$0098			MOVWF	FARG__pulse_u_50+0
$015A	$3000			MOVLW	0
$015B	$0099			MOVWF	FARG__pulse_u_50+1
$015C	$2187			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,205 :: 		return false;
$015D	$01C0			CLRF	STACK_0
$015E	$01C1			CLRF	STACK_0+1
$015F	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,207 :: 		}
$0160	$	L__judge_TMR__20:
$0160	$	L__judge_TMR__19:
;D-91_PIC16_color_changer_v-4.1.c,209 :: 		return true;
$0160	$3001			MOVLW	1
$0161	$00C0			MOVWF	STACK_0
$0162	$3000			MOVLW	0
$0163	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,211 :: 		}//int _judge_TMR_(int low, int high)
$0164	$0008			RETURN
$0165	$	__pulse_u_100:
;D-91_PIC16_color_changer_v-4.1.c,112 :: 		void _pulse_u_100(int num)
;D-91_PIC16_color_changer_v-4.1.c,116 :: 		for(i = 0; i < num; i++)
$0165	$1303			BCF	STATUS, RP1
$0166	$1283			BCF	STATUS, RP0
$0167	$0196			CLRF	_pulse_u_100_i_L0
$0168	$0197			CLRF	_pulse_u_100_i_L0+1
$0169	$	L__pulse_u_100_9:
$0169	$3080			MOVLW	128
$016A	$0617			XORWF	_pulse_u_100_i_L0+1, 0
$016B	$00C0			MOVWF	STACK_0
$016C	$3080			MOVLW	128
$016D	$0615			XORWF	FARG__pulse_u_100+1, 0
$016E	$0240			SUBWF	STACK_0, 0
$016F	$1D03			BTFSS	STATUS, Z
$0170	$2973			GOTO	L__pulse_u_100_67
$0171	$0814			MOVF	FARG__pulse_u_100+0, 0
$0172	$0216			SUBWF	_pulse_u_100_i_L0, 0
$0173	$	L__pulse_u_100_67:
$0173	$1803			BTFSC	STATUS, C
$0174	$2986			GOTO	L__pulse_u_100_10
;D-91_PIC16_color_changer_v-4.1.c,119 :: 		PORTA = 0x01; Delay_us(100);
$0175	$3001			MOVLW	1
$0176	$0085			MOVWF	PORTA
$0177	$30A6			MOVLW	166
$0178	$00CA			MOVWF	STACK_10
$0179	$0BCA			DECFSZ	STACK_10, F
$017A	$2979			GOTO	$-1
$017B	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,121 :: 		PORTA = 0x00; Delay_us(100);
$017C	$0185			CLRF	PORTA, 1
$017D	$30A6			MOVLW	166
$017E	$00CA			MOVWF	STACK_10
$017F	$0BCA			DECFSZ	STACK_10, F
$0180	$297F			GOTO	$-1
$0181	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,123 :: 		}
$0182	$	L__pulse_u_100_11:
;D-91_PIC16_color_changer_v-4.1.c,116 :: 		for(i = 0; i < num; i++)
$0182	$0A96			INCF	_pulse_u_100_i_L0, 1
$0183	$1903			BTFSC	STATUS, Z
$0184	$0A97			INCF	_pulse_u_100_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,123 :: 		}
$0185	$2969			GOTO	L__pulse_u_100_9
$0186	$	L__pulse_u_100_10:
;D-91_PIC16_color_changer_v-4.1.c,125 :: 		}
$0186	$0008			RETURN
$00FD	$	__read_Reader:
;D-91_PIC16_color_changer_v-4.1.c,466 :: 		_read_Reader() {
;D-91_PIC16_color_changer_v-4.1.c,473 :: 		RESET_TMR;
$00FD	$1303			BCF	STATUS, RP1
$00FE	$1283			BCF	STATUS, RP0
$00FF	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,483 :: 		_while_PORTB_0x01(0);
$0100	$0194			CLRF	FARG__while_PORTB_0x01+0
$0101	$0195			CLRF	FARG__while_PORTB_0x01+1
$0102	$21C6			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,494 :: 		result = _judge_TMR_(156, 196);
$0103	$309C			MOVLW	156
$0104	$1303			BCF	STATUS, RP1
$0105	$1283			BCF	STATUS, RP0
$0106	$0094			MOVWF	FARG__judge_TMR_+0
$0107	$0195			CLRF	FARG__judge_TMR_+1
$0108	$30C4			MOVLW	196
$0109	$0096			MOVWF	FARG__judge_TMR_+2
$010A	$0197			CLRF	FARG__judge_TMR_+3
$010B	$2134			CALL	__judge_TMR_
$010C	$0840			MOVF	STACK_0, 0
$010D	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,496 :: 		if (result == false) {
$010E	$0840			MOVF	STACK_0, 0
$010F	$3A00			XORLW	0
$0110	$1D03			BTFSS	STATUS, Z
$0111	$2915			GOTO	L__read_Reader_51
;D-91_PIC16_color_changer_v-4.1.c,500 :: 		return false;
$0112	$01C0			CLRF	STACK_0
$0113	$01C1			CLRF	STACK_0+1
$0114	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,502 :: 		}
$0115	$	L__read_Reader_51:
;D-91_PIC16_color_changer_v-4.1.c,514 :: 		RESET_TMR;
$0115	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,521 :: 		_while_PORTB_0x01(1);
$0116	$3001			MOVLW	1
$0117	$0094			MOVWF	FARG__while_PORTB_0x01+0
$0118	$3000			MOVLW	0
$0119	$0095			MOVWF	FARG__while_PORTB_0x01+1
$011A	$21C6			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,528 :: 		result = _judge_TMR_(68, 108);
$011B	$3044			MOVLW	68
$011C	$1303			BCF	STATUS, RP1
$011D	$1283			BCF	STATUS, RP0
$011E	$0094			MOVWF	FARG__judge_TMR_+0
$011F	$3000			MOVLW	0
$0120	$0095			MOVWF	FARG__judge_TMR_+1
$0121	$306C			MOVLW	108
$0122	$0096			MOVWF	FARG__judge_TMR_+2
$0123	$3000			MOVLW	0
$0124	$0097			MOVWF	FARG__judge_TMR_+3
$0125	$2134			CALL	__judge_TMR_
$0126	$0840			MOVF	STACK_0, 0
$0127	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,530 :: 		if (result == false) {
$0128	$0840			MOVF	STACK_0, 0
$0129	$3A00			XORLW	0
$012A	$1D03			BTFSS	STATUS, Z
$012B	$292F			GOTO	L__read_Reader_52
;D-91_PIC16_color_changer_v-4.1.c,534 :: 		return false;
$012C	$01C0			CLRF	STACK_0
$012D	$01C1			CLRF	STACK_0+1
$012E	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,536 :: 		}
$012F	$	L__read_Reader_52:
;D-91_PIC16_color_changer_v-4.1.c,543 :: 		return true;
$012F	$3001			MOVLW	1
$0130	$00C0			MOVWF	STACK_0
$0131	$3000			MOVLW	0
$0132	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,545 :: 		}//_read_Reader
$0133	$0008			RETURN
$0081	$	__read_Custom:
;D-91_PIC16_color_changer_v-4.1.c,548 :: 		_read_Custom() {
;D-91_PIC16_color_changer_v-4.1.c,550 :: 		custom_code_a = 0x00;
$0081	$1303			BCF	STATUS, RP1
$0082	$1283			BCF	STATUS, RP0
$0083	$018D			CLRF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,554 :: 		for(i = 0; i < bit_len; i++)
$0084	$018E			CLRF	_i, 1
$0085	$	L__read_Custom_53:
$0085	$080F			MOVF	_bit_len, 0
$0086	$020E			SUBWF	_i, 0
$0087	$1803			BTFSC	STATUS, C
$0088	$28C4			GOTO	L__read_Custom_54
;D-91_PIC16_color_changer_v-4.1.c,556 :: 		RESET_TMR;
$0089	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,558 :: 		while((PORTB & 0x01) == 0)
$008A	$	L__read_Custom_56:
$008A	$3001			MOVLW	1
$008B	$0506			ANDWF	PORTB, 0
$008C	$00C1			MOVWF	STACK_1
$008D	$0841			MOVF	STACK_1, 0
$008E	$3A00			XORLW	0
$008F	$1D03			BTFSS	STATUS, Z
$0090	$2896			GOTO	L__read_Custom_57
;D-91_PIC16_color_changer_v-4.1.c,561 :: 		TIME_OUT;
$0091	$0801			MOVF	TMR0, 0
$0092	$3AFF			XORLW	255
$0093	$1903			BTFSC	STATUS, Z
$0094	$2896			GOTO	L__read_Custom_57
$0095	$	L__read_Custom_58:
;D-91_PIC16_color_changer_v-4.1.c,563 :: 		}
$0095	$288A			GOTO	L__read_Custom_56
$0096	$	L__read_Custom_57:
;D-91_PIC16_color_changer_v-4.1.c,565 :: 		while((PORTB & 0x01) == 1)
$0096	$	L__read_Custom_59:
$0096	$3001			MOVLW	1
$0097	$0506			ANDWF	PORTB, 0
$0098	$00C1			MOVWF	STACK_1
$0099	$0841			MOVF	STACK_1, 0
$009A	$3A01			XORLW	1
$009B	$1D03			BTFSS	STATUS, Z
$009C	$28A2			GOTO	L__read_Custom_60
;D-91_PIC16_color_changer_v-4.1.c,568 :: 		TIME_OUT;
$009D	$0801			MOVF	TMR0, 0
$009E	$3AFF			XORLW	255
$009F	$1903			BTFSC	STATUS, Z
$00A0	$28A2			GOTO	L__read_Custom_60
$00A1	$	L__read_Custom_61:
;D-91_PIC16_color_changer_v-4.1.c,570 :: 		}
$00A1	$2896			GOTO	L__read_Custom_59
$00A2	$	L__read_Custom_60:
;D-91_PIC16_color_changer_v-4.1.c,572 :: 		if (TMR0 < 33)
$00A2	$3021			MOVLW	33
$00A3	$0201			SUBWF	TMR0, 0
$00A4	$1803			BTFSC	STATUS, C
$00A5	$28B5			GOTO	L__read_Custom_62
;D-91_PIC16_color_changer_v-4.1.c,575 :: 		custom_code_a &= ~(0x01 << i);
$00A6	$080E			MOVF	_i, 0
$00A7	$00C1			MOVWF	STACK_1
$00A8	$3001			MOVLW	1
$00A9	$00C0			MOVWF	STACK_0
$00AA	$0841			MOVF	STACK_1, 0
$00AB	$	L__read_Custom_76:
$00AB	$1903			BTFSC	STATUS, Z
$00AC	$28B1			GOTO	L__read_Custom_77
$00AD	$0DC0			RLF	STACK_0, 1
$00AE	$1040			BCF	STACK_0, 0
$00AF	$3FFF			ADDLW	255
$00B0	$28AB			GOTO	L__read_Custom_76
$00B1	$	L__read_Custom_77:
$00B1	$09C0			COMF	STACK_0, F
$00B2	$0840			MOVF	STACK_0, 0
$00B3	$058D			ANDWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,577 :: 		}
$00B4	$28C2			GOTO	L__read_Custom_63
$00B5	$	L__read_Custom_62:
;D-91_PIC16_color_changer_v-4.1.c,581 :: 		custom_code_a |= (0x01 << i);
$00B5	$080E			MOVF	_i, 0
$00B6	$00C1			MOVWF	STACK_1
$00B7	$3001			MOVLW	1
$00B8	$00C0			MOVWF	STACK_0
$00B9	$0841			MOVF	STACK_1, 0
$00BA	$	L__read_Custom_78:
$00BA	$1903			BTFSC	STATUS, Z
$00BB	$28C0			GOTO	L__read_Custom_79
$00BC	$0DC0			RLF	STACK_0, 1
$00BD	$1040			BCF	STACK_0, 0
$00BE	$3FFF			ADDLW	255
$00BF	$28BA			GOTO	L__read_Custom_78
$00C0	$	L__read_Custom_79:
$00C0	$0840			MOVF	STACK_0, 0
$00C1	$048D			IORWF	_custom_code_a, 1
;D-91_PIC16_color_changer_v-4.1.c,583 :: 		}//if (TMR0 < 33)
$00C2	$	L__read_Custom_63:
;D-91_PIC16_color_changer_v-4.1.c,585 :: 		}//for(i = 0; i < bit_len; i++)
$00C2	$	L__read_Custom_55:
;D-91_PIC16_color_changer_v-4.1.c,554 :: 		for(i = 0; i < bit_len; i++)
$00C2	$0A8E			INCF	_i, 1
;D-91_PIC16_color_changer_v-4.1.c,585 :: 		}//for(i = 0; i < bit_len; i++)
$00C3	$2885			GOTO	L__read_Custom_53
$00C4	$	L__read_Custom_54:
;D-91_PIC16_color_changer_v-4.1.c,588 :: 		}//_read_Custom
$00C4	$0008			RETURN
$0033	$	__response_2:
;D-91_PIC16_color_changer_v-4.1.c,262 :: 		_response_2(void) {
;D-91_PIC16_color_changer_v-4.1.c,264 :: 		switch(custom_code_a) {
$0033	$2861			GOTO	L__response_2_27
;D-91_PIC16_color_changer_v-4.1.c,266 :: 		case 1: _pulse_u_100(1); break;
$0034	$	L__response_2_29:
$0034	$3001			MOVLW	1
$0035	$1303			BCF	STATUS, RP1
$0036	$1283			BCF	STATUS, RP0
$0037	$0094			MOVWF	FARG__pulse_u_100+0
$0038	$3000			MOVLW	0
$0039	$0095			MOVWF	FARG__pulse_u_100+1
$003A	$2165			CALL	__pulse_u_100
$003B	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,267 :: 		case 2: _pulse_u_100(2); break;
$003C	$	L__response_2_30:
$003C	$3002			MOVLW	2
$003D	$0094			MOVWF	FARG__pulse_u_100+0
$003E	$3000			MOVLW	0
$003F	$0095			MOVWF	FARG__pulse_u_100+1
$0040	$2165			CALL	__pulse_u_100
$0041	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,268 :: 		case 3: _pulse_u_100(3); break;
$0042	$	L__response_2_31:
$0042	$3003			MOVLW	3
$0043	$0094			MOVWF	FARG__pulse_u_100+0
$0044	$3000			MOVLW	0
$0045	$0095			MOVWF	FARG__pulse_u_100+1
$0046	$2165			CALL	__pulse_u_100
$0047	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,269 :: 		case 4: _pulse_u_100(4); break;
$0048	$	L__response_2_32:
$0048	$3004			MOVLW	4
$0049	$0094			MOVWF	FARG__pulse_u_100+0
$004A	$3000			MOVLW	0
$004B	$0095			MOVWF	FARG__pulse_u_100+1
$004C	$2165			CALL	__pulse_u_100
$004D	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,270 :: 		case 5: _pulse_u_100(5); break;
$004E	$	L__response_2_33:
$004E	$3005			MOVLW	5
$004F	$0094			MOVWF	FARG__pulse_u_100+0
$0050	$3000			MOVLW	0
$0051	$0095			MOVWF	FARG__pulse_u_100+1
$0052	$2165			CALL	__pulse_u_100
$0053	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,271 :: 		case 6: _pulse_u_100(6); break;
$0054	$	L__response_2_34:
$0054	$3006			MOVLW	6
$0055	$0094			MOVWF	FARG__pulse_u_100+0
$0056	$3000			MOVLW	0
$0057	$0095			MOVWF	FARG__pulse_u_100+1
$0058	$2165			CALL	__pulse_u_100
$0059	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,272 :: 		case 7: _pulse_u_100(7); break;
$005A	$	L__response_2_35:
$005A	$3007			MOVLW	7
$005B	$0094			MOVWF	FARG__pulse_u_100+0
$005C	$3000			MOVLW	0
$005D	$0095			MOVWF	FARG__pulse_u_100+1
$005E	$2165			CALL	__pulse_u_100
$005F	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,274 :: 		default: break;
$0060	$	L__response_2_36:
$0060	$2880			GOTO	L__response_2_28
;D-91_PIC16_color_changer_v-4.1.c,276 :: 		}//switch(custom_code_a)
$0061	$	L__response_2_27:
$0061	$1303			BCF	STATUS, RP1
$0062	$1283			BCF	STATUS, RP0
$0063	$080D			MOVF	_custom_code_a, 0
$0064	$3A01			XORLW	1
$0065	$1903			BTFSC	STATUS, Z
$0066	$2834			GOTO	L__response_2_29
$0067	$080D			MOVF	_custom_code_a, 0
$0068	$3A02			XORLW	2
$0069	$1903			BTFSC	STATUS, Z
$006A	$283C			GOTO	L__response_2_30
$006B	$080D			MOVF	_custom_code_a, 0
$006C	$3A03			XORLW	3
$006D	$1903			BTFSC	STATUS, Z
$006E	$2842			GOTO	L__response_2_31
$006F	$080D			MOVF	_custom_code_a, 0
$0070	$3A04			XORLW	4
$0071	$1903			BTFSC	STATUS, Z
$0072	$2848			GOTO	L__response_2_32
$0073	$080D			MOVF	_custom_code_a, 0
$0074	$3A05			XORLW	5
$0075	$1903			BTFSC	STATUS, Z
$0076	$284E			GOTO	L__response_2_33
$0077	$080D			MOVF	_custom_code_a, 0
$0078	$3A06			XORLW	6
$0079	$1903			BTFSC	STATUS, Z
$007A	$2854			GOTO	L__response_2_34
$007B	$080D			MOVF	_custom_code_a, 0
$007C	$3A07			XORLW	7
$007D	$1903			BTFSC	STATUS, Z
$007E	$285A			GOTO	L__response_2_35
$007F	$2860			GOTO	L__response_2_36
$0080	$	L__response_2_28:
;D-91_PIC16_color_changer_v-4.1.c,278 :: 		}//_response_2
$0080	$0008			RETURN
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
;D-91_PIC16_color_changer_v-4.1.c,331 :: 		void interrupt(void)
;D-91_PIC16_color_changer_v-4.1.c,342 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,343 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,344 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,351 :: 		PORTA = 0x00;
$0015	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,358 :: 		result = _read_Reader();
$0016	$20FD			CALL	__read_Reader
$0017	$0840			MOVF	STACK_0, 0
$0018	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,365 :: 		if (result == false) {
$0019	$0840			MOVF	STACK_0, 0
$001A	$3A00			XORLW	0
$001B	$1D03			BTFSS	STATUS, Z
$001C	$281E			GOTO	L_interrupt_48
;D-91_PIC16_color_changer_v-4.1.c,369 :: 		return;
$001D	$2828			GOTO	L_Interrupt_end
;D-91_PIC16_color_changer_v-4.1.c,371 :: 		}
$001E	$	L_interrupt_48:
;D-91_PIC16_color_changer_v-4.1.c,378 :: 		_read_Custom();
$001E	$2081			CALL	__read_Custom
;D-91_PIC16_color_changer_v-4.1.c,395 :: 		_response_2();
$001F	$2033			CALL	__response_2
;D-91_PIC16_color_changer_v-4.1.c,403 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$0020	$307F			MOVLW	127
$0021	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,404 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0022	$30EF			MOVLW	239
$0023	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,405 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0024	$30FD			MOVLW	253
$0025	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,421 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0026	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,422 :: 		INTCON |= 0x80;
$0027	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,424 :: 		}//void interrupt(void)
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
$01A7	$	__main_Setup:
;D-91_PIC16_color_changer_v-4.1.c,591 :: 		_main_Setup() {
;D-91_PIC16_color_changer_v-4.1.c,594 :: 		TRISA     = 0x00;
$01A7	$1303			BCF	STATUS, RP1
$01A8	$1683			BSF	STATUS, RP0
$01A9	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-4.1.c,595 :: 		PORTA     = 0x00;		//0000 0010
$01AA	$1283			BCF	STATUS, RP0
$01AB	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,597 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$01AC	$30FF			MOVLW	255
$01AD	$1683			BSF	STATUS, RP0
$01AE	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-4.1.c,599 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$01AF	$307F			MOVLW	127
$01B0	$0501			ANDWF	OPTION_REG, 0
$01B1	$00C0			MOVWF	STACK_0
$01B2	$0840			MOVF	STACK_0, 0
$01B3	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,601 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$01B4	$30BF			MOVLW	191
$01B5	$05C0			ANDWF	STACK_0, 1
$01B6	$0840			MOVF	STACK_0, 0
$01B7	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,603 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$01B8	$30DF			MOVLW	223
$01B9	$05C0			ANDWF	STACK_0, 1
$01BA	$0840			MOVF	STACK_0, 0
$01BB	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,604 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$01BC	$30F0			MOVLW	240
$01BD	$05C0			ANDWF	STACK_0, 1
$01BE	$0840			MOVF	STACK_0, 0
$01BF	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,605 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$01C0	$3007			MOVLW	7
$01C1	$0440			IORWF	STACK_0, 0
$01C2	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,612 :: 		bit_len = 4;
$01C3	$3004			MOVLW	4
$01C4	$008F			MOVWF	_bit_len
;D-91_PIC16_color_changer_v-4.1.c,614 :: 		}//_main_Setup
$01C5	$0008			RETURN
$01E4	$	GlobalIniD-91_PIC16_color_changer_v-4:
$01E4	$3001			MOVLW	1
$01E5	$1303			BCF	STATUS, RP1
$01E6	$1283			BCF	STATUS, RP0
$01E7	$0090			MOVWF	_LED_FLAG+0
$01E8	$0008			RETURN
$01DF	$	_main:
;D-91_PIC16_color_changer_v-4.1.c,427 :: 		void main(void)
;D-91_PIC16_color_changer_v-4.1.c,430 :: 		_main_Setup();
$01DF	$21A7			CALL	__main_Setup
;D-91_PIC16_color_changer_v-4.1.c,452 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$01E0	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,453 :: 		INTCON |= 0x80;
$01E1	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,455 :: 		while(1)
$01E2	$	L_main_49:
$01E2	$29E2			GOTO	L_main_49
;D-91_PIC16_color_changer_v-4.1.c,463 :: 		}//void main(void)
$01E3	$29E3			GOTO	$
