;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/09/08 9:07:46
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$293F			GOTO	_main
$017D	$	__pulse_Modulation:
;D-91_PIC16_color_changer_v-3.1.c,77 :: 		_pulse_Modulation(void)
;D-91_PIC16_color_changer_v-3.1.c,81 :: 		PORTA        = 0x01;   // RA0 => on
$017D	$3001			MOVLW	1
$017E	$1303			BCF	STATUS, RP1
$017F	$1283			BCF	STATUS, RP0
$0180	$0085			MOVWF	PORTA
;D-91_PIC16_color_changer_v-3.1.c,82 :: 		Delay_us(9);   // 8.8us
$0181	$300E			MOVLW	14
$0182	$00CA			MOVWF	STACK_10
$0183	$0BCA			DECFSZ	STACK_10, F
$0184	$2983			GOTO	$-1
$0185	$0000			NOP
$0186	$0000			NOP
;D-91_PIC16_color_changer_v-3.1.c,84 :: 		PORTA        = 0x00;   // RA0 => off
$0187	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,85 :: 		Delay_us(17);   // 26.3us - 8.8us =% 17us
$0188	$301C			MOVLW	28
$0189	$00CA			MOVWF	STACK_10
$018A	$0BCA			DECFSZ	STACK_10, F
$018B	$298A			GOTO	$-1
;D-91_PIC16_color_changer_v-3.1.c,87 :: 		}
$018C	$0008			RETURN
$0161	$	__reader:
;D-91_PIC16_color_changer_v-3.1.c,90 :: 		_reader(void)
;D-91_PIC16_color_changer_v-3.1.c,93 :: 		TMR0     = 0;
$0161	$1303			BCF	STATUS, RP1
$0162	$1283			BCF	STATUS, RP0
$0163	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-3.1.c,97 :: 		while(MS90)         // 9.0ms
$0164	$	L__reader_0:
$0164	$30B0			MOVLW	176
$0165	$0201			SUBWF	TMR0, 0
$0166	$1803			BTFSC	STATUS, C
$0167	$2976			GOTO	L__reader_1
;D-91_PIC16_color_changer_v-3.1.c,100 :: 		PORTA        = 0x01;   // RA0 => on
$0168	$3001			MOVLW	1
$0169	$0085			MOVWF	PORTA
;D-91_PIC16_color_changer_v-3.1.c,101 :: 		Delay_us(9);   // 8.8us
$016A	$300E			MOVLW	14
$016B	$00CA			MOVWF	STACK_10
$016C	$0BCA			DECFSZ	STACK_10, F
$016D	$296C			GOTO	$-1
$016E	$0000			NOP
$016F	$0000			NOP
;D-91_PIC16_color_changer_v-3.1.c,103 :: 		PORTA        = 0x00;   // RA0 => off
$0170	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,104 :: 		Delay_us(17);   // 26.3us - 8.8us =% 17us
$0171	$301C			MOVLW	28
$0172	$00CA			MOVWF	STACK_10
$0173	$0BCA			DECFSZ	STACK_10, F
$0174	$2973			GOTO	$-1
;D-91_PIC16_color_changer_v-3.1.c,106 :: 		}
$0175	$2964			GOTO	L__reader_0
$0176	$	L__reader_1:
;D-91_PIC16_color_changer_v-3.1.c,108 :: 		TMR0 = 0;
$0176	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-3.1.c,109 :: 		PORTA = 0x00;
$0177	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,111 :: 		while(MS45)       // 4.5ms
$0178	$	L__reader_2:
$0178	$3058			MOVLW	88
$0179	$0201			SUBWF	TMR0, 0
$017A	$1C03			BTFSS	STATUS, C
$017B	$2978			GOTO	L__reader_2
;D-91_PIC16_color_changer_v-3.1.c,115 :: 		}
$017C	$	L__reader_3:
;D-91_PIC16_color_changer_v-3.1.c,117 :: 		}//void _reader(void)
$017C	$0008			RETURN
$00EC	$	__custom_lower_num:
;D-91_PIC16_color_changer_v-3.1.c,173 :: 		_custom_lower_num(int code)
;D-91_PIC16_color_changer_v-3.1.c,176 :: 		bit_len = 4;
$00EC	$3004			MOVLW	4
$00ED	$1303			BCF	STATUS, RP1
$00EE	$1283			BCF	STATUS, RP0
$00EF	$008C			MOVWF	_bit_len
;D-91_PIC16_color_changer_v-3.1.c,178 :: 		custom_code_a = code;
$00F0	$0814			MOVF	FARG__custom_lower_num+0, 0
$00F1	$008D			MOVWF	_custom_code_a
;D-91_PIC16_color_changer_v-3.1.c,182 :: 		for(i = 0; i < bit_len; i++)
$00F2	$018E			CLRF	_i, 1
$00F3	$	L__custom_lower_num_15:
$00F3	$080C			MOVF	_bit_len, 0
$00F4	$020E			SUBWF	_i, 0
$00F5	$1803			BTFSC	STATUS, C
$00F6	$291C			GOTO	L__custom_lower_num_16
;D-91_PIC16_color_changer_v-3.1.c,190 :: 		RESET_TMR;
$00F7	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-3.1.c,192 :: 		while(TMR0 < 11)	// 0.56ms
$00F8	$	L__custom_lower_num_18:
$00F8	$300B			MOVLW	11
$00F9	$0201			SUBWF	TMR0, 0
$00FA	$1803			BTFSC	STATUS, C
$00FB	$28FE			GOTO	L__custom_lower_num_19
;D-91_PIC16_color_changer_v-3.1.c,194 :: 		_pulse_Modulation();
$00FC	$217D			CALL	__pulse_Modulation
;D-91_PIC16_color_changer_v-3.1.c,196 :: 		}
$00FD	$28F8			GOTO	L__custom_lower_num_18
$00FE	$	L__custom_lower_num_19:
;D-91_PIC16_color_changer_v-3.1.c,203 :: 		PORTA = 0x00;
$00FE	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,205 :: 		if (((custom_code_a >> i) & 0x01) == 0)
$00FF	$080E			MOVF	_i, 0
$0100	$00C1			MOVWF	STACK_1
$0101	$080D			MOVF	_custom_code_a, 0
$0102	$00C0			MOVWF	STACK_0
$0103	$0841			MOVF	STACK_1, 0
$0104	$	L__custom_lower_num_62:
$0104	$1903			BTFSC	STATUS, Z
$0105	$290A			GOTO	L__custom_lower_num_63
$0106	$0CC0			RRF	STACK_0, 1
$0107	$13C0			BCF	STACK_0, 7
$0108	$3FFF			ADDLW	255
$0109	$2904			GOTO	L__custom_lower_num_62
$010A	$	L__custom_lower_num_63:
$010A	$3001			MOVLW	1
$010B	$0540			ANDWF	STACK_0, 0
$010C	$00C1			MOVWF	STACK_1
$010D	$0841			MOVF	STACK_1, 0
$010E	$3A00			XORLW	0
$010F	$1D03			BTFSS	STATUS, Z
$0110	$2916			GOTO	L__custom_lower_num_20
;D-91_PIC16_color_changer_v-3.1.c,208 :: 		while(TMR0 < 22)	// 1.125ms
$0111	$	L__custom_lower_num_21:
$0111	$3016			MOVLW	22
$0112	$0201			SUBWF	TMR0, 0
$0113	$1C03			BTFSS	STATUS, C
$0114	$2911			GOTO	L__custom_lower_num_21
;D-91_PIC16_color_changer_v-3.1.c,211 :: 		}
$0115	$	L__custom_lower_num_22:
;D-91_PIC16_color_changer_v-3.1.c,213 :: 		} else {
$0115	$291A			GOTO	L__custom_lower_num_23
$0116	$	L__custom_lower_num_20:
;D-91_PIC16_color_changer_v-3.1.c,215 :: 		while(TMR0 < 44)	// 2.250ms
$0116	$	L__custom_lower_num_24:
$0116	$302C			MOVLW	44
$0117	$0201			SUBWF	TMR0, 0
$0118	$1C03			BTFSS	STATUS, C
$0119	$2916			GOTO	L__custom_lower_num_24
;D-91_PIC16_color_changer_v-3.1.c,218 :: 		}
$011A	$	L__custom_lower_num_25:
;D-91_PIC16_color_changer_v-3.1.c,220 :: 		}//if (((custom_code_a >> i) & 0x01) == 0)
$011A	$	L__custom_lower_num_23:
;D-91_PIC16_color_changer_v-3.1.c,222 :: 		}//for(i = 0; i < bit_len)
$011A	$	L__custom_lower_num_17:
;D-91_PIC16_color_changer_v-3.1.c,182 :: 		for(i = 0; i < bit_len; i++)
$011A	$0A8E			INCF	_i, 1
;D-91_PIC16_color_changer_v-3.1.c,222 :: 		}//for(i = 0; i < bit_len)
$011B	$28F3			GOTO	L__custom_lower_num_15
$011C	$	L__custom_lower_num_16:
;D-91_PIC16_color_changer_v-3.1.c,224 :: 		}//_custom_lower
$011C	$0008			RETURN
$0197	$	__send_StopBit:
;D-91_PIC16_color_changer_v-3.1.c,402 :: 		void _send_StopBit(void) {
;D-91_PIC16_color_changer_v-3.1.c,404 :: 		RESET_TMR;
$0197	$1303			BCF	STATUS, RP1
$0198	$1283			BCF	STATUS, RP0
$0199	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-3.1.c,406 :: 		while(TMR0 < 11) {
$019A	$	L__send_StopBit_58:
$019A	$300B			MOVLW	11
$019B	$0201			SUBWF	TMR0, 0
$019C	$1803			BTFSC	STATUS, C
$019D	$29A0			GOTO	L__send_StopBit_59
;D-91_PIC16_color_changer_v-3.1.c,408 :: 		_pulse_Modulation();
$019E	$217D			CALL	__pulse_Modulation
;D-91_PIC16_color_changer_v-3.1.c,410 :: 		}
$019F	$299A			GOTO	L__send_StopBit_58
$01A0	$	L__send_StopBit_59:
;D-91_PIC16_color_changer_v-3.1.c,412 :: 		}
$01A0	$0008			RETURN
$011D	$	__Delay_50ms:
;D-91_PIC16_color_changer_v-3.1.c,227 :: 		_Delay_50ms(void) {
;D-91_PIC16_color_changer_v-3.1.c,229 :: 		Delay_ms(50);
$011D	$3002			MOVLW	2
$011E	$1303			BCF	STATUS, RP1
$011F	$1283			BCF	STATUS, RP0
$0120	$00CC			MOVWF	STACK_12
$0121	$30FF			MOVLW	255
$0122	$00CB			MOVWF	STACK_11
$0123	$30FF			MOVLW	255
$0124	$00CA			MOVWF	STACK_10
$0125	$0BCC			DECFSZ	STACK_12, F
$0126	$2928			GOTO	$+2
$0127	$292F			GOTO	$+8
$0128	$0BCB			DECFSZ	STACK_11, F
$0129	$292B			GOTO	$+2
$012A	$292E			GOTO	$+4
$012B	$0BCA			DECFSZ	STACK_10, F
$012C	$292B			GOTO	$-1
$012D	$2928			GOTO	$-5
$012E	$2925			GOTO	$-9
$012F	$3046			MOVLW	70
$0130	$00CB			MOVWF	STACK_11
$0131	$30FF			MOVLW	255
$0132	$00CA			MOVWF	STACK_10
$0133	$0BCB			DECFSZ	STACK_11, F
$0134	$2936			GOTO	$+2
$0135	$2939			GOTO	$+4
$0136	$0BCA			DECFSZ	STACK_10, F
$0137	$2936			GOTO	$-1
$0138	$2933			GOTO	$-5
$0139	$30CF			MOVLW	207
$013A	$00CA			MOVWF	STACK_10
$013B	$0BCA			DECFSZ	STACK_10, F
$013C	$293B			GOTO	$-1
$013D	$0000			NOP
;D-91_PIC16_color_changer_v-3.1.c,231 :: 		}
$013E	$0008			RETURN
$018D	$	__output:
;D-91_PIC16_color_changer_v-3.1.c,442 :: 		_output(int num) {
;D-91_PIC16_color_changer_v-3.1.c,444 :: 		_reader();
$018D	$2161			CALL	__reader
;D-91_PIC16_color_changer_v-3.1.c,447 :: 		_custom_lower_num(num);
$018E	$0812			MOVF	FARG__output+0, 0
$018F	$0094			MOVWF	FARG__custom_lower_num+0
$0190	$0813			MOVF	FARG__output+1, 0
$0191	$0095			MOVWF	FARG__custom_lower_num+1
$0192	$20EC			CALL	__custom_lower_num
;D-91_PIC16_color_changer_v-3.1.c,454 :: 		_send_StopBit();
$0193	$2197			CALL	__send_StopBit
;D-91_PIC16_color_changer_v-3.1.c,461 :: 		PORTA = 0x00;
$0194	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,469 :: 		_Delay_50ms();
$0195	$211D			CALL	__Delay_50ms
;D-91_PIC16_color_changer_v-3.1.c,471 :: 		}//_output
$0196	$0008			RETURN
$0023	$	__Opearations:
;D-91_PIC16_color_changer_v-3.1.c,234 :: 		_Opearations() {
;D-91_PIC16_color_changer_v-3.1.c,236 :: 		while(PORTB_0_H) {
$0023	$	L__Opearations_26:
$0023	$3001			MOVLW	1
$0024	$1303			BCF	STATUS, RP1
$0025	$1283			BCF	STATUS, RP0
$0026	$0506			ANDWF	PORTB, 0
$0027	$00C1			MOVWF	STACK_1
$0028	$0841			MOVF	STACK_1, 0
$0029	$3A01			XORLW	1
$002A	$1D03			BTFSS	STATUS, Z
$002B	$28EB			GOTO	L__Opearations_27
;D-91_PIC16_color_changer_v-3.1.c,244 :: 		if ((PORTB_1_H) && !(PORTB_2_H) && !(PORTB_3_H)) {
$002C	$3002			MOVLW	2
$002D	$0506			ANDWF	PORTB, 0
$002E	$00C1			MOVWF	STACK_1
$002F	$0841			MOVF	STACK_1, 0
$0030	$3A02			XORLW	2
$0031	$1D03			BTFSS	STATUS, Z
$0032	$2847			GOTO	L__Opearations_30
$0033	$3004			MOVLW	4
$0034	$0506			ANDWF	PORTB, 0
$0035	$00C1			MOVWF	STACK_1
$0036	$0841			MOVF	STACK_1, 0
$0037	$3A04			XORLW	4
$0038	$1903			BTFSC	STATUS, Z
$0039	$2847			GOTO	L__Opearations_30
$003A	$3008			MOVLW	8
$003B	$0506			ANDWF	PORTB, 0
$003C	$00C1			MOVWF	STACK_1
$003D	$0841			MOVF	STACK_1, 0
$003E	$3A08			XORLW	8
$003F	$1903			BTFSC	STATUS, Z
$0040	$2847			GOTO	L__Opearations_30
$0041	$	L156_ex_L__Opearations_30:
;D-91_PIC16_color_changer_v-3.1.c,246 :: 		_output(4);
$0041	$3004			MOVLW	4
$0042	$0092			MOVWF	FARG__output+0
$0043	$3000			MOVLW	0
$0044	$0093			MOVWF	FARG__output+1
$0045	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,277 :: 		} else if (!(PORTB_1_H) && (PORTB_2_H) && !(PORTB_3_H)) {
$0046	$28EA			GOTO	L__Opearations_31
$0047	$	L__Opearations_30:
$0047	$3002			MOVLW	2
$0048	$0506			ANDWF	PORTB, 0
$0049	$00C1			MOVWF	STACK_1
$004A	$0841			MOVF	STACK_1, 0
$004B	$3A02			XORLW	2
$004C	$1903			BTFSC	STATUS, Z
$004D	$2862			GOTO	L__Opearations_34
$004E	$3004			MOVLW	4
$004F	$0506			ANDWF	PORTB, 0
$0050	$00C1			MOVWF	STACK_1
$0051	$0841			MOVF	STACK_1, 0
$0052	$3A04			XORLW	4
$0053	$1D03			BTFSS	STATUS, Z
$0054	$2862			GOTO	L__Opearations_34
$0055	$3008			MOVLW	8
$0056	$0506			ANDWF	PORTB, 0
$0057	$00C1			MOVWF	STACK_1
$0058	$0841			MOVF	STACK_1, 0
$0059	$3A08			XORLW	8
$005A	$1903			BTFSC	STATUS, Z
$005B	$2862			GOTO	L__Opearations_34
$005C	$	L178_ex_L__Opearations_34:
;D-91_PIC16_color_changer_v-3.1.c,279 :: 		_output(2);
$005C	$3002			MOVLW	2
$005D	$0092			MOVWF	FARG__output+0
$005E	$3000			MOVLW	0
$005F	$0093			MOVWF	FARG__output+1
$0060	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,281 :: 		} else if (!(PORTB_1_H) && !(PORTB_2_H) && (PORTB_3_H)) {
$0061	$28EA			GOTO	L__Opearations_35
$0062	$	L__Opearations_34:
$0062	$3002			MOVLW	2
$0063	$0506			ANDWF	PORTB, 0
$0064	$00C1			MOVWF	STACK_1
$0065	$0841			MOVF	STACK_1, 0
$0066	$3A02			XORLW	2
$0067	$1903			BTFSC	STATUS, Z
$0068	$287D			GOTO	L__Opearations_38
$0069	$3004			MOVLW	4
$006A	$0506			ANDWF	PORTB, 0
$006B	$00C1			MOVWF	STACK_1
$006C	$0841			MOVF	STACK_1, 0
$006D	$3A04			XORLW	4
$006E	$1903			BTFSC	STATUS, Z
$006F	$287D			GOTO	L__Opearations_38
$0070	$3008			MOVLW	8
$0071	$0506			ANDWF	PORTB, 0
$0072	$00C1			MOVWF	STACK_1
$0073	$0841			MOVF	STACK_1, 0
$0074	$3A08			XORLW	8
$0075	$1D03			BTFSS	STATUS, Z
$0076	$287D			GOTO	L__Opearations_38
$0077	$	L200_ex_L__Opearations_38:
;D-91_PIC16_color_changer_v-3.1.c,283 :: 		_output(1);
$0077	$3001			MOVLW	1
$0078	$0092			MOVWF	FARG__output+0
$0079	$3000			MOVLW	0
$007A	$0093			MOVWF	FARG__output+1
$007B	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,285 :: 		} else if (!(PORTB_1_H) && (PORTB_2_H) && (PORTB_3_H)) {	// 011
$007C	$28EA			GOTO	L__Opearations_39
$007D	$	L__Opearations_38:
$007D	$3002			MOVLW	2
$007E	$0506			ANDWF	PORTB, 0
$007F	$00C1			MOVWF	STACK_1
$0080	$0841			MOVF	STACK_1, 0
$0081	$3A02			XORLW	2
$0082	$1903			BTFSC	STATUS, Z
$0083	$2898			GOTO	L__Opearations_42
$0084	$3004			MOVLW	4
$0085	$0506			ANDWF	PORTB, 0
$0086	$00C1			MOVWF	STACK_1
$0087	$0841			MOVF	STACK_1, 0
$0088	$3A04			XORLW	4
$0089	$1D03			BTFSS	STATUS, Z
$008A	$2898			GOTO	L__Opearations_42
$008B	$3008			MOVLW	8
$008C	$0506			ANDWF	PORTB, 0
$008D	$00C1			MOVWF	STACK_1
$008E	$0841			MOVF	STACK_1, 0
$008F	$3A08			XORLW	8
$0090	$1D03			BTFSS	STATUS, Z
$0091	$2898			GOTO	L__Opearations_42
$0092	$	L221_ex_L__Opearations_42:
;D-91_PIC16_color_changer_v-3.1.c,287 :: 		_output(3);
$0092	$3003			MOVLW	3
$0093	$0092			MOVWF	FARG__output+0
$0094	$3000			MOVLW	0
$0095	$0093			MOVWF	FARG__output+1
$0096	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,289 :: 		} else if ((PORTB_1_H) && (PORTB_2_H) && !(PORTB_3_H)) {	// 110 : 4 + 2 = 6
$0097	$28EA			GOTO	L__Opearations_43
$0098	$	L__Opearations_42:
$0098	$3002			MOVLW	2
$0099	$0506			ANDWF	PORTB, 0
$009A	$00C1			MOVWF	STACK_1
$009B	$0841			MOVF	STACK_1, 0
$009C	$3A02			XORLW	2
$009D	$1D03			BTFSS	STATUS, Z
$009E	$28B3			GOTO	L__Opearations_46
$009F	$3004			MOVLW	4
$00A0	$0506			ANDWF	PORTB, 0
$00A1	$00C1			MOVWF	STACK_1
$00A2	$0841			MOVF	STACK_1, 0
$00A3	$3A04			XORLW	4
$00A4	$1D03			BTFSS	STATUS, Z
$00A5	$28B3			GOTO	L__Opearations_46
$00A6	$3008			MOVLW	8
$00A7	$0506			ANDWF	PORTB, 0
$00A8	$00C1			MOVWF	STACK_1
$00A9	$0841			MOVF	STACK_1, 0
$00AA	$3A08			XORLW	8
$00AB	$1903			BTFSC	STATUS, Z
$00AC	$28B3			GOTO	L__Opearations_46
$00AD	$	L242_ex_L__Opearations_46:
;D-91_PIC16_color_changer_v-3.1.c,291 :: 		_output(6);
$00AD	$3006			MOVLW	6
$00AE	$0092			MOVWF	FARG__output+0
$00AF	$3000			MOVLW	0
$00B0	$0093			MOVWF	FARG__output+1
$00B1	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,293 :: 		} else if ((PORTB_1_H) && !(PORTB_2_H) && (PORTB_3_H)) {	// 101 => 4 + 1 = 5
$00B2	$28EA			GOTO	L__Opearations_47
$00B3	$	L__Opearations_46:
$00B3	$3002			MOVLW	2
$00B4	$0506			ANDWF	PORTB, 0
$00B5	$00C1			MOVWF	STACK_1
$00B6	$0841			MOVF	STACK_1, 0
$00B7	$3A02			XORLW	2
$00B8	$1D03			BTFSS	STATUS, Z
$00B9	$28CE			GOTO	L__Opearations_50
$00BA	$3004			MOVLW	4
$00BB	$0506			ANDWF	PORTB, 0
$00BC	$00C1			MOVWF	STACK_1
$00BD	$0841			MOVF	STACK_1, 0
$00BE	$3A04			XORLW	4
$00BF	$1903			BTFSC	STATUS, Z
$00C0	$28CE			GOTO	L__Opearations_50
$00C1	$3008			MOVLW	8
$00C2	$0506			ANDWF	PORTB, 0
$00C3	$00C1			MOVWF	STACK_1
$00C4	$0841			MOVF	STACK_1, 0
$00C5	$3A08			XORLW	8
$00C6	$1D03			BTFSS	STATUS, Z
$00C7	$28CE			GOTO	L__Opearations_50
$00C8	$	L263_ex_L__Opearations_50:
;D-91_PIC16_color_changer_v-3.1.c,295 :: 		_output(5);
$00C8	$3005			MOVLW	5
$00C9	$0092			MOVWF	FARG__output+0
$00CA	$3000			MOVLW	0
$00CB	$0093			MOVWF	FARG__output+1
$00CC	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,297 :: 		} else if ((PORTB_1_H) && (PORTB_2_H) && (PORTB_3_H)) {	// 111 => 4 + 2 + 1 = 7
$00CD	$28EA			GOTO	L__Opearations_51
$00CE	$	L__Opearations_50:
$00CE	$3002			MOVLW	2
$00CF	$0506			ANDWF	PORTB, 0
$00D0	$00C1			MOVWF	STACK_1
$00D1	$0841			MOVF	STACK_1, 0
$00D2	$3A02			XORLW	2
$00D3	$1D03			BTFSS	STATUS, Z
$00D4	$28E9			GOTO	L__Opearations_54
$00D5	$3004			MOVLW	4
$00D6	$0506			ANDWF	PORTB, 0
$00D7	$00C1			MOVWF	STACK_1
$00D8	$0841			MOVF	STACK_1, 0
$00D9	$3A04			XORLW	4
$00DA	$1D03			BTFSS	STATUS, Z
$00DB	$28E9			GOTO	L__Opearations_54
$00DC	$3008			MOVLW	8
$00DD	$0506			ANDWF	PORTB, 0
$00DE	$00C1			MOVWF	STACK_1
$00DF	$0841			MOVF	STACK_1, 0
$00E0	$3A08			XORLW	8
$00E1	$1D03			BTFSS	STATUS, Z
$00E2	$28E9			GOTO	L__Opearations_54
$00E3	$	L283_ex_L__Opearations_54:
;D-91_PIC16_color_changer_v-3.1.c,299 :: 		_output(7);
$00E3	$3007			MOVLW	7
$00E4	$0092			MOVWF	FARG__output+0
$00E5	$3000			MOVLW	0
$00E6	$0093			MOVWF	FARG__output+1
$00E7	$218D			CALL	__output
;D-91_PIC16_color_changer_v-3.1.c,301 :: 		} else {
$00E8	$28EA			GOTO	L__Opearations_55
$00E9	$	L__Opearations_54:
;D-91_PIC16_color_changer_v-3.1.c,303 :: 		OUT_OFF;
$00E9	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,305 :: 		}
$00EA	$	L__Opearations_55:
$00EA	$	L__Opearations_51:
$00EA	$	L__Opearations_47:
$00EA	$	L__Opearations_43:
$00EA	$	L__Opearations_39:
$00EA	$	L__Opearations_35:
$00EA	$	L__Opearations_31:
;D-91_PIC16_color_changer_v-3.1.c,307 :: 		}//while(PORTB_0_H)
$00EA	$2823			GOTO	L__Opearations_26
$00EB	$	L__Opearations_27:
;D-91_PIC16_color_changer_v-3.1.c,323 :: 		}//_Opearations
$00EB	$0008			RETURN
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$0090			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$008F			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$0091			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$0840			MOVF	STACK_0, 0
$000E	$0096			MOVWF	STSAVED_0
;D-91_PIC16_color_changer_v-3.1.c,326 :: 		void interrupt(void)
;D-91_PIC16_color_changer_v-3.1.c,337 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-3.1.c,338 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-3.1.c,339 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-3.1.c,341 :: 		_Opearations();
$0015	$2023			CALL	__Opearations
;D-91_PIC16_color_changer_v-3.1.c,349 :: 		INTCON |= 0x10;		  // INT interrupt => permitted
$0016	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-3.1.c,350 :: 		INTCON |= 0x80;
$0017	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-3.1.c,352 :: 		}//void interrupt(void)
$0018	$	L_Interrupt_end:
$0018	$0816			MOVF	STSAVED_0, 0
$0019	$00C0			MOVWF	STACK_0
$001A	$0811			MOVF	?savePCLATH, 0
$001B	$008A			MOVWF	PCLATH
$001C	$080F			MOVF	?saveFSR, 0
$001D	$0084			MOVWF	FSR
$001E	$0E10			SWAPF	?saveSTATUS, 0
$001F	$0083			MOVWF	STATUS
$0020	$0ECF			SWAPF	STACK_15, 1
$0021	$0E4F			SWAPF	STACK_15, 0
$0022	$0009			RETFIE
$013F	$	_main:
;D-91_PIC16_color_changer_v-3.1.c,355 :: 		void main(void)
;D-91_PIC16_color_changer_v-3.1.c,359 :: 		TRISA     = 0x00;
$013F	$1303			BCF	STATUS, RP1
$0140	$1683			BSF	STATUS, RP0
$0141	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-3.1.c,360 :: 		PORTA     = 0x00;		//0000 0010
$0142	$1283			BCF	STATUS, RP0
$0143	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,362 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$0144	$30FF			MOVLW	255
$0145	$1683			BSF	STATUS, RP0
$0146	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-3.1.c,364 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$0147	$307F			MOVLW	127
$0148	$0501			ANDWF	OPTION_REG, 0
$0149	$00C0			MOVWF	STACK_0
$014A	$0840			MOVF	STACK_0, 0
$014B	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-3.1.c,365 :: 		OPTION_REG &= 0xFF;	// INT interrupt => by 0V ~> 5V
$014C	$30FF			MOVLW	255
$014D	$05C0			ANDWF	STACK_0, 1
$014E	$0840			MOVF	STACK_0, 0
$014F	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-3.1.c,368 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$0150	$30DF			MOVLW	223
$0151	$05C0			ANDWF	STACK_0, 1
$0152	$0840			MOVF	STACK_0, 0
$0153	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-3.1.c,369 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$0154	$30F0			MOVLW	240
$0155	$05C0			ANDWF	STACK_0, 1
$0156	$0840			MOVF	STACK_0, 0
$0157	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-3.1.c,370 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$0158	$3007			MOVLW	7
$0159	$0440			IORWF	STACK_0, 0
$015A	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-3.1.c,378 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$015B	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-3.1.c,379 :: 		INTCON |= 0x80;
$015C	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-3.1.c,381 :: 		while(1)
$015D	$	L_main_56:
;D-91_PIC16_color_changer_v-3.1.c,384 :: 		OUT_OFF;
$015D	$1283			BCF	STATUS, RP0
$015E	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-3.1.c,386 :: 		}//while(1)
$015F	$295D			GOTO	L_main_56
;D-91_PIC16_color_changer_v-3.1.c,388 :: 		}//void main(void)
$0160	$2960			GOTO	$
