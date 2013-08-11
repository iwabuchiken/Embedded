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
	bsf			GPIO,0
	; GP3 = 0
	bcf			GPIO,0

	goto		main_loop

;********* END ******************
	END