		list		p=10f200
		#include	<p10f200.inc>

		__CONFIG		_CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

;********* VARIABLES ******************
CNT1	EQU		0x10
CNT2	EQU		0x11
CNT3	EQU		0x12

;********* SETUP: ENVIRONMENT ********
	ORG			0x00

	movwf		OSCCAL
	bcf			OSCCAL,FOSC4

	movlw		b'11111110'
	TRIS		GPIO

;********* MAIN ******************
main_loop
	
	;GP3 => On? (GP3 = 1)
	BTFSC		GPIO,3
	
	; GP3 = 1
	goto		dly_100ms
	; GP3 = 0
	goto		dly_1S

;LED_on_off
;{
LED_on_off
	
	bsf			GPIO,0
	;call		DLY_1S
	call		DLY

	bcf			GPIO,0
	;call		DLY_1S
	call		DLY
	
	goto		main_loop

;}
;********* FUNCTIONS ******************	
dly_100ms
	movlw		d'1'
	goto		LED_on_off

dly_1S
	movlw		d'10'
	goto		LED_on_off


;DLY_1S
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
;}
	
;********* END ******************
	END