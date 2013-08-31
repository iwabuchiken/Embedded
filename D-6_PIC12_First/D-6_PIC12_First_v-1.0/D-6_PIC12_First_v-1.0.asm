	list		p=12f629
	#include	<p12f629.inc>
	
	__CONFIG	_CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT
	
CNT1		EQU	0x20
CNT2		EQU	0x21
CNT3		EQU	0x22
	
				ORG		0x000
				goto	main
				
				ORG		0x004
				retfie
				
main

		bsf		STATUS,RP0
		call	0x3ff
		movwf	OSCCAL
		bcf		STATUS,RP0
		
		clrf	INTCON
		
		movlw	0x07
		movwf	CMCON
		
		bsf		STATUS,RP0
		bcf		TRISIO,0
		bcf		STATUS,RP0
;main_loop
;{		
main_loop
		bsf		GPIO,0
		call	DLY_1S
		bcf		GPIO,0
		call	DLY_1S
		
		goto	main_loop

;}
;

;DLY_1S
;{		
DLY_1S
	movlw		d'10'
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
;
	END