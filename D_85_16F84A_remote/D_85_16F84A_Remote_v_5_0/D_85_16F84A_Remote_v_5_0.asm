;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/07/09 13:27:18
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$28A8			GOTO	_main
$0070	$	__pulse:
;D_85_16F84A_Remote_v_5_0.c,15 :: 		void _pulse(int num)
;D_85_16F84A_Remote_v_5_0.c,19 :: 		for(i = 0; i < num; i++) {
$0070	$1303			BCF	STATUS, RP1
$0071	$1283			BCF	STATUS, RP0
$0072	$0192			CLRF	_pulse_i_L0
$0073	$0193			CLRF	_pulse_i_L0+1
$0074	$	L__pulse_0:
$0074	$3080			MOVLW	128
$0075	$0613			XORWF	_pulse_i_L0+1, 0
$0076	$00C0			MOVWF	STACK_0
$0077	$3080			MOVLW	128
$0078	$0611			XORWF	FARG__pulse+1, 0
$0079	$0240			SUBWF	STACK_0, 0
$007A	$1D03			BTFSS	STATUS, Z
$007B	$287E			GOTO	L__pulse_13
$007C	$0810			MOVF	FARG__pulse+0, 0
$007D	$0212			SUBWF	_pulse_i_L0, 0
$007E	$	L__pulse_13:
$007E	$1803			BTFSC	STATUS, C
$007F	$28A7			GOTO	L__pulse_1
;D_85_16F84A_Remote_v_5_0.c,21 :: 		PORTA = 0x01; Delay_ms(1);
$0080	$3001			MOVLW	1
$0081	$0085			MOVWF	PORTA
$0082	$3007			MOVLW	7
$0083	$00CB			MOVWF	STACK_11
$0084	$30FF			MOVLW	255
$0085	$00CA			MOVWF	STACK_10
$0086	$0BCB			DECFSZ	STACK_11, F
$0087	$2889			GOTO	$+2
$0088	$288C			GOTO	$+4
$0089	$0BCA			DECFSZ	STACK_10, F
$008A	$2889			GOTO	$-1
$008B	$2886			GOTO	$-5
$008C	$3078			MOVLW	120
$008D	$00CA			MOVWF	STACK_10
$008E	$0BCA			DECFSZ	STACK_10, F
$008F	$288E			GOTO	$-1
$0090	$0000			NOP
$0091	$0000			NOP
;D_85_16F84A_Remote_v_5_0.c,23 :: 		PORTA = 0x00; Delay_ms(1);
$0092	$0185			CLRF	PORTA, 1
$0093	$3007			MOVLW	7
$0094	$00CB			MOVWF	STACK_11
$0095	$30FF			MOVLW	255
$0096	$00CA			MOVWF	STACK_10
$0097	$0BCB			DECFSZ	STACK_11, F
$0098	$289A			GOTO	$+2
$0099	$289D			GOTO	$+4
$009A	$0BCA			DECFSZ	STACK_10, F
$009B	$289A			GOTO	$-1
$009C	$2897			GOTO	$-5
$009D	$3078			MOVLW	120
$009E	$00CA			MOVWF	STACK_10
$009F	$0BCA			DECFSZ	STACK_10, F
$00A0	$289F			GOTO	$-1
$00A1	$0000			NOP
$00A2	$0000			NOP
;D_85_16F84A_Remote_v_5_0.c,25 :: 		}
$00A3	$	L__pulse_2:
;D_85_16F84A_Remote_v_5_0.c,19 :: 		for(i = 0; i < num; i++) {
$00A3	$0A92			INCF	_pulse_i_L0, 1
$00A4	$1903			BTFSC	STATUS, Z
$00A5	$0A93			INCF	_pulse_i_L0+1, 1
;D_85_16F84A_Remote_v_5_0.c,25 :: 		}
$00A6	$2874			GOTO	L__pulse_0
$00A7	$	L__pulse_1:
;D_85_16F84A_Remote_v_5_0.c,27 :: 		}
$00A7	$0008			RETURN
$00C8	$	_Mul_8x8_U:
$00C8	$1303			BCF	STATUS, RP1
$00C9	$1283			BCF	STATUS, RP0
$00CA	$0840			MOVF	STACK_0, W
$00CB	$00C1			MOVWF	STACK_1
$00CC	$01C0			CLRF	STACK_0
$00CD	$3008			MOVLW	8
$00CE	$00CC			MOVWF	STACK_12
$00CF	$0841			MOVF	STACK_1, W
$00D0	$0CC4			RRF	STACK_4, F
$00D1	$1803			BTFSC	STATUS, C
$00D2	$28D7			GOTO	$+5
$00D3	$0BCC			DECFSZ	STACK_12, F
$00D4	$28D0			GOTO	$-4
$00D5	$01C1			CLRF	STACK_1, F
$00D6	$3400			RETLW	0
$00D7	$1003			BCF	STATUS, C
$00D8	$28DC			GOTO	$+4
$00D9	$0CC4			RRF	STACK_4, F
$00DA	$1803			BTFSC	STATUS, C
$00DB	$07C1			ADDWF	STACK_1, F
$00DC	$0CC1			RRF	STACK_1, F
$00DD	$0CC0			RRF	STACK_0, F
$00DE	$0BCC			DECFSZ	STACK_12, F
$00DF	$28D9			GOTO	$-6
$00E0	$0008			RETURN
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
$000E	$0094			MOVWF	STSAVED_0
;D_85_16F84A_Remote_v_5_0.c,29 :: 		void interrupt(void)
;D_85_16F84A_Remote_v_5_0.c,35 :: 		INTCON &= 0x7F;  // interrupt => forbidden
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_0.c,36 :: 		INTCON &= 0xEF;  // INT interrupt => forbidden
$0011	$30EF			MOVLW	239
$0012	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_0.c,37 :: 		INTCON &= 0xFD;  // INT interrupt flag => cleared
$0013	$30FD			MOVLW	253
$0014	$058B			ANDWF	INTCON, 1
;D_85_16F84A_Remote_v_5_0.c,42 :: 		TMR0 = 0;
$0015	$0181			CLRF	TMR0, 1
;D_85_16F84A_Remote_v_5_0.c,48 :: 		while((PORTB & 0x01) == 0) //---------------------
$0016	$	L_interrupt_3:
$0016	$3001			MOVLW	1
$0017	$0506			ANDWF	PORTB, 0
$0018	$00C1			MOVWF	STACK_1
$0019	$0841			MOVF	STACK_1, 0
$001A	$3A00			XORLW	0
$001B	$1D03			BTFSS	STATUS, Z
$001C	$2828			GOTO	L_interrupt_4
;D_85_16F84A_Remote_v_5_0.c,52 :: 		if(TMR0 == 255)
$001D	$0801			MOVF	TMR0, 0
$001E	$3AFF			XORLW	255
$001F	$1D03			BTFSS	STATUS, Z
$0020	$2827			GOTO	L_interrupt_5
;D_85_16F84A_Remote_v_5_0.c,56 :: 		_pulse(3);
$0021	$3003			MOVLW	3
$0022	$0090			MOVWF	FARG__pulse+0
$0023	$3000			MOVLW	0
$0024	$0091			MOVWF	FARG__pulse+1
$0025	$2070			CALL	__pulse
;D_85_16F84A_Remote_v_5_0.c,58 :: 		break;
$0026	$2828			GOTO	L_interrupt_4
;D_85_16F84A_Remote_v_5_0.c,59 :: 		}
$0027	$	L_interrupt_5:
;D_85_16F84A_Remote_v_5_0.c,61 :: 		}//while((PORTB & 0x01) == 0)
$0027	$2816			GOTO	L_interrupt_3
$0028	$	L_interrupt_4:
;D_85_16F84A_Remote_v_5_0.c,67 :: 		if(TMR0 < 156) //---------------------
$0028	$309C			MOVLW	156
$0029	$0201			SUBWF	TMR0, 0
$002A	$1803			BTFSC	STATUS, C
$002B	$2842			GOTO	L_interrupt_6
;D_85_16F84A_Remote_v_5_0.c,70 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$002C	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_0.c,71 :: 		INTCON |= 0x80;        // interrupt => permitted
$002D	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_0.c,74 :: 		PORTA = 0x01;
$002E	$3001			MOVLW	1
$002F	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_5_0.c,75 :: 		Delay_ms(1);
$0030	$3007			MOVLW	7
$0031	$00CB			MOVWF	STACK_11
$0032	$30FF			MOVLW	255
$0033	$00CA			MOVWF	STACK_10
$0034	$0BCB			DECFSZ	STACK_11, F
$0035	$2837			GOTO	$+2
$0036	$283A			GOTO	$+4
$0037	$0BCA			DECFSZ	STACK_10, F
$0038	$2837			GOTO	$-1
$0039	$2834			GOTO	$-5
$003A	$3078			MOVLW	120
$003B	$00CA			MOVWF	STACK_10
$003C	$0BCA			DECFSZ	STACK_10, F
$003D	$283C			GOTO	$-1
$003E	$0000			NOP
$003F	$0000			NOP
;D_85_16F84A_Remote_v_5_0.c,76 :: 		PORTA = 0x00;
$0040	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_0.c,78 :: 		return;                // return
$0041	$2865			GOTO	L_Interrupt_end
;D_85_16F84A_Remote_v_5_0.c,89 :: 		} else if (TMR0 > 196) {
$0042	$	L_interrupt_6:
$0042	$0801			MOVF	TMR0, 0
$0043	$3CC4			SUBLW	196
$0044	$1803			BTFSC	STATUS, C
$0045	$284D			GOTO	L_interrupt_8
;D_85_16F84A_Remote_v_5_0.c,91 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0046	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_0.c,92 :: 		INTCON |= 0x80;        // interrupt => permitted
$0047	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_0.c,95 :: 		_pulse(2);
$0048	$3002			MOVLW	2
$0049	$0090			MOVWF	FARG__pulse+0
$004A	$3000			MOVLW	0
$004B	$0091			MOVWF	FARG__pulse+1
$004C	$2070			CALL	__pulse
;D_85_16F84A_Remote_v_5_0.c,97 :: 		}
$004D	$	L_interrupt_8:
$004D	$	L_interrupt_7:
;D_85_16F84A_Remote_v_5_0.c,101 :: 		if(LED_FLAG == 1)
$004D	$080C			MOVF	_LED_FLAG, 0
$004E	$3A01			XORLW	1
$004F	$1D03			BTFSS	STATUS, Z
$0050	$285B			GOTO	L_interrupt_9
;D_85_16F84A_Remote_v_5_0.c,104 :: 		PORTA = 0x01;
$0051	$3001			MOVLW	1
$0052	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_5_0.c,106 :: 		LED_FLAG *= -1;
$0053	$080C			MOVF	_LED_FLAG, 0
$0054	$00C0			MOVWF	STACK_0
$0055	$30FF			MOVLW	255
$0056	$00C4			MOVWF	STACK_4
$0057	$20C8			CALL	_mul_8x8_u
$0058	$0840			MOVF	STACK_0, 0
$0059	$008C			MOVWF	_LED_FLAG
;D_85_16F84A_Remote_v_5_0.c,108 :: 		} else {
$005A	$2863			GOTO	L_interrupt_10
$005B	$	L_interrupt_9:
;D_85_16F84A_Remote_v_5_0.c,111 :: 		PORTA = 0x00;
$005B	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_0.c,113 :: 		LED_FLAG *= -1;
$005C	$080C			MOVF	_LED_FLAG, 0
$005D	$00C0			MOVWF	STACK_0
$005E	$30FF			MOVLW	255
$005F	$00C4			MOVWF	STACK_4
$0060	$20C8			CALL	_mul_8x8_u
$0061	$0840			MOVF	STACK_0, 0
$0062	$008C			MOVWF	_LED_FLAG
;D_85_16F84A_Remote_v_5_0.c,115 :: 		}//if(LED_FLAG == 1)
$0063	$	L_interrupt_10:
;D_85_16F84A_Remote_v_5_0.c,184 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$0063	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_0.c,185 :: 		INTCON |= 0x80;
$0064	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_0.c,187 :: 		}//void interrupt(void)
$0065	$	L_Interrupt_end:
$0065	$0814			MOVF	STSAVED_0, 0
$0066	$00C0			MOVWF	STACK_0
$0067	$080F			MOVF	?savePCLATH, 0
$0068	$008A			MOVWF	PCLATH
$0069	$080D			MOVF	?saveFSR, 0
$006A	$0084			MOVWF	FSR
$006B	$0E0E			SWAPF	?saveSTATUS, 0
$006C	$0083			MOVWF	STATUS
$006D	$0ECF			SWAPF	STACK_15, 1
$006E	$0E4F			SWAPF	STACK_15, 0
$006F	$0009			RETFIE
$00E1	$	GlobalIniD_85_16F84A_Remote_v_5_0:
$00E1	$3001			MOVLW	1
$00E2	$1303			BCF	STATUS, RP1
$00E3	$1283			BCF	STATUS, RP0
$00E4	$008C			MOVWF	_LED_FLAG+0
$00E5	$0008			RETURN
$00A8	$	_main:
;D_85_16F84A_Remote_v_5_0.c,190 :: 		void main(void)
;D_85_16F84A_Remote_v_5_0.c,194 :: 		TRISA     = 0x00;
$00A8	$20E1			CALL	GlobalIniD_85_16F84A_Remote_v_5_0
$00A9	$1683			BSF	STATUS, RP0
$00AA	$0185			CLRF	TRISA, 1
;D_85_16F84A_Remote_v_5_0.c,195 :: 		PORTA     = 0x00;		//0000 0010
$00AB	$1283			BCF	STATUS, RP0
$00AC	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_5_0.c,197 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$00AD	$30FF			MOVLW	255
$00AE	$1683			BSF	STATUS, RP0
$00AF	$0086			MOVWF	TRISB
;D_85_16F84A_Remote_v_5_0.c,199 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$00B0	$307F			MOVLW	127
$00B1	$0501			ANDWF	OPTION_REG, 0
$00B2	$00C0			MOVWF	STACK_0
$00B3	$0840			MOVF	STACK_0, 0
$00B4	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_0.c,200 :: 		OPTION_REG &= 0xBF;	// INT interrupt => by 5V ~> 0V
$00B5	$30BF			MOVLW	191
$00B6	$05C0			ANDWF	STACK_0, 1
$00B7	$0840			MOVF	STACK_0, 0
$00B8	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_0.c,202 :: 		OPTION_REG &= 0xDF;	// Timer by clock
$00B9	$30DF			MOVLW	223
$00BA	$05C0			ANDWF	STACK_0, 1
$00BB	$0840			MOVF	STACK_0, 0
$00BC	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_0.c,203 :: 		OPTION_REG &= 0xF0;	// Prescaler => on
$00BD	$30F0			MOVLW	240
$00BE	$05C0			ANDWF	STACK_0, 1
$00BF	$0840			MOVF	STACK_0, 0
$00C0	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_0.c,204 :: 		OPTION_REG |= 0x07; // Prescaler => 1/256
$00C1	$3007			MOVLW	7
$00C2	$0440			IORWF	STACK_0, 0
$00C3	$0081			MOVWF	OPTION_REG
;D_85_16F84A_Remote_v_5_0.c,212 :: 		INTCON |= 0x10;        // INT interrupt => permitted
$00C4	$160B			BSF	INTCON, 4
;D_85_16F84A_Remote_v_5_0.c,213 :: 		INTCON |= 0x80;
$00C5	$178B			BSF	INTCON, 7
;D_85_16F84A_Remote_v_5_0.c,215 :: 		while(1)
$00C6	$	L_main_11:
$00C6	$28C6			GOTO	L_main_11
;D_85_16F84A_Remote_v_5_0.c,223 :: 		}//void main(void)
$00C7	$28C7			GOTO	$
