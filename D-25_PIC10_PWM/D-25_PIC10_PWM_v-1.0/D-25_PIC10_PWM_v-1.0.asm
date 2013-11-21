		list		p=10f200
		#include	<p10f200.inc>

		__CONFIG		_CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

;********* DEFINES ******************
#define	NLOOPS	d'256'

;********* VARIABLES ******************
CNT1		EQU		0x10
LED_1		EQU		0x11

CYCLE		EQU		0x12
LED_TMP		EQU		0x13
LOOP_CNT	EQU		0x14

;********* SETUP: ENVIRONMENT ********
;main
	ORG			0x00

;{
main

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111000'
	TRIS		GPIO

	movlw		b'11000000'

	OPTION

	;Clear data
	clrf		LED_1
	movlw		NLOOPS
	movwf		LOOP_CNT
	
	clrf		CYCLE
;}
;

;main_loop
;{
;********* MAIN ******************
main_loop

	clrf		LED_TMP
	clrf		GPIO
	
	;Judge: LED_1
	bsf			STATUS,C
	movf		LED_1,w
	subwf		CYCLE,w
	
	;Judge: LED_1 > CYCLE
	btfss		STATUS,C
	bsf			LED_TMP,0
	
	movf		LED_TMP,w

	;Output to GPIO	
	movwf		GPIO
	
	;Increment CYCLE
	incf		CYCLE,f
	
	;
	bcf			LED_TMP,0
	
	decfsz		LOOP_CNT,f

	; LOOP_CNT > 0	
	goto		main_loop
	
	; LOOP_CNT = 0
	incf		LED_1,f
	clrf		CYCLE
	goto		back_main
;}
;
;{
back_main

	movlw		NLOOPS
	movwf		LOOP_CNT
	
	goto		main_loop

;}
;	
	
;********* END ******************
	END