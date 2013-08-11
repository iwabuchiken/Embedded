;**********************************
;	File:		D-1_v-3.0_e-1_2LEDs-on-off__v-4.0_e-2.asm
;	Version:	v-4.0/e-3
;	Date:		05/08/2013 16:34:10
;
;**********************************
		list		p=10f200
		#include	<p10f200.inc>

		__CONFIG		_CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

;********* VARIABLES ******************
CNT1	EQU		0x10
CNT2	EQU		0x11
CNT3	EQU		0x12

ZERO	EQU		0x13
TEMP	EQU		0x14

;********* SETUP: ENVIRONMENT ********
	ORG			0x00

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111100'
	TRIS		GPIO
	
;********* INITIALIZE: Variables ********
	movlw		d'0'	; Initialize "ZERO" variable
	movwf		ZERO
	
	movlw		d'0'	; Initialize "TEMP" variable
	movwf		TEMP

;********* MAIN ******************
main_loop
	
	;************************
	; GP0 => ON
	; GP1 => OFF
	;************************
	call		Check_GP2
	call		Set_W
	
	bsf			GPIO,0
	bcf			GPIO,1
	
	call		DLY

	;************************
	; GP0 => OFF
	; GP1 => ON
	;************************
	call		Check_GP2
	call		Set_W
		
	bcf			GPIO,0
	bsf			GPIO,1
	
	call		DLY
	
	;************************
	; Loop
	;************************
	goto		main_loop

;********* FUNCTIONS ******************	
;Set_W
;{
Set_W

	SUBWF		ZERO,TEMP
	BTFSS		STATUS,Z
	
	retlw		d'5'		; z=0 ==> W => 5

	retlw		d'10'		; z=1 ==> W => 10

;}

;Check_GP2
;{
Check_GP2

	BTFSS		GPIO,2
	
	retlw		d'0'
	
	retlw		d'1'
;}

;DLY_1S
;{
;DLY_1S
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