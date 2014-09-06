;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/07/13 17:08:00
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$28CC			GOTO	_main
$0035	$	__pulse:
;D_85_16F84A_Remote_v_5_1.c,19 :: 		void _pulse(int num)
;D_85_16F84A_Remote_v_5_1.c,23 :: 		for(i = 0; i < num; i++)
$0035	$1303			BCF	STATUS, RP1
$0036	$1283			BCF	STATUS, RP0
$0037	$0196			CLRF	_pulse_i_L0
$0038	$0197			CLRF	_pulse_i_L0+1
$0039	$	L__pulse_0:
$0039	$3080			MOVLW	128
$003A	$0617			XORWF	_pulse_i_L0+1, 0
$003B	$00C0			MOVWF	STACK_0
$003C	$3080			MOVLW	128
$003D	$0615			XORWF	FARG__pulse+1, 0
$003E	$0240			SUBWF	STACK_0, 0
$003F	$1D03			BTFSS	STATUS, Z
$0040	$2843			GOTO	L__pulse_14
$0041	$0814			MOVF	FARG__pulse+0, 0
$0042	$0216			SUBWF	_pulse_i_L0, 0
$0043	$	L__pulse_14:
$0043	$1803			BTFSC	STATUS, C
$0044	$286C			GOTO	L__pulse_1
;D_85_16F84A_Remote_v_5_1.c,26 :: 		PORTA = 0x01; Delay_ms(1);
$0045	$3001			MOVLW	1
$0046	$0085			MOVWF	PORTA
$0047	$3007			MOVLW	7
$0048	$00CB			MOVWF	STACK_11
$0049	$30FF			MOVLW	255
$004A	$00CA			MOVWF	STACK_10
$004B	$0BCB			DECFSZ	STACK_11, F
$004C	$284E			GOTO	$+2
$004D	$2851			GOTO	$+4
$004E	$0BCA			DECFSZ	STACK_10, F
$004F	$284E			GOTO	$-1
$0050	$284B			GOTO	$-5
$0051	$3078			MOVLW	120
$0052	$00CA			MOVWF	STACK_10
$0053	$0BCA			DECFSZ	STACK_10, F
$0054	$2853			GOTO	$-1
$0055	$0000			NOP
$0056	$0000			NOP
;D_85_16F84A_Remote_v_5_1.c,28 :: 		PORTA = 0x00; Delay_ms(1);
$0057	$0185			CLRF	PORTA, 1
$0058	$3007			MOVLW	7
$0059	$00CB			MOVWF	STACK_11
$005A	$30FF			MOVLW	255
$005B	$00CA			MOVWF	STACK_10
$005C	$0BCB			DECFSZ	STACK_11, F
$005D	$285F			GOTO	$+2
$005E	$2862			GOTO	$+4
$005F	$0BCA			DECFSZ	STACK_10, F
$0060	$285F			GOTO	$-1
$0061	$285C			GOTO	$-5
$0062	$3078			MOVLW	120
$0063	$00CA			MOVWF	STACK_10
$0064	$0BCA			DECFSZ	STACK_10, F
$0065	$2864			GOTO	$-1
$0066	$0000			NOP
$0067	$0000			NOP
;D_85_16F84A_Remote_v_5_1.c,30 :: 		}
$0068	$	L__pulse_2:
;D_85_16F84A_Remote_v_5_1.c,23 :: 		for(i = 0; i < num; i++)
$0068	$0A96			INCF	_pulse_i_L0, 1
$0069	$1903			BTFSC	STATUS, Z
$006A	$0A97			INCF	_pulse_i_L0+1, 1
;D_85_16F84A_Remote_v_5_1.c,30 :: 		}
$006B	$2839			GOTO	L__pulse_0
$006C	$	L__pulse_1:
;D_85_16F84A_Remote_v_5_1.c,32 :: 		}
$006C	$0008			RETURN
$00EC	$	_Mul_8x8_U:
$00EC	$1303			BCF	STATUS, RP1
$00ED	$1283			BCF	STATUS, RP0
$00EE	$0840			MOVF	STACK_0, W
$00EF	$00C1			MOVWF	STACK_1
$00F0	$01C0			CLRF	STACK_0
$00F1	$3008			MOVLW	8
$00F2	$00CC			MOVWF	STACK_12
$00F3	$0841			MOVF	STACK_1, W
$00F4	$0CC4			RRF	STACK_4, F
$00F5	$1803			BTFSC	STATUS, C
$00F6	$28FB			GOTO	$+5
$00F7	$0BCC			DECFSZ	STACK_12, F
$00F8	$28F4			GOTO	$-4
$00F9	$01C1			CLRF	STACK_1, F
$00FA	$3400			RETLW	0
$00FB	$1003			BCF	STATUS, C
$00FC	$2900			GOTO	$+4
$00FD	$0CC4			RRF	STACK_4, F
$00FE	$1803			BTFSC	STATUS, C
$00FF	$07C1			ADDWF	STACK_1, F
$0100	$0CC1			RRF	STACK_1, F
$0101	$0CC0			RRF	STACK_0, F
$0102	$0BCC			DECFSZ	STACK_12, F
$0103	$28FD			GOTO	$-6
$0104	$0008			RETURN
$0105	$	__while_PORTB_0x01:
;D_85_16F84A_Remote_v_5_1.c,34 :: 		void _while_PORTB_0x01(int num)
;D_85_16F84A_Remote_v_5_1.c,37 :: 		while((PORTB & 0x01) == num) //---------------------
$0105	$	L__while_PORTB_0x01_3:
$0105	$3001			MOVLW	1
$0106	$1303			BCF	STATUS, RP1
$0107	$1283			BCF	STATUS, RP0
$0108	$0506			ANDWF	PORTB, 0
$0109	$00C1			MOVWF	STACK_1
$010A	$3000			MOVLW	0
$010B	$0611			XORWF	FARG__while_PORTB_0x01+1, 0
$010C	$1D03			BTFSS	STATUS, Z
$010D	$2910			GOTO	L__while_PORTB_0x01_15
$010E	$0810			MOVF	FARG__while_PORTB_0x01+0, 0
$010F	$0641			XORWF	STACK_1, 0
$0110	$	L__while_PORTB_0x01_15:
$0110	$1D03			BTFSS	STATUS, Z
$0111	$291D			GOTO	L__while_PORTB_0x01_4
;D_85_16F84A_Remote_v_5_1.c,40 :: 		if(TMR0 == 255)
$0112	$0801			MOVF	TMR0, 0
$0113	$3AFF			XORLW	255
$0114	$1D03			BTFSS	STATUS, Z
$0115	$291C			GOTO	L__while_PORTB_0x01_5
;D_85_16F84A_Remote_v_5_1.c,44 :: 		_pulse(3);
$0116	$3003			MOVLW	3
$0117	$0094			MOVWF	FARG__pulse+0
$0118	$3000			MOVLW	0
$0119	$0095			MOVWF	FARG__pulse+1
$011A	$2035			CALL	__pulse
;D_85_16F84A_Remote_v_5_1.c,47 :: 		return;
$011B	$0008			RETURN
;D_85_16F84A_Remote_v_5_1.c,49 :: 		}
$011C	$	L__while_PORTB_0x01_5:
;D_85_16F84A_Remote_v_5_1.c,51 :: 		}//while((PORTB & 0x01) == 0)
$011C	$2905			GOTO	L__while_PORTB_0x01_3
$011D	$	L__while_PORTB_0x01_4:
;D_85_16F84A_Remote_v_5_1.c,53 :: 		return;
;D_85_16F84A_Remote_v_5_1.c,55 :: 		}
$011D	$0008			RETURN
$006D	$	__judge_TMR_:
;D_85_16F84A_Remote_v_5_1.c,61 :: 		int _judge_TMR_(int low, int high) {
;D_85_16F84A_Remote_v_5_1.c,63 :: 		if(TMR0 < low) //---------------------
$006D	$3080			MOVLW	128
$006E	$1303			BCF	STATUS, RP1
$006F	$1283			BCF	STATUS, RP0
$0070	$00C0			MOVWF	STACK_0
$0071	$3080			MOVLW	128
$0072	$0611			XORWF	FARG__judge_TMR_+1, 0
$0073	$0240			SUBWF	STACK_0, 0
$0074	$1D03			BTFSS	STATUS, Z
$0075	$2878			GOTO	L__judge_TMR__16
$0076	$0810			MOVF	FARG__judge_TMR_+0, 0
$0077	$0201			SUBWF	TMR0, 0
$0078	$	L__judge_TMR__16:
$0078	$1803			BTFSC	STATUS, C
$0079	$2884			GOTO	L__judge_TMR__6
;D_85_16F84A_Remote_v_5_1.c,66 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$007A	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_1.c,67 :: 		INTCON |= 0x80;        // interrupt => permitted
$007B	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_1.c,74 :: 		_pulse(1);
$007C	$3001			MOVLW	1
$007D	$0094			MOVWF	FARG__pulse+0
$007E	$3000			MOVLW	0
$007F	$0095			MOVWF	FARG__pulse+1
$0080	$2035			CALL	__pulse
;D_85_16F84A_Remote_v_5_1.c,76 :: 		return false;                // return
$0081	$01C0			CLRF	STACK_0
$0082	$01C1			CLRF	STACK_0+1
$0083	$0008			RETURN
;D_85_16F84A_Remote_v_5_1.c,87 :: 		} else if (TMR0 > high) {
$0084	$	L__judge_TMR__6:
$0084	$3080			MOVLW	128
$0085	$0613			XORWF	FARG__judge_TMR_+3, 0
$0086	$00C0			MOVWF	STACK_0
$0087	$3080			MOVLW	128
$0088	$0240			SUBWF	STACK_0, 0
$0089	$1D03			BTFSS	STATUS, Z
$008A	$288D			GOTO	L__judge_TMR__17
$008B	$0801			MOVF	TMR0, 0
$008C	$0212			SUBWF	FARG__judge_TMR_+2, 0
$008D	$	L__judge_TMR__17:
$008D	$1803			BTFSC	STATUS, C
$008E	$2899			GOTO	L__judge_TMR__8
;D_85_16F84A_Remote_v_5_1.c,89 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$008F	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_1.c,90 :: 		INTCON |= 0x80;        // interrupt => permitted
$0090	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_1.c,93 :: 		_pulse(2);
$0091	$3002			MOVLW	2
$0092	$0094			MOVWF	FARG__pulse+0
$0093	$3000			MOVLW	0
$0094	$0095			MOVWF	FARG__pulse+1
$0095	$2035			CALL	__pulse
;D_85_16F84A_Remote_v_5_1.c,95 :: 		return false;
$0096	$01C0			CLRF	STACK_0
$0097	$01C1			CLRF	STACK_0+1
$0098	$0008			RETURN
;D_85_16F84A_Remote_v_5_1.c,97 :: 		}
$0099	$	L__judge_TMR__8:
$0099	$	L__judge_TMR__7:
;D_85_16F84A_Remote_v_5_1.c,99 :: 		return true;
$0099	$3001			MOVLW	1
$009A	$00C0			MOVWF	STACK_0
$009B	$3000			MOVLW	0
$009C	$00C1			MOVWF	STACK_0+1
;D_85_16F84A_Remote_v_5_1.c,101 :: 		}//int _judge_TMR_(int low, int high)
$009D	$0008			RETURN
$009E	$	__response:
;D_85_16F84A_Remote_v_5_1.c,103 :: 		void _response(void)
;D_85_16F84A_Remote_v_5_1.c,106 :: 		if(LED_FLAG == 1)
$009E	$1303			BCF	STATUS, RP1
$009F	$1283			BCF	STATUS, RP0
$00A0	$080C			MOVF	_LED_FLAG, 0
$00A1	$3A01			XORLW	1
$00A2	$1D03			BTFSS	STATUS, Z
$00A3	$28AE			GOTO	L__response_9
;D_85_16F84A_Remote_v_5_1.c,109 :: 		PORTA = 0x01;
$00A4	$3001			MOVLW	1
$00A5	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_5_1.c,111 :: 		LED_FLAG *= -1;
$00A6	$080C			MOVF	_LED_FLAG, 0
$00A7	$00C0			MOVWF	STACK_0
$00A8	$30FF			MOVLW	255
$00A9	$00C4			MOVWF	STACK_4
$00AA	$20EC			CALL	_mul_8x8_u
$00AB	$0840			MOVF	STACK_0, 0
$00AC	$008C			MOVWF	_LED_FLAG
;D_85_16F84A_Remote_v_5_1.c,113 :: 		} else {
$00AD	$28CB			GOTO	L__response_10
$00AE	$	L__response_9:
;D_85_16F84A_Remote_v_5_1.c,117 :: 		PORTA = 0x00;
$00AE	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_1.c,118 :: 		Delay_ms(1);
$00AF	$3007			MOVLW	7
$00B0	$00CB			MOVWF	STACK_11
$00B1	$30FF			MOVLW	255
$00B2	$00CA			MOVWF	STACK_10
$00B3	$0BCB			DECFSZ	STACK_11, F
$00B4	$28B6			GOTO	$+2
$00B5	$28B9			GOTO	$+4
$00B6	$0BCA			DECFSZ	STACK_10, F
$00B7	$28B6			GOTO	$-1
$00B8	$28B3			GOTO	$-5
$00B9	$3078			MOVLW	120
$00BA	$00CA			MOVWF	STACK_10
$00BB	$0BCA			DECFSZ	STACK_10, F
$00BC	$28BB			GOTO	$-1
$00BD	$0000			NOP
$00BE	$0000			NOP
;D_85_16F84A_Remote_v_5_1.c,119 :: 		_pulse(2);
$00BF	$3002			MOVLW	2
$00C0	$0094			MOVWF	FARG__pulse+0
$00C1	$3000			MOVLW	0
$00C2	$0095			MOVWF	FARG__pulse+1
$00C3	$2035			CALL	__pulse
;D_85_16F84A_Remote_v_5_1.c,121 :: 		LED_FLAG *= -1;
$00C4	$080C			MOVF	_LED_FLAG, 0
$00C5	$00C0			MOVWF	STACK_0
$00C6	$30FF			MOVLW	255
$00C7	$00C4			MOVWF	STACK_4
$00C8	$20EC			CALL	_mul_8x8_u
$00C9	$0840			MOVF	STACK_0, 0
$00CA	$008C			MOVWF	_LED_FLAG
;D_85_16F84A_Remote_v_5_1.c,123 :: 		}//if(LED_FLAG == 1)
$00CB	$	L__response_10:
;D_85_16F84A_Remote_v_5_1.c,125 :: 		}
$00CB	$0008			RETURN
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$008E			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$008D			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$008F			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$0840			MOVF	STACK_0, 0
$000E	$0098			MOVWF	STSAVED_0
;D_85_16F84A_Remote_v_5_1.c,127 :: 		void interrupt(void)
;D_85_16F84A_Remote_v_5_1.c,138 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_1.c,139 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_1.c,140 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_1.c,145 :: 		TMR0 = 0;
$0015	$0181			CLRF	TMR0, 1
;D_85_16F84A_Remote_v_5_1.c,152 :: 		_while_PORTB_0x01(0);
$0016	$0190			CLRF	FARG__while_PORTB_0x01+0
$0017	$0191			CLRF	FARG__while_PORTB_0x01+1
$0018	$2105			CALL	__while_PORTB_0x01
;D_85_16F84A_Remote_v_5_1.c,159 :: 		result = _judge_TMR_(156, 196);
$0019	$309C			MOVLW	156
$001A	$1303			BCF	STATUS, RP1
$001B	$1283			BCF	STATUS, RP0
$001C	$0090			MOVWF	FARG__judge_TMR_+0
$001D	$0191			CLRF	FARG__judge_TMR_+1
$001E	$30C4			MOVLW	196
$001F	$0092			MOVWF	FARG__judge_TMR_+2
$0020	$0193			CLRF	FARG__judge_TMR_+3
$0021	$206D			CALL	__judge_TMR_
;D_85_16F84A_Remote_v_5_1.c,161 :: 		if (result == false) {
$0022	$0840			MOVF	STACK_0, 0
$0023	$3A00			XORLW	0
$0024	$1D03			BTFSS	STATUS, Z
$0025	$2827			GOTO	L_interrupt_11
;D_85_16F84A_Remote_v_5_1.c,163 :: 		return;
$0026	$282A			GOTO	L_Interrupt_end
;D_85_16F84A_Remote_v_5_1.c,165 :: 		}
$0027	$	L_interrupt_11:
;D_85_16F84A_Remote_v_5_1.c,205 :: 		_response();
$0027	$209E			CALL	__response
;D_85_16F84A_Remote_v_5_1.c,292 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0028	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_1.c,293 :: 		INTCON |= 0x80;
$0029	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_1.c,295 :: 		}//void interrupt(void)
$002A	$	L_Interrupt_end:
$002A	$0818			MOVF	STSAVED_0, 0
$002B	$00C0			MOVWF	STACK_0
$002C	$080F			MOVF	?savePCLATH, 0
$002D	$008A			MOVWF	PCLATH
$002E	$080D			MOVF	?saveFSR, 0
$002F	$0084			MOVWF	FSR
$0030	$0E0E			SWAPF	?saveSTATUS, 0
$0031	$0083			MOVWF	STATUS
$0032	$0ECF			SWAPF	STACK_15, 1
$0033	$0E4F			SWAPF	STACK_15, 0
$0034	$0009			RETFIE
$011E	$	GlobalIniD_85_16F84A_Remote_v_5_1:
$011E	$3001			MOVLW	1
$011F	$1303			BCF	STATUS, RP1
$0120	$1283			BCF	STATUS, RP0
$0121	$008C			MOVWF	_LED_FLAG+0
$0122	$0008			RETURN
$00CC	$	_main:
;D_85_16F84A_Remote_v_5_1.c,298 :: 		void main(void)
;D_85_16F84A_Remote_v_5_1.c,302 :: 		TRISA     = 0x00;
$00CC	$211E			CALL	GlobalIniD_85_16F84A_Remote_v_5_1
$00CD	$1683			BSF	STATUS, RP0
$00CE	$0185			CLRF	TRISA, 1
;D_85_16F84A_Remote_v_5_1.c,303 :: 		PORTA     = 0x00;		//0000 0010
$00CF	$1283			BCF	STATUS, RP0
$00D0	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_1.c,305 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$00D1	$30FF			MOVLW	255
$00D2	$1683			BSF	STATUS, RP0
$00D3	$0086			MOVWF	TRISB
;D_85_16F84A_Remote_v_5_1.c,307 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$00D4	$307F			MOVLW	127
$00D5	$0501			ANDWF	OPTION_REG, 0
$00D6	$00C0			MOVWF	STACK_0
$00D7	$0840			MOVF	STACK_0, 0
$00D8	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_1.c,308 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$00D9	$30BF			MOVLW	191
$00DA	$05C0			ANDWF	STACK_0, 1
$00DB	$0840			MOVF	STACK_0, 0
$00DC	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_1.c,310 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$00DD	$30DF			MOVLW	223
$00DE	$05C0			ANDWF	STACK_0, 1
$00DF	$0840			MOVF	STACK_0, 0
$00E0	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_1.c,311 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$00E1	$30F0			MOVLW	240
$00E2	$05C0			ANDWF	STACK_0, 1
$00E3	$0840			MOVF	STACK_0, 0
$00E4	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_1.c,312 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$00E5	$3007			MOVLW	7
$00E6	$0440			IORWF	STACK_0, 0
$00E7	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_1.c,320 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00E8	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_1.c,321 :: 		INTCON |= 0x80;
$00E9	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_1.c,323 :: 		while(1)
$00EA	$	L_main_12:
$00EA	$28EA			GOTO	L_main_12
;D_85_16F84A_Remote_v_5_1.c,331 :: 		}//void main(void)
$00EB	$28EB			GOTO	$