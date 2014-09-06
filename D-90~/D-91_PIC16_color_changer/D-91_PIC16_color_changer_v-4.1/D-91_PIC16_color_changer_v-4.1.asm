;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/09/06 17:04:59
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2989			GOTO	_main
$0031	$	__pulse:
;D-91_PIC16_color_changer_v-4.1.c,58 :: 		void _pulse(int num)
;D-91_PIC16_color_changer_v-4.1.c,62 :: 		for(i = 0; i < num; i++)
$0031	$1303			BCF	STATUS, RP1
$0032	$1283			BCF	STATUS, RP0
$0033	$019C			CLRF	_pulse_i_L0
$0034	$019D			CLRF	_pulse_i_L0+1
$0035	$	L__pulse_0:
$0035	$3080			MOVLW	128
$0036	$061D			XORWF	_pulse_i_L0+1, 0
$0037	$00C0			MOVWF	STACK_0
$0038	$3080			MOVLW	128
$0039	$061B			XORWF	FARG__pulse+1, 0
$003A	$0240			SUBWF	STACK_0, 0
$003B	$1D03			BTFSS	STATUS, Z
$003C	$283F			GOTO	L__pulse_39
$003D	$081A			MOVF	FARG__pulse+0, 0
$003E	$021C			SUBWF	_pulse_i_L0, 0
$003F	$	L__pulse_39:
$003F	$1803			BTFSC	STATUS, C
$0040	$2868			GOTO	L__pulse_1
;D-91_PIC16_color_changer_v-4.1.c,65 :: 		PORTA = 0x01; Delay_ms(1);
$0041	$3001			MOVLW	1
$0042	$0085			MOVWF	PORTA
$0043	$3007			MOVLW	7
$0044	$00CB			MOVWF	STACK_11
$0045	$30FF			MOVLW	255
$0046	$00CA			MOVWF	STACK_10
$0047	$0BCB			DECFSZ	STACK_11, F
$0048	$284A			GOTO	$+2
$0049	$284D			GOTO	$+4
$004A	$0BCA			DECFSZ	STACK_10, F
$004B	$284A			GOTO	$-1
$004C	$2847			GOTO	$-5
$004D	$3078			MOVLW	120
$004E	$00CA			MOVWF	STACK_10
$004F	$0BCA			DECFSZ	STACK_10, F
$0050	$284F			GOTO	$-1
$0051	$0000			NOP
$0052	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,67 :: 		PORTA = 0x00; Delay_ms(1);
$0053	$0185			CLRF	PORTA, 1
$0054	$3007			MOVLW	7
$0055	$00CB			MOVWF	STACK_11
$0056	$30FF			MOVLW	255
$0057	$00CA			MOVWF	STACK_10
$0058	$0BCB			DECFSZ	STACK_11, F
$0059	$285B			GOTO	$+2
$005A	$285E			GOTO	$+4
$005B	$0BCA			DECFSZ	STACK_10, F
$005C	$285B			GOTO	$-1
$005D	$2858			GOTO	$-5
$005E	$3078			MOVLW	120
$005F	$00CA			MOVWF	STACK_10
$0060	$0BCA			DECFSZ	STACK_10, F
$0061	$2860			GOTO	$-1
$0062	$0000			NOP
$0063	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,69 :: 		}
$0064	$	L__pulse_2:
;D-91_PIC16_color_changer_v-4.1.c,62 :: 		for(i = 0; i < num; i++)
$0064	$0A9C			INCF	_pulse_i_L0, 1
$0065	$1903			BTFSC	STATUS, Z
$0066	$0A9D			INCF	_pulse_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,69 :: 		}
$0067	$2835			GOTO	L__pulse_0
$0068	$	L__pulse_1:
;D-91_PIC16_color_changer_v-4.1.c,71 :: 		}
$0068	$0008			RETURN
$0129	$	__pulse_u_50:
;D-91_PIC16_color_changer_v-4.1.c,125 :: 		_pulse_u_50(int num)
;D-91_PIC16_color_changer_v-4.1.c,129 :: 		for(i = 0; i < num; i++)
$0129	$1303			BCF	STATUS, RP1
$012A	$1283			BCF	STATUS, RP0
$012B	$019C			CLRF	_pulse_u_50_i_L0
$012C	$019D			CLRF	_pulse_u_50_i_L0+1
$012D	$	L__pulse_u_50_12:
$012D	$3080			MOVLW	128
$012E	$061D			XORWF	_pulse_u_50_i_L0+1, 0
$012F	$00C0			MOVWF	STACK_0
$0130	$3080			MOVLW	128
$0131	$061B			XORWF	FARG__pulse_u_50+1, 0
$0132	$0240			SUBWF	STACK_0, 0
$0133	$1D03			BTFSS	STATUS, Z
$0134	$2937			GOTO	L__pulse_u_50_43
$0135	$081A			MOVF	FARG__pulse_u_50+0, 0
$0136	$021C			SUBWF	_pulse_u_50_i_L0, 0
$0137	$	L__pulse_u_50_43:
$0137	$1803			BTFSC	STATUS, C
$0138	$2948			GOTO	L__pulse_u_50_13
;D-91_PIC16_color_changer_v-4.1.c,132 :: 		PORTA = 0x01; Delay_us(50);
$0139	$3001			MOVLW	1
$013A	$0085			MOVWF	PORTA
$013B	$3053			MOVLW	83
$013C	$00CA			MOVWF	STACK_10
$013D	$0BCA			DECFSZ	STACK_10, F
$013E	$293D			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,134 :: 		PORTA = 0x00; Delay_us(50);
$013F	$0185			CLRF	PORTA, 1
$0140	$3053			MOVLW	83
$0141	$00CA			MOVWF	STACK_10
$0142	$0BCA			DECFSZ	STACK_10, F
$0143	$2942			GOTO	$-1
;D-91_PIC16_color_changer_v-4.1.c,136 :: 		}
$0144	$	L__pulse_u_50_14:
;D-91_PIC16_color_changer_v-4.1.c,129 :: 		for(i = 0; i < num; i++)
$0144	$0A9C			INCF	_pulse_u_50_i_L0, 1
$0145	$1903			BTFSC	STATUS, Z
$0146	$0A9D			INCF	_pulse_u_50_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,136 :: 		}
$0147	$292D			GOTO	L__pulse_u_50_12
$0148	$	L__pulse_u_50_13:
;D-91_PIC16_color_changer_v-4.1.c,138 :: 		}//_pulse_u_50
$0148	$0008			RETURN
$0168	$	__while_PORTB_0x01:
;D-91_PIC16_color_changer_v-4.1.c,140 :: 		void _while_PORTB_0x01(int num)
;D-91_PIC16_color_changer_v-4.1.c,143 :: 		while((PORTB & 0x01) == num) //---------------------
$0168	$	L__while_PORTB_0x01_15:
$0168	$3001			MOVLW	1
$0169	$1303			BCF	STATUS, RP1
$016A	$1283			BCF	STATUS, RP0
$016B	$0506			ANDWF	PORTB, 0
$016C	$00C1			MOVWF	STACK_1
$016D	$3000			MOVLW	0
$016E	$0617			XORWF	FARG__while_PORTB_0x01+1, 0
$016F	$1D03			BTFSS	STATUS, Z
$0170	$2973			GOTO	L__while_PORTB_0x01_44
$0171	$0816			MOVF	FARG__while_PORTB_0x01+0, 0
$0172	$0641			XORWF	STACK_1, 0
$0173	$	L__while_PORTB_0x01_44:
$0173	$1D03			BTFSS	STATUS, Z
$0174	$2980			GOTO	L__while_PORTB_0x01_16
;D-91_PIC16_color_changer_v-4.1.c,146 :: 		if(TMR0 == 255)
$0175	$0801			MOVF	TMR0, 0
$0176	$3AFF			XORLW	255
$0177	$1D03			BTFSS	STATUS, Z
$0178	$297F			GOTO	L__while_PORTB_0x01_17
;D-91_PIC16_color_changer_v-4.1.c,150 :: 		_pulse(3);
$0179	$3003			MOVLW	3
$017A	$009A			MOVWF	FARG__pulse+0
$017B	$3000			MOVLW	0
$017C	$009B			MOVWF	FARG__pulse+1
$017D	$2031			CALL	__pulse
;D-91_PIC16_color_changer_v-4.1.c,153 :: 		return;
$017E	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,155 :: 		}
$017F	$	L__while_PORTB_0x01_17:
;D-91_PIC16_color_changer_v-4.1.c,157 :: 		}//while((PORTB & 0x01) == 0)
$017F	$2968			GOTO	L__while_PORTB_0x01_15
$0180	$	L__while_PORTB_0x01_16:
;D-91_PIC16_color_changer_v-4.1.c,159 :: 		return;
;D-91_PIC16_color_changer_v-4.1.c,161 :: 		}
$0180	$0008			RETURN
$00D6	$	__judge_TMR_:
;D-91_PIC16_color_changer_v-4.1.c,167 :: 		int _judge_TMR_(int low, int high) {
;D-91_PIC16_color_changer_v-4.1.c,169 :: 		if(TMR0 < low) //---------------------
$00D6	$3080			MOVLW	128
$00D7	$1303			BCF	STATUS, RP1
$00D8	$1283			BCF	STATUS, RP0
$00D9	$00C0			MOVWF	STACK_0
$00DA	$3080			MOVLW	128
$00DB	$0617			XORWF	FARG__judge_TMR_+1, 0
$00DC	$0240			SUBWF	STACK_0, 0
$00DD	$1D03			BTFSS	STATUS, Z
$00DE	$28E1			GOTO	L__judge_TMR__45
$00DF	$0816			MOVF	FARG__judge_TMR_+0, 0
$00E0	$0201			SUBWF	TMR0, 0
$00E1	$	L__judge_TMR__45:
$00E1	$1803			BTFSC	STATUS, C
$00E2	$28ED			GOTO	L__judge_TMR__18
;D-91_PIC16_color_changer_v-4.1.c,172 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00E3	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,173 :: 		INTCON |= 0x80;        // interrupt => permitted
$00E4	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,180 :: 		_pulse_u_50(3);
$00E5	$3003			MOVLW	3
$00E6	$009A			MOVWF	FARG__pulse_u_50+0
$00E7	$3000			MOVLW	0
$00E8	$009B			MOVWF	FARG__pulse_u_50+1
$00E9	$2129			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,182 :: 		return false;                // return
$00EA	$01C0			CLRF	STACK_0
$00EB	$01C1			CLRF	STACK_0+1
$00EC	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,193 :: 		} else if (TMR0 > high) {
$00ED	$	L__judge_TMR__18:
$00ED	$3080			MOVLW	128
$00EE	$0619			XORWF	FARG__judge_TMR_+3, 0
$00EF	$00C0			MOVWF	STACK_0
$00F0	$3080			MOVLW	128
$00F1	$0240			SUBWF	STACK_0, 0
$00F2	$1D03			BTFSS	STATUS, Z
$00F3	$28F6			GOTO	L__judge_TMR__46
$00F4	$0801			MOVF	TMR0, 0
$00F5	$0218			SUBWF	FARG__judge_TMR_+2, 0
$00F6	$	L__judge_TMR__46:
$00F6	$1803			BTFSC	STATUS, C
$00F7	$2902			GOTO	L__judge_TMR__20
;D-91_PIC16_color_changer_v-4.1.c,195 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00F8	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,196 :: 		INTCON |= 0x80;        // interrupt => permitted
$00F9	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,199 :: 		_pulse_u_50(2);
$00FA	$3002			MOVLW	2
$00FB	$009A			MOVWF	FARG__pulse_u_50+0
$00FC	$3000			MOVLW	0
$00FD	$009B			MOVWF	FARG__pulse_u_50+1
$00FE	$2129			CALL	__pulse_u_50
;D-91_PIC16_color_changer_v-4.1.c,202 :: 		return false;
$00FF	$01C0			CLRF	STACK_0
$0100	$01C1			CLRF	STACK_0+1
$0101	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,204 :: 		}
$0102	$	L__judge_TMR__20:
$0102	$	L__judge_TMR__19:
;D-91_PIC16_color_changer_v-4.1.c,206 :: 		return true;
$0102	$3001			MOVLW	1
$0103	$00C0			MOVWF	STACK_0
$0104	$3000			MOVLW	0
$0105	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,208 :: 		}//int _judge_TMR_(int low, int high)
$0106	$0008			RETURN
$0107	$	__pulse_u_100:
;D-91_PIC16_color_changer_v-4.1.c,109 :: 		void _pulse_u_100(int num)
;D-91_PIC16_color_changer_v-4.1.c,113 :: 		for(i = 0; i < num; i++)
$0107	$1303			BCF	STATUS, RP1
$0108	$1283			BCF	STATUS, RP0
$0109	$0198			CLRF	_pulse_u_100_i_L0
$010A	$0199			CLRF	_pulse_u_100_i_L0+1
$010B	$	L__pulse_u_100_9:
$010B	$3080			MOVLW	128
$010C	$0619			XORWF	_pulse_u_100_i_L0+1, 0
$010D	$00C0			MOVWF	STACK_0
$010E	$3080			MOVLW	128
$010F	$0617			XORWF	FARG__pulse_u_100+1, 0
$0110	$0240			SUBWF	STACK_0, 0
$0111	$1D03			BTFSS	STATUS, Z
$0112	$2915			GOTO	L__pulse_u_100_42
$0113	$0816			MOVF	FARG__pulse_u_100+0, 0
$0114	$0218			SUBWF	_pulse_u_100_i_L0, 0
$0115	$	L__pulse_u_100_42:
$0115	$1803			BTFSC	STATUS, C
$0116	$2928			GOTO	L__pulse_u_100_10
;D-91_PIC16_color_changer_v-4.1.c,116 :: 		PORTA = 0x01; Delay_us(100);
$0117	$3001			MOVLW	1
$0118	$0085			MOVWF	PORTA
$0119	$30A6			MOVLW	166
$011A	$00CA			MOVWF	STACK_10
$011B	$0BCA			DECFSZ	STACK_10, F
$011C	$291B			GOTO	$-1
$011D	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,118 :: 		PORTA = 0x00; Delay_us(100);
$011E	$0185			CLRF	PORTA, 1
$011F	$30A6			MOVLW	166
$0120	$00CA			MOVWF	STACK_10
$0121	$0BCA			DECFSZ	STACK_10, F
$0122	$2921			GOTO	$-1
$0123	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,120 :: 		}
$0124	$	L__pulse_u_100_11:
;D-91_PIC16_color_changer_v-4.1.c,113 :: 		for(i = 0; i < num; i++)
$0124	$0A98			INCF	_pulse_u_100_i_L0, 1
$0125	$1903			BTFSC	STATUS, Z
$0126	$0A99			INCF	_pulse_u_100_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,120 :: 		}
$0127	$290B			GOTO	L__pulse_u_100_9
$0128	$	L__pulse_u_100_10:
;D-91_PIC16_color_changer_v-4.1.c,122 :: 		}
$0128	$0008			RETURN
$0069	$	__read_Reader:
;D-91_PIC16_color_changer_v-4.1.c,417 :: 		_read_Reader() {
;D-91_PIC16_color_changer_v-4.1.c,424 :: 		RESET_TMR;
$0069	$1303			BCF	STATUS, RP1
$006A	$1283			BCF	STATUS, RP0
$006B	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,434 :: 		_while_PORTB_0x01(0);
$006C	$0196			CLRF	FARG__while_PORTB_0x01+0
$006D	$0197			CLRF	FARG__while_PORTB_0x01+1
$006E	$2168			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,445 :: 		result = _judge_TMR_(156, 196);
$006F	$309C			MOVLW	156
$0070	$1303			BCF	STATUS, RP1
$0071	$1283			BCF	STATUS, RP0
$0072	$0096			MOVWF	FARG__judge_TMR_+0
$0073	$0197			CLRF	FARG__judge_TMR_+1
$0074	$30C4			MOVLW	196
$0075	$0098			MOVWF	FARG__judge_TMR_+2
$0076	$0199			CLRF	FARG__judge_TMR_+3
$0077	$20D6			CALL	__judge_TMR_
$0078	$0840			MOVF	STACK_0, 0
$0079	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,447 :: 		if (result == false) {
$007A	$0840			MOVF	STACK_0, 0
$007B	$3A00			XORLW	0
$007C	$1D03			BTFSS	STATUS, Z
$007D	$2881			GOTO	L__read_Reader_35
;D-91_PIC16_color_changer_v-4.1.c,451 :: 		return false;
$007E	$01C0			CLRF	STACK_0
$007F	$01C1			CLRF	STACK_0+1
$0080	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,453 :: 		}
$0081	$	L__read_Reader_35:
;D-91_PIC16_color_changer_v-4.1.c,465 :: 		RESET_TMR;
$0081	$0181			CLRF	TMR0, 1
;D-91_PIC16_color_changer_v-4.1.c,472 :: 		_while_PORTB_0x01(1);
$0082	$3001			MOVLW	1
$0083	$0096			MOVWF	FARG__while_PORTB_0x01+0
$0084	$3000			MOVLW	0
$0085	$0097			MOVWF	FARG__while_PORTB_0x01+1
$0086	$2168			CALL	__while_PORTB_0x01
;D-91_PIC16_color_changer_v-4.1.c,479 :: 		result = _judge_TMR_(68, 108);
$0087	$3044			MOVLW	68
$0088	$1303			BCF	STATUS, RP1
$0089	$1283			BCF	STATUS, RP0
$008A	$0096			MOVWF	FARG__judge_TMR_+0
$008B	$3000			MOVLW	0
$008C	$0097			MOVWF	FARG__judge_TMR_+1
$008D	$306C			MOVLW	108
$008E	$0098			MOVWF	FARG__judge_TMR_+2
$008F	$3000			MOVLW	0
$0090	$0099			MOVWF	FARG__judge_TMR_+3
$0091	$20D6			CALL	__judge_TMR_
$0092	$0840			MOVF	STACK_0, 0
$0093	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,481 :: 		if (result == false) {
$0094	$0840			MOVF	STACK_0, 0
$0095	$3A00			XORLW	0
$0096	$1D03			BTFSS	STATUS, Z
$0097	$289B			GOTO	L__read_Reader_36
;D-91_PIC16_color_changer_v-4.1.c,485 :: 		return false;
$0098	$01C0			CLRF	STACK_0
$0099	$01C1			CLRF	STACK_0+1
$009A	$0008			RETURN
;D-91_PIC16_color_changer_v-4.1.c,487 :: 		}
$009B	$	L__read_Reader_36:
;D-91_PIC16_color_changer_v-4.1.c,494 :: 		return true;
$009B	$3001			MOVLW	1
$009C	$00C0			MOVWF	STACK_0
$009D	$3000			MOVLW	0
$009E	$00C1			MOVWF	STACK_0+1
;D-91_PIC16_color_changer_v-4.1.c,496 :: 		}//_read_Reader
$009F	$0008			RETURN
$00A0	$	__pulse_500u:
;D-91_PIC16_color_changer_v-4.1.c,73 :: 		void _pulse_500u(int num)
;D-91_PIC16_color_changer_v-4.1.c,77 :: 		for(i = 0; i < num; i++)
$00A0	$1303			BCF	STATUS, RP1
$00A1	$1283			BCF	STATUS, RP0
$00A2	$0194			CLRF	_pulse_500u_i_L0
$00A3	$0195			CLRF	_pulse_500u_i_L0+1
$00A4	$	L__pulse_500u_3:
$00A4	$3080			MOVLW	128
$00A5	$0615			XORWF	_pulse_500u_i_L0+1, 0
$00A6	$00C0			MOVWF	STACK_0
$00A7	$3080			MOVLW	128
$00A8	$0613			XORWF	FARG__pulse_500u+1, 0
$00A9	$0240			SUBWF	STACK_0, 0
$00AA	$1D03			BTFSS	STATUS, Z
$00AB	$28AE			GOTO	L__pulse_500u_40
$00AC	$0812			MOVF	FARG__pulse_500u+0, 0
$00AD	$0214			SUBWF	_pulse_500u_i_L0, 0
$00AE	$	L__pulse_500u_40:
$00AE	$1803			BTFSC	STATUS, C
$00AF	$28D5			GOTO	L__pulse_500u_4
;D-91_PIC16_color_changer_v-4.1.c,80 :: 		PORTA = 0x01; Delay_us(500);
$00B0	$3001			MOVLW	1
$00B1	$0085			MOVWF	PORTA
$00B2	$3004			MOVLW	4
$00B3	$00CB			MOVWF	STACK_11
$00B4	$30FF			MOVLW	255
$00B5	$00CA			MOVWF	STACK_10
$00B6	$0BCB			DECFSZ	STACK_11, F
$00B7	$28B9			GOTO	$+2
$00B8	$28BC			GOTO	$+4
$00B9	$0BCA			DECFSZ	STACK_10, F
$00BA	$28B9			GOTO	$-1
$00BB	$28B6			GOTO	$-5
$00BC	$303B			MOVLW	59
$00BD	$00CA			MOVWF	STACK_10
$00BE	$0BCA			DECFSZ	STACK_10, F
$00BF	$28BE			GOTO	$-1
$00C0	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,82 :: 		PORTA = 0x00; Delay_us(500);
$00C1	$0185			CLRF	PORTA, 1
$00C2	$3004			MOVLW	4
$00C3	$00CB			MOVWF	STACK_11
$00C4	$30FF			MOVLW	255
$00C5	$00CA			MOVWF	STACK_10
$00C6	$0BCB			DECFSZ	STACK_11, F
$00C7	$28C9			GOTO	$+2
$00C8	$28CC			GOTO	$+4
$00C9	$0BCA			DECFSZ	STACK_10, F
$00CA	$28C9			GOTO	$-1
$00CB	$28C6			GOTO	$-5
$00CC	$303B			MOVLW	59
$00CD	$00CA			MOVWF	STACK_10
$00CE	$0BCA			DECFSZ	STACK_10, F
$00CF	$28CE			GOTO	$-1
$00D0	$0000			NOP
;D-91_PIC16_color_changer_v-4.1.c,84 :: 		}
$00D1	$	L__pulse_500u_5:
;D-91_PIC16_color_changer_v-4.1.c,77 :: 		for(i = 0; i < num; i++)
$00D1	$0A94			INCF	_pulse_500u_i_L0, 1
$00D2	$1903			BTFSC	STATUS, Z
$00D3	$0A95			INCF	_pulse_500u_i_L0+1, 1
;D-91_PIC16_color_changer_v-4.1.c,84 :: 		}
$00D4	$28A4			GOTO	L__pulse_500u_3
$00D5	$	L__pulse_500u_4:
;D-91_PIC16_color_changer_v-4.1.c,86 :: 		}
$00D5	$0008			RETURN
$0181	$	__response:
;D-91_PIC16_color_changer_v-4.1.c,210 :: 		void _response(void)
;D-91_PIC16_color_changer_v-4.1.c,213 :: 		_pulse_u_100(5);
$0181	$3005			MOVLW	5
$0182	$1303			BCF	STATUS, RP1
$0183	$1283			BCF	STATUS, RP0
$0184	$0096			MOVWF	FARG__pulse_u_100+0
$0185	$3000			MOVLW	0
$0186	$0097			MOVWF	FARG__pulse_u_100+1
$0187	$2107			CALL	__pulse_u_100
;D-91_PIC16_color_changer_v-4.1.c,257 :: 		}
$0188	$0008			RETURN
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
$000E	$009E			MOVWF	STSAVED_0
;D-91_PIC16_color_changer_v-4.1.c,310 :: 		void interrupt(void)
;D-91_PIC16_color_changer_v-4.1.c,321 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,322 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,323 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D-91_PIC16_color_changer_v-4.1.c,330 :: 		PORTA = 0x00;
$0015	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,337 :: 		result = _read_Reader();
$0016	$2069			CALL	__read_Reader
$0017	$0840			MOVF	STACK_0, 0
$0018	$008C			MOVWF	_result
;D-91_PIC16_color_changer_v-4.1.c,344 :: 		if (result == false) {
$0019	$0840			MOVF	STACK_0, 0
$001A	$3A00			XORLW	0
$001B	$1D03			BTFSS	STATUS, Z
$001C	$2823			GOTO	L_interrupt_32
;D-91_PIC16_color_changer_v-4.1.c,346 :: 		_pulse_500u(3);
$001D	$3003			MOVLW	3
$001E	$0092			MOVWF	FARG__pulse_500u+0
$001F	$3000			MOVLW	0
$0020	$0093			MOVWF	FARG__pulse_500u+1
$0021	$20A0			CALL	__pulse_500u
;D-91_PIC16_color_changer_v-4.1.c,348 :: 		return;
$0022	$2826			GOTO	L_Interrupt_end
;D-91_PIC16_color_changer_v-4.1.c,350 :: 		}
$0023	$	L_interrupt_32:
;D-91_PIC16_color_changer_v-4.1.c,364 :: 		_response();
$0023	$2181			CALL	__response
;D-91_PIC16_color_changer_v-4.1.c,372 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0024	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,373 :: 		INTCON |= 0x80;
$0025	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,375 :: 		}//void interrupt(void)
$0026	$	L_Interrupt_end:
$0026	$081E			MOVF	STSAVED_0, 0
$0027	$00C0			MOVWF	STACK_0
$0028	$0811			MOVF	?savePCLATH, 0
$0029	$008A			MOVWF	PCLATH
$002A	$080F			MOVF	?saveFSR, 0
$002B	$0084			MOVWF	FSR
$002C	$0E10			SWAPF	?saveSTATUS, 0
$002D	$0083			MOVWF	STATUS
$002E	$0ECF			SWAPF	STACK_15, 1
$002F	$0E4F			SWAPF	STACK_15, 0
$0030	$0009			RETFIE
$0149	$	__main_Setup:
;D-91_PIC16_color_changer_v-4.1.c,581 :: 		_main_Setup() {
;D-91_PIC16_color_changer_v-4.1.c,584 :: 		TRISA     = 0x00;
$0149	$1303			BCF	STATUS, RP1
$014A	$1683			BSF	STATUS, RP0
$014B	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-4.1.c,585 :: 		PORTA     = 0x00;		//0000 0010
$014C	$1283			BCF	STATUS, RP0
$014D	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-4.1.c,587 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$014E	$30FF			MOVLW	255
$014F	$1683			BSF	STATUS, RP0
$0150	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-4.1.c,589 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$0151	$307F			MOVLW	127
$0152	$0501			ANDWF	OPTION_REG, 0
$0153	$00C0			MOVWF	STACK_0
$0154	$0840			MOVF	STACK_0, 0
$0155	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,591 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$0156	$30BF			MOVLW	191
$0157	$05C0			ANDWF	STACK_0, 1
$0158	$0840			MOVF	STACK_0, 0
$0159	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,593 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$015A	$30DF			MOVLW	223
$015B	$05C0			ANDWF	STACK_0, 1
$015C	$0840			MOVF	STACK_0, 0
$015D	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,594 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$015E	$30F0			MOVLW	240
$015F	$05C0			ANDWF	STACK_0, 1
$0160	$0840			MOVF	STACK_0, 0
$0161	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,595 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$0162	$3007			MOVLW	7
$0163	$0440			IORWF	STACK_0, 0
$0164	$0081			MOVWF	OPTION_REG
;D-91_PIC16_color_changer_v-4.1.c,602 :: 		bit_len = 4;
$0165	$3004			MOVLW	4
$0166	$008D			MOVWF	_bit_len
;D-91_PIC16_color_changer_v-4.1.c,604 :: 		}//_main_Setup
$0167	$0008			RETURN
$018E	$	GlobalIniD-91_PIC16_color_changer_v-4:
$018E	$3001			MOVLW	1
$018F	$1303			BCF	STATUS, RP1
$0190	$1283			BCF	STATUS, RP0
$0191	$008E			MOVWF	_LED_FLAG+0
$0192	$0008			RETURN
$0189	$	_main:
;D-91_PIC16_color_changer_v-4.1.c,378 :: 		void main(void)
;D-91_PIC16_color_changer_v-4.1.c,381 :: 		_main_Setup();
$0189	$2149			CALL	__main_Setup
;D-91_PIC16_color_changer_v-4.1.c,403 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$018A	$160B			BSF	INTCON, 4
;D-91_PIC16_color_changer_v-4.1.c,404 :: 		INTCON |= 0x80;
$018B	$178B			BSF	INTCON, 7
;D-91_PIC16_color_changer_v-4.1.c,406 :: 		while(1)
$018C	$	L_main_33:
$018C	$298C			GOTO	L_main_33
;D-91_PIC16_color_changer_v-4.1.c,414 :: 		}//void main(void)
$018D	$298D			GOTO	$
