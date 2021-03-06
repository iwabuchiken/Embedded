;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/03/20 17:32:29
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$283C			GOTO	_main
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$0096			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$0095			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$0097			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$0840			MOVF	STACK_0, 0
$000E	$0098			MOVWF	STSAVED_0
;D_84_16F84A_Flasher_v_2_0.c,14 :: 		void interrupt(void)
;D_84_16F84A_Flasher_v_2_0.c,16 :: 		INTCON         &= 0x7F;
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_2_0.c,17 :: 		INTCON         &= 0xDF;
$0011	$30DF			MOVLW	223
$0012	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_2_0.c,18 :: 		INTCON         &= 0xFB;
$0013	$30FB			MOVLW	251
$0014	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_2_0.c,20 :: 		i++;
$0015	$0A8C			INCF	_i, 1
;D_84_16F84A_Flasher_v_2_0.c,23 :: 		Delay_ms(20);
$0016	$3082			MOVLW	130
$0017	$00CB			MOVWF	STACK_11
$0018	$30FF			MOVLW	255
$0019	$00CA			MOVWF	STACK_10
$001A	$0BCB			DECFSZ	STACK_11, F
$001B	$281D			GOTO	$+2
$001C	$2820			GOTO	$+4
$001D	$0BCA			DECFSZ	STACK_10, F
$001E	$281D			GOTO	$-1
$001F	$281A			GOTO	$-5
$0020	$3087			MOVLW	135
$0021	$00CA			MOVWF	STACK_10
$0022	$0BCA			DECFSZ	STACK_10, F
$0023	$2822			GOTO	$-1
$0024	$0000			NOP
;D_84_16F84A_Flasher_v_2_0.c,26 :: 		if(i == 8)
$0025	$080C			MOVF	_i, 0
$0026	$3A08			XORLW	8
$0027	$1D03			BTFSS	STATUS, Z
$0028	$282A			GOTO	L_interrupt_0
;D_84_16F84A_Flasher_v_2_0.c,28 :: 		i = 0;
$0029	$018C			CLRF	_i, 1
;D_84_16F84A_Flasher_v_2_0.c,29 :: 		}
$002A	$	L_interrupt_0:
;D_84_16F84A_Flasher_v_2_0.c,31 :: 		PORTB = p[i];
$002A	$080C			MOVF	_i, 0
$002B	$3F0D			ADDLW	_p
$002C	$0084			MOVWF	FSR
$002D	$0800			MOVF	INDF, 0
$002E	$0086			MOVWF	PORTB
;D_84_16F84A_Flasher_v_2_0.c,36 :: 		INTCON         |= 0x20;
$002F	$168B			BSF	INTCON, 5
;D_84_16F84A_Flasher_v_2_0.c,37 :: 		INTCON         |= 0x80;
$0030	$178B			BSF	INTCON, 7
;D_84_16F84A_Flasher_v_2_0.c,39 :: 		}//void interrupt(void)
$0031	$	L_Interrupt_end:
$0031	$0818			MOVF	STSAVED_0, 0
$0032	$00C0			MOVWF	STACK_0
$0033	$0817			MOVF	?savePCLATH, 0
$0034	$008A			MOVWF	PCLATH
$0035	$0815			MOVF	?saveFSR, 0
$0036	$0084			MOVWF	FSR
$0037	$0E16			SWAPF	?saveSTATUS, 0
$0038	$0083			MOVWF	STATUS
$0039	$0ECF			SWAPF	STACK_15, 1
$003A	$0E4F			SWAPF	STACK_15, 0
$003B	$0009			RETFIE
$0059	$	GlobalIniD_84_16F84A_Flasher_v_2_0:
$0059	$3000			MOVLW	0
$005A	$1303			BCF	STATUS, RP1
$005B	$1283			BCF	STATUS, RP0
$005C	$008D			MOVWF	_p+0
$005D	$307E			MOVLW	126
$005E	$008E			MOVWF	_p+1
$005F	$3011			MOVLW	17
$0060	$008F			MOVWF	_p+2
$0061	$3011			MOVLW	17
$0062	$0090			MOVWF	_p+3
$0063	$3011			MOVLW	17
$0064	$0091			MOVWF	_p+4
$0065	$307E			MOVLW	126
$0066	$0092			MOVWF	_p+5
$0067	$3000			MOVLW	0
$0068	$0093			MOVWF	_p+6
$0069	$3000			MOVLW	0
$006A	$0094			MOVWF	_p+7
$006B	$0008			RETURN
$003C	$	_main:
;D_84_16F84A_Flasher_v_2_0.c,41 :: 		void main(void)
;D_84_16F84A_Flasher_v_2_0.c,44 :: 		TRISA     = 0x00;
$003C	$2059			CALL	GlobalIniD_84_16F84A_Flasher_v_2_0
$003D	$1683			BSF	STATUS, RP0
$003E	$0185			CLRF	TRISA, 1
;D_84_16F84A_Flasher_v_2_0.c,45 :: 		PORTA     = 0x00; //0000 0010
$003F	$1283			BCF	STATUS, RP0
$0040	$0185			CLRF	PORTA, 1
;D_84_16F84A_Flasher_v_2_0.c,46 :: 		TRISB     = 0x00;
$0041	$1683			BSF	STATUS, RP0
$0042	$0186			CLRF	TRISB, 1
;D_84_16F84A_Flasher_v_2_0.c,47 :: 		PORTB     = 0x00;
$0043	$1283			BCF	STATUS, RP0
$0044	$0186			CLRF	PORTB, 1
;D_84_16F84A_Flasher_v_2_0.c,49 :: 		OPTION_REG &= 0xDF;
$0045	$30DF			MOVLW	223
$0046	$1683			BSF	STATUS, RP0
$0047	$0501			ANDWF	OPTION_REG, 0
$0048	$00C0			MOVWF	STACK_0
$0049	$0840			MOVF	STACK_0, 0
$004A	$0081			MOVWF	OPTION_REG
;D_84_16F84A_Flasher_v_2_0.c,50 :: 		OPTION_REG &= 0xF0;
$004B	$30F0			MOVLW	240
$004C	$05C0			ANDWF	STACK_0, 1
$004D	$0840			MOVF	STACK_0, 0
$004E	$0081			MOVWF	OPTION_REG
;D_84_16F84A_Flasher_v_2_0.c,51 :: 		OPTION_REG &= 0x07;
$004F	$3007			MOVLW	7
$0050	$0540			ANDWF	STACK_0, 0
$0051	$0081			MOVWF	OPTION_REG
;D_84_16F84A_Flasher_v_2_0.c,53 :: 		i = 0;
$0052	$018C			CLRF	_i, 1
;D_84_16F84A_Flasher_v_2_0.c,55 :: 		TMR0  = 0;
$0053	$1283			BCF	STATUS, RP0
$0054	$0181			CLRF	TMR0, 1
;D_84_16F84A_Flasher_v_2_0.c,57 :: 		INTCON         |= 0x20;
$0055	$168B			BSF	INTCON, 5
;D_84_16F84A_Flasher_v_2_0.c,58 :: 		INTCON         |= 0x80;
$0056	$178B			BSF	INTCON, 7
;D_84_16F84A_Flasher_v_2_0.c,60 :: 		while(1)
$0057	$	L_main_1:
$0057	$2857			GOTO	L_main_1
;D_84_16F84A_Flasher_v_2_0.c,65 :: 		}//void main(void)
$0058	$2858			GOTO	$
