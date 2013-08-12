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

;********* SETUP: ENVIRONMENT ********
	ORG			0x00

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111100'
	TRIS		GPIO
	
;********* INITIALIZE: Variables ********

;********* MAIN ******************
MAIN
	
	BTFSS		GPIO,3	; GP3 => Set?
	
	; If GP3 is not set, then make sure
	;	the both LEDS are off. Then, go
	;	back to MAIN
	goto		BOTH_OFF	; Not set
	
	; GP3 is set => Then go to the next step,
	;	i.e. check the status of GP2
	goto		CHCK_GP2
	
;********* FUNCTIONS ******************
CHCK_GP2
	
	BTFSS		GPIO,2	; GP2 => Set?
	
	GOTO		PATTERN_2	; Not set
	GOTO		PATTERN_1	; Set
	
PATTERN_1
	
	BSF			GPIO,0		; GP0 => Set
	BCF			GPIO,1		; GP1 => Clear
	
	GOTO		MAIN		; Back to MAIN

PATTERN_2
	
	BCF			GPIO,0		; GP0 => Clear
	BSF			GPIO,1		; GP1 => Set
	
	GOTO		MAIN		; Back to MAIN

BOTH_OFF
	
	BCF			GPIO,0		; GP0 => Clear
	BCF			GPIO,1		; GP1 => Clear
	
	GOTO		MAIN		; Back to MAIN

;******** END ******************
	END