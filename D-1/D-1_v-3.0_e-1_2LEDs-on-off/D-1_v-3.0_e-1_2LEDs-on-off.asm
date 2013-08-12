;**********************************
;	File:		D-1_v-3.0_e-1_2LEDs-on-off__v-4.0_e-3.asm
;	Version:	v-4.0/e-3
;	Date:		11/08/2013 18:43:51
;
;**********************************

		list		p=10f200
		#include	<p10f200.inc>

		__CONFIG		_CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

;********* VARIABLES ******************
;{
CNT1	EQU		0x10
CNT2	EQU		0x11
CNT3	EQU		0x12

NUM		EQU		0x13
TEMP	EQU		0x14

ONE		EQU		0x15
TWO		EQU		0x16
THREE	EQU		0x17
FOUR	EQU		0x18

INPUT_RESULT	EQU		0x19
;}
;

;********* SETUP: ENVIRONMENT ********
	ORG			0x00

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111100'
	TRIS		GPIO
	
;********* INITIALIZE: Variables ********
;{
	movlw		d'0'	; Initialize "TEMP" variable
	movwf		TEMP

	movlw		d'1'
	movwf		ONE

	movlw		d'2'
	movwf		TWO

	movlw		d'3'
	movwf		THREE

	movlw		d'4'
	movwf		FOUR
;}
;

;********* MAIN ******************
main_loop
	
	;************************
	; Set: W register
	;************************
	call		Check_GP2_AND_GP3
	
	;************************
	; Save the value in Wreg into a freg
	;************************
	movwf		INPUT_RESULT
	
	;************************
	; Execute
	;************************
	goto		Set_W

;********* FUNCTIONS ******************	
;Check_GP2_AND_GP3
Check_GP2_AND_GP3
;{
Check_GP2
	BTFSC		GPIO,2
	
	goto		Chk_GP3__GP2_ON
	goto		Chk_GP3__GP2_OFF


;}
;

;Chk_GP3__GP2_ON
Chk_GP3__GP2_ON
;{
	BTFSC		GPIO,3
	
	retlw		d'1'
	retlw		d'2'
;}
;

;Chk_GP3__GP2_OFF
Chk_GP3__GP2_OFF
;{
	BTFSC		GPIO,3
	
	retlw		d'3'
	retlw		d'4'		
	
;}
;



;Set_W
;{
Set_W
	;-----------------------
	; GP2=ON, GP3=ON (W=1)
	;-----------------------
	
	; Move the value in INPUT_RESULT
	;	into Wreg
	;	=> i.e. Reset Wreg
	movf		INPUT_RESULT,W
	
	;SUBWF		ONE,TEMP
	SUBWF		ONE,W
	
	BTFSC		STATUS,Z
	
	goto		LED_ON_BOTH

	;-----------------------
	; GP2=ON, GP3=OFF (W=2)
	;-----------------------
	; Move the value in INPUT_RESULT
	;	into Wreg
	;	=> i.e. Reset Wreg
	;movwf		INPUT_RESULT,W	;=> Illegal character (,)
	movf		INPUT_RESULT,W
	
	;SUBWF		TWO,TEMP
	SUBWF		TWO,W
	
	BTFSC		STATUS,Z
	
	;goto		LED_ALTER_FAST
	goto		LED_ALTER_NORMAL

	;-----------------------
	; GP2=OFF, GP3=ON (W=3)
	;-----------------------

	; Move the value in INPUT_RESULT
	;	into Wreg
	;	=> i.e. Reset Wreg
	movf		INPUT_RESULT,W
	
	;SUBWF		THREE,TEMP
	SUBWF		THREE,W
	
	BTFSC		STATUS,Z
	
	goto		LED_ONOFF_BOTH

	;-----------------------
	; GP2=OFF, GP3=OFF (W=4)
	;-----------------------

	; Move the value in INPUT_RESULT
	;	into Wreg
	;	=> i.e. Reset Wreg
	movf		INPUT_RESULT,W
	
	;SUBWF		FOUR,TEMP
	SUBWF		FOUR,W
	
	BTFSC		STATUS,Z
	
	goto		LED_ALTER_NORMAL
;}

;

;LED_ALTER_NORMAL
;{
LED_ALTER_NORMAL

	movlw		d'10'

	; GP0=ON, GP1=OFF
	BSF			GPIO,0
	BCF			GPIO,1
	
	
	call		DLY

	;e-3-p1-t2
	movlw		d'10'

	; GP0=OFF, GP1=ON
	BCF			GPIO,0
	BSF			GPIO,1
	
	call		DLY
	
	goto		main_loop

;}
;

;LED_ALTER_FAST
;{
LED_ALTER_FAST

	movlw		d'2'

	; GP0=ON, GP1=OFF
	BSF			GPIO,0
	BCF			GPIO,1
	
	call		DLY

	; GP0=OFF, GP1=ON
	BCF			GPIO,0
	BSF			GPIO,1
	
	call		DLY
	
	goto		main_loop

;}
;

;LED_ON_BOTH
;{
LED_ON_BOTH

	; GP0=ON, GP1=ON
	BSF			GPIO,0
	BSF			GPIO,1
	
	goto		main_loop

;}
;

;LED_ONOFF_BOTH
;{
LED_ONOFF_BOTH

	movlw		d'10'

	; GP0=ON, GP1=ON
	BSF			GPIO,0
	BSF			GPIO,1
	
	call		DLY

	; GP0=OFF, GP1=OFF
	BCF			GPIO,0
	BCF			GPIO,1
	
	call		DLY
		
	goto		main_loop

;}
;


;DLY
;{
DLY
	;movlw		d'10'
	movwf		CNT3
	
DLY_100
	movlw		d'100'
	movwf		CNT1

DLP1
	movlw		d'200'
	movwf		CNT2
	
DLP2
	nop
	nop
	
	decfsz		CNT2,f
	goto		DLP2
	
	decfsz		CNT1,f
	goto		DLP1
	
	decfsz		CNT3,f
	goto		DLY_100
	
	retlw		0
	;goto		main_loop
;}

;

;******** END ******************
	END