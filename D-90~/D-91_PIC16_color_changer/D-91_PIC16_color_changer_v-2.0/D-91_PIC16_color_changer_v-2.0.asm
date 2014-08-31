;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/08/31 16:10:24
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2804			GOTO	_main
$0004	$	_main:
;D-91_PIC16_color_changer_v-2.0.c,32 :: 		void main(void)
;D-91_PIC16_color_changer_v-2.0.c,36 :: 		TRISA     = 0x00;
$0004	$1303			BCF	STATUS, RP1
$0005	$1683			BSF	STATUS, RP0
$0006	$0185			CLRF	TRISA, 1
;D-91_PIC16_color_changer_v-2.0.c,37 :: 		PORTA     = 0x00;		//0000 0010
$0007	$1283			BCF	STATUS, RP0
$0008	$0185			CLRF	PORTA, 1
;D-91_PIC16_color_changer_v-2.0.c,39 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$0009	$30FF			MOVLW	255
$000A	$1683			BSF	STATUS, RP0
$000B	$0086			MOVWF	TRISB
;D-91_PIC16_color_changer_v-2.0.c,41 :: 		OPTION_REG &= 0x7F;	// Pull-up => on
$000C	$307F			MOVLW	127
$000D	$0581			ANDWF	OPTION_REG, 1
;D-91_PIC16_color_changer_v-2.0.c,43 :: 		while(1)
$000E	$	L_main_0:
;D-91_PIC16_color_changer_v-2.0.c,46 :: 		if ((PORTB & 0x02) == 0x02) {
$000E	$3002			MOVLW	2
$000F	$1283			BCF	STATUS, RP0
$0010	$0506			ANDWF	PORTB, 0
$0011	$00C1			MOVWF	STACK_1
$0012	$0841			MOVF	STACK_1, 0
$0013	$3A02			XORLW	2
$0014	$1D03			BTFSS	STATUS, Z
$0015	$2819			GOTO	L_main_2
;D-91_PIC16_color_changer_v-2.0.c,51 :: 		LED_2_ON;
$0016	$3002			MOVLW	2
$0017	$0085			MOVWF	PORTA
;D-91_PIC16_color_changer_v-2.0.c,53 :: 		} else {
$0018	$281B			GOTO	L_main_3
$0019	$	L_main_2:
;D-91_PIC16_color_changer_v-2.0.c,55 :: 		LED_1_ON;
$0019	$3001			MOVLW	1
$001A	$0085			MOVWF	PORTA
;D-91_PIC16_color_changer_v-2.0.c,58 :: 		}
$001B	$	L_main_3:
;D-91_PIC16_color_changer_v-2.0.c,60 :: 		}//while(1)
$001B	$280E			GOTO	L_main_0
;D-91_PIC16_color_changer_v-2.0.c,62 :: 		}//void main(void)
$001C	$281C			GOTO	$
