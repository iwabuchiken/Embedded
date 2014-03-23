;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/03/23 15:58:46
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2830			GOTO	_main
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$008F			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$008E			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$0090			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$0840			MOVF	STACK_0, 0
$000E	$0092			MOVWF	STSAVED_0
;D_84_16F84A_Flasher_v_3_0.c,4 :: 		void interrupt(void)
;D_84_16F84A_Flasher_v_3_0.c,6 :: 		INTCON         &= 0x7F;
$000F	$307F			MOVLW	127
$0010	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_3_0.c,7 :: 		INTCON         &= 0xDF;
$0011	$30DF			MOVLW	223
$0012	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_3_0.c,8 :: 		INTCON         &= 0xFB;
$0013	$30FB			MOVLW	251
$0014	$058B			ANDWF	INTCON, 1
;D_84_16F84A_Flasher_v_3_0.c,10 :: 		if(count < duty)
$0015	$080D			MOVF	_duty, 0
$0016	$020C			SUBWF	_count, 0
$0017	$1803			BTFSC	STATUS, C
$0018	$281C			GOTO	L_interrupt_0
;D_84_16F84A_Flasher_v_3_0.c,12 :: 		PORTA = 0x01;
$0019	$3001			MOVLW	1
$001A	$0085			MOVWF	PORTA
;D_84_16F84A_Flasher_v_3_0.c,13 :: 		}
$001B	$281D			GOTO	L_interrupt_1
$001C	$	L_interrupt_0:
;D_84_16F84A_Flasher_v_3_0.c,16 :: 		PORTA = 0x00;
$001C	$0185			CLRF	PORTA, 1
;D_84_16F84A_Flasher_v_3_0.c,17 :: 		}
$001D	$	L_interrupt_1:
;D_84_16F84A_Flasher_v_3_0.c,19 :: 		count++;
$001D	$0A8C			INCF	_count, 1
;D_84_16F84A_Flasher_v_3_0.c,21 :: 		if(count == 100)
$001E	$080C			MOVF	_count, 0
$001F	$3A64			XORLW	100
$0020	$1D03			BTFSS	STATUS, Z
$0021	$2823			GOTO	L_interrupt_2
;D_84_16F84A_Flasher_v_3_0.c,23 :: 		count = 0;
$0022	$018C			CLRF	_count, 1
;D_84_16F84A_Flasher_v_3_0.c,24 :: 		}
$0023	$	L_interrupt_2:
;D_84_16F84A_Flasher_v_3_0.c,26 :: 		INTCON         |= 0x20;
$0023	$168B			BSF	INTCON, 5
;D_84_16F84A_Flasher_v_3_0.c,27 :: 		INTCON         |= 0x80;
$0024	$178B			BSF	INTCON, 7
;D_84_16F84A_Flasher_v_3_0.c,29 :: 		}//void interrupt(void)
$0025	$	L_Interrupt_end:
$0025	$0812			MOVF	STSAVED_0, 0
$0026	$00C0			MOVWF	STACK_0
$0027	$0810			MOVF	?savePCLATH, 0
$0028	$008A			MOVWF	PCLATH
$0029	$080E			MOVF	?saveFSR, 0
$002A	$0084			MOVWF	FSR
$002B	$0E0F			SWAPF	?saveSTATUS, 0
$002C	$0083			MOVWF	STATUS
$002D	$0ECF			SWAPF	STACK_15, 1
$002E	$0E4F			SWAPF	STACK_15, 0
$002F	$0009			RETFIE
$0030	$	_main:
;D_84_16F84A_Flasher_v_3_0.c,31 :: 		void main(void)
;D_84_16F84A_Flasher_v_3_0.c,36 :: 		TRISA     = 0x00;
$0030	$1303			BCF	STATUS, RP1
$0031	$1683			BSF	STATUS, RP0
$0032	$0185			CLRF	TRISA, 1
;D_84_16F84A_Flasher_v_3_0.c,37 :: 		PORTA     = 0x00; //0000 0010
$0033	$1283			BCF	STATUS, RP0
$0034	$0185			CLRF	PORTA, 1
;D_84_16F84A_Flasher_v_3_0.c,38 :: 		TRISB     = 0x00;
$0035	$1683			BSF	STATUS, RP0
$0036	$0186			CLRF	TRISB, 1
;D_84_16F84A_Flasher_v_3_0.c,39 :: 		PORTB     = 0x00;
$0037	$1283			BCF	STATUS, RP0
$0038	$0186			CLRF	PORTB, 1
;D_84_16F84A_Flasher_v_3_0.c,41 :: 		OPTION_REG &= 0xDF;
$0039	$30DF			MOVLW	223
$003A	$1683			BSF	STATUS, RP0
$003B	$0581			ANDWF	OPTION_REG, 1
;D_84_16F84A_Flasher_v_3_0.c,45 :: 		count	= 0;
$003C	$018C			CLRF	_count, 1
;D_84_16F84A_Flasher_v_3_0.c,46 :: 		duty   = 0;
$003D	$018D			CLRF	_duty, 1
;D_84_16F84A_Flasher_v_3_0.c,48 :: 		TMR0  = 0;
$003E	$1283			BCF	STATUS, RP0
$003F	$0181			CLRF	TMR0, 1
;D_84_16F84A_Flasher_v_3_0.c,50 :: 		INTCON         |= 0x20;
$0040	$168B			BSF	INTCON, 5
;D_84_16F84A_Flasher_v_3_0.c,51 :: 		INTCON         |= 0x80;
$0041	$178B			BSF	INTCON, 7
;D_84_16F84A_Flasher_v_3_0.c,53 :: 		while(1)
$0042	$	L_main_3:
;D_84_16F84A_Flasher_v_3_0.c,55 :: 		for(i = 0; i < 100; i++)
$0042	$0191			CLRF	main_i_L0, 1
$0043	$	L_main_5:
$0043	$3064			MOVLW	100
$0044	$0211			SUBWF	main_i_L0, 0
$0045	$1803			BTFSC	STATUS, C
$0046	$285A			GOTO	L_main_6
;D_84_16F84A_Flasher_v_3_0.c,57 :: 		duty = i;
$0047	$0811			MOVF	main_i_L0, 0
$0048	$008D			MOVWF	_duty
;D_84_16F84A_Flasher_v_3_0.c,58 :: 		Delay_ms(10);
$0049	$3041			MOVLW	65
$004A	$00CB			MOVWF	STACK_11
$004B	$30FF			MOVLW	255
$004C	$00CA			MOVWF	STACK_10
$004D	$0BCB			DECFSZ	STACK_11, F
$004E	$2850			GOTO	$+2
$004F	$2853			GOTO	$+4
$0050	$0BCA			DECFSZ	STACK_10, F
$0051	$2850			GOTO	$-1
$0052	$284D			GOTO	$-5
$0053	$30C3			MOVLW	195
$0054	$00CA			MOVWF	STACK_10
$0055	$0BCA			DECFSZ	STACK_10, F
$0056	$2855			GOTO	$-1
$0057	$0000			NOP
;D_84_16F84A_Flasher_v_3_0.c,59 :: 		}
$0058	$	L_main_7:
;D_84_16F84A_Flasher_v_3_0.c,55 :: 		for(i = 0; i < 100; i++)
$0058	$0A91			INCF	main_i_L0, 1
;D_84_16F84A_Flasher_v_3_0.c,59 :: 		}
$0059	$2843			GOTO	L_main_5
$005A	$	L_main_6:
;D_84_16F84A_Flasher_v_3_0.c,61 :: 		for(i = 0; i < 100; i++)
$005A	$0191			CLRF	main_i_L0, 1
$005B	$	L_main_8:
$005B	$3064			MOVLW	100
$005C	$0211			SUBWF	main_i_L0, 0
$005D	$1803			BTFSC	STATUS, C
$005E	$2873			GOTO	L_main_9
;D_84_16F84A_Flasher_v_3_0.c,63 :: 		duty = 99 - i;
$005F	$0811			MOVF	main_i_L0, 0
$0060	$3C63			SUBLW	99
$0061	$008D			MOVWF	_duty
;D_84_16F84A_Flasher_v_3_0.c,64 :: 		Delay_ms(10);
$0062	$3041			MOVLW	65
$0063	$00CB			MOVWF	STACK_11
$0064	$30FF			MOVLW	255
$0065	$00CA			MOVWF	STACK_10
$0066	$0BCB			DECFSZ	STACK_11, F
$0067	$2869			GOTO	$+2
$0068	$286C			GOTO	$+4
$0069	$0BCA			DECFSZ	STACK_10, F
$006A	$2869			GOTO	$-1
$006B	$2866			GOTO	$-5
$006C	$30C3			MOVLW	195
$006D	$00CA			MOVWF	STACK_10
$006E	$0BCA			DECFSZ	STACK_10, F
$006F	$286E			GOTO	$-1
$0070	$0000			NOP
;D_84_16F84A_Flasher_v_3_0.c,65 :: 		}
$0071	$	L_main_10:
;D_84_16F84A_Flasher_v_3_0.c,61 :: 		for(i = 0; i < 100; i++)
$0071	$0A91			INCF	main_i_L0, 1
;D_84_16F84A_Flasher_v_3_0.c,65 :: 		}
$0072	$285B			GOTO	L_main_8
$0073	$	L_main_9:
;D_84_16F84A_Flasher_v_3_0.c,67 :: 		}//while(1)
$0073	$2842			GOTO	L_main_3
;D_84_16F84A_Flasher_v_3_0.c,69 :: 		}//void main(void)
$0074	$2874			GOTO	$