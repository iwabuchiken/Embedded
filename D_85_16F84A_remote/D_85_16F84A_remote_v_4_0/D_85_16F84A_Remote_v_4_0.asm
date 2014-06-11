;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/05/31 17:11:28
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$2804			GOTO	_main
$0004	$	_main:
;D_85_16F84A_Remote_v_4_0.c,6 :: 		void main(void)
;D_85_16F84A_Remote_v_4_0.c,13 :: 		usi input_a = 0xFE;
$0004	$30FE			MOVLW	254
$0005	$1303			BCF	STATUS, RP1
$0006	$1283			BCF	STATUS, RP0
$0007	$008C			MOVWF	main_input_a_L0
;D_85_16F84A_Remote_v_4_0.c,14 :: 		usi input_b = 0xFD;
$0008	$30FD			MOVLW	253
$0009	$008D			MOVWF	main_input_b_L0
;D_85_16F84A_Remote_v_4_0.c,17 :: 		usi LED_Left = 0x02;
$000A	$3002			MOVLW	2
$000B	$008E			MOVWF	main_LED_Left_L0
;D_85_16F84A_Remote_v_4_0.c,18 :: 		usi LED_Right = 0x01;
$000C	$3001			MOVLW	1
$000D	$008F			MOVWF	main_LED_Right_L0
;D_85_16F84A_Remote_v_4_0.c,19 :: 		usi LED_Both =0x03;
$000E	$3003			MOVLW	3
$000F	$0090			MOVWF	main_LED_Both_L0
;D_85_16F84A_Remote_v_4_0.c,22 :: 		TRISA     = 0x00;
$0010	$1683			BSF	STATUS, RP0
$0011	$0185			CLRF	TRISA, 1
;D_85_16F84A_Remote_v_4_0.c,23 :: 		PORTA     = 0x00;		//0000 0010
$0012	$1283			BCF	STATUS, RP0
$0013	$0185			CLRF	PORTA, 1
;D_85_16F84A_Remote_v_4_0.c,25 :: 		TRISB     = 0xFF;		// Input: RB0 ~ RB7
$0014	$30FF			MOVLW	255
$0015	$1683			BSF	STATUS, RP0
$0016	$0086			MOVWF	TRISB
;D_85_16F84A_Remote_v_4_0.c,26 :: 		OPTION_REG &= 0x7F;	// Pullup => on
$0017	$307F			MOVLW	127
$0018	$0581			ANDWF	OPTION_REG, 1
;D_85_16F84A_Remote_v_4_0.c,28 :: 		while(1)
$0019	$	L_main_0:
;D_85_16F84A_Remote_v_4_0.c,30 :: 		if (PORTB == input_a) {
$0019	$1283			BCF	STATUS, RP0
$001A	$0806			MOVF	PORTB, 0
$001B	$060C			XORWF	main_input_a_L0, 0
$001C	$1D03			BTFSS	STATUS, Z
$001D	$2821			GOTO	L_main_2
;D_85_16F84A_Remote_v_4_0.c,33 :: 		PORTA = LED_Left;
$001E	$080E			MOVF	main_LED_Left_L0, 0
$001F	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_4_0.c,35 :: 		} else if(PORTB == input_b) {
$0020	$282A			GOTO	L_main_3
$0021	$	L_main_2:
$0021	$0806			MOVF	PORTB, 0
$0022	$060D			XORWF	main_input_b_L0, 0
$0023	$1D03			BTFSS	STATUS, Z
$0024	$2828			GOTO	L_main_4
;D_85_16F84A_Remote_v_4_0.c,38 :: 		PORTA = LED_Right;
$0025	$080F			MOVF	main_LED_Right_L0, 0
$0026	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_4_0.c,40 :: 		} else {
$0027	$282A			GOTO	L_main_5
$0028	$	L_main_4:
;D_85_16F84A_Remote_v_4_0.c,42 :: 		PORTA = LED_Both;
$0028	$0810			MOVF	main_LED_Both_L0, 0
$0029	$0085			MOVWF	PORTA
;D_85_16F84A_Remote_v_4_0.c,44 :: 		}//if (PORTB == input_a)
$002A	$	L_main_5:
$002A	$	L_main_3:
;D_85_16F84A_Remote_v_4_0.c,46 :: 		}//while(1)
$002A	$2819			GOTO	L_main_0
;D_85_16F84A_Remote_v_4_0.c,48 :: 		}//void main(void)
$002B	$282B			GOTO	$