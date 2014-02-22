;*********************************
; File=D-40_v-1.2_thermo.asm
; Created at=20131120_150108
; e=3
;*********************************
		list		p=10f200
		#include	<p10f200.inc>

		__CONFIG		_CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

;********* DEFINES ******************

;********* VARIABLES ******************
CNT1	EQU		0x10
CNT2	EQU		0x11
CNT3	EQU		0x12

;********* SETUP: ENVIRONMENT ********
;main
	ORG			0x00

;{
main

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111100'
	TRIS		GPIO

;	movlw		b'11000000'

;	OPTION

;}
;

;main_loop
;{
;********* MAIN ******************
main_loop
	
		
	BTFSC	GPIO,3
	
	goto	LED_OFF

	goto	LED_ON

LED_ON
	bsf		GPIO,0
	
	goto	main_loop
	
LED_OFF

	bcf		GPIO,0
	
	goto	main_loop

;********* END ******************
	END