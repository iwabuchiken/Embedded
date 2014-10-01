;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/10/01 13:37:37
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2820			GOTO	_main
$0004	$	_interrupt:
$0004	$00FF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$00A1			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$00A0			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$00A2			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
;D-93_PIC16_F88_ADC_v_6_0_6.c,60 :: 		interrupt(void) {
;D-93_PIC16_F88_ADC_v_6_0_6.c,62 :: 		INTCON &= 0x7F;		// forbid global interrupt
$000D	$307F			MOVLW	127
$000E	$058B			ANDWF	INTCON, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,63 :: 		INTCON &= 0xDF;		// forbid timer interrupt
$000F	$30DF			MOVLW	223
$0010	$058B			ANDWF	INTCON, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,64 :: 		INTCON &= 0xFB;		// clear timer interrupt flag
$0011	$30FB			MOVLW	251
$0012	$058B			ANDWF	INTCON, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,75 :: 		PORTA ^= 0x03;
$0013	$3003			MOVLW	3
$0014	$0685			XORWF	PORTA, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,82 :: 		INTCON |= 0x20;
$0015	$168B			BSF	INTCON, 5
;D-93_PIC16_F88_ADC_v_6_0_6.c,83 :: 		INTCON |= 0x80;
$0016	$178B			BSF	INTCON, 7
;D-93_PIC16_F88_ADC_v_6_0_6.c,85 :: 		}//interrupt
$0017	$	L_Interrupt_end:
$0017	$0822			MOVF	?savePCLATH, 0
$0018	$008A			MOVWF	PCLATH
$0019	$0820			MOVF	?saveFSR, 0
$001A	$0084			MOVWF	FSR
$001B	$0E21			SWAPF	?saveSTATUS, 0
$001C	$0083			MOVWF	STATUS
$001D	$0EFF			SWAPF	STACK_15, 1
$001E	$0E7F			SWAPF	STACK_15, 0
$001F	$0009			RETFIE
$0032	$	__main_Setup:
;D-93_PIC16_F88_ADC_v_6_0_6.c,88 :: 		_main_Setup(void) {
;D-93_PIC16_F88_ADC_v_6_0_6.c,90 :: 		TRISA	= 0x00;
$0032	$1303			BCF	STATUS, RP1
$0033	$1683			BSF	STATUS, RP0
$0034	$0185			CLRF	TRISA, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,91 :: 		TRISB	= 0x00;
$0035	$0186			CLRF	TRISB, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,93 :: 		PORTB	= 0x01;
$0036	$3001			MOVLW	1
$0037	$1283			BCF	STATUS, RP0
$0038	$0086			MOVWF	PORTB
;D-93_PIC16_F88_ADC_v_6_0_6.c,101 :: 		ANSEL = 0;
$0039	$1683			BSF	STATUS, RP0
$003A	$019B			CLRF	ANSEL, 1
;D-93_PIC16_F88_ADC_v_6_0_6.c,108 :: 		OPTION_REG	&= 0x7F;	// enable pull-up	0111 1111
$003B	$307F			MOVLW	127
$003C	$0501			ANDWF	OPTION_REG, 0
$003D	$00F0			MOVWF	STACK_0
$003E	$0870			MOVF	STACK_0, 0
$003F	$0081			MOVWF	OPTION_REG
;D-93_PIC16_F88_ADC_v_6_0_6.c,109 :: 		OPTION_REG	&= 0xDF;	// internal clock	1101 1111
$0040	$30DF			MOVLW	223
$0041	$0570			ANDWF	STACK_0, 0
$0042	$0081			MOVWF	OPTION_REG
;D-93_PIC16_F88_ADC_v_6_0_6.c,124 :: 		}//_main_Setup
$0043	$0008			RETURN
$0020	$	_main:
;D-93_PIC16_F88_ADC_v_6_0_6.c,31 :: 		void main(void)
;D-93_PIC16_F88_ADC_v_6_0_6.c,34 :: 		_main_Setup();
$0020	$2032			CALL	__main_Setup
;D-93_PIC16_F88_ADC_v_6_0_6.c,36 :: 		while(1)
$0021	$	L_main_0:
;D-93_PIC16_F88_ADC_v_6_0_6.c,39 :: 		PORTA = 0x01;
$0021	$3001			MOVLW	1
$0022	$1283			BCF	STATUS, RP0
$0023	$0085			MOVWF	PORTA
;D-93_PIC16_F88_ADC_v_6_0_6.c,41 :: 		Delay_us(10);
$0024	$3010			MOVLW	16
$0025	$00FA			MOVWF	STACK_10
$0026	$0BFA			DECFSZ	STACK_10, F
$0027	$2826			GOTO	$-1
$0028	$0000			NOP
;D-93_PIC16_F88_ADC_v_6_0_6.c,43 :: 		PORTA = 0x02;
$0029	$3002			MOVLW	2
$002A	$0085			MOVWF	PORTA
;D-93_PIC16_F88_ADC_v_6_0_6.c,45 :: 		Delay_us(10);
$002B	$3010			MOVLW	16
$002C	$00FA			MOVWF	STACK_10
$002D	$0BFA			DECFSZ	STACK_10, F
$002E	$282D			GOTO	$-1
$002F	$0000			NOP
;D-93_PIC16_F88_ADC_v_6_0_6.c,55 :: 		}//while(1)
$0030	$2821			GOTO	L_main_0
;D-93_PIC16_F88_ADC_v_6_0_6.c,57 :: 		}//void main(void)
$0031	$2831			GOTO	$