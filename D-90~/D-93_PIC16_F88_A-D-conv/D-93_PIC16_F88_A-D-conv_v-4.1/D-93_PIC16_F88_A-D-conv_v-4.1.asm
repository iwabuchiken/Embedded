	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	;__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRITE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

	CBLOCK	020h
	
	CNT1	
	CNT2
	CNT3
	
	ENDC
	
	ORG		0

MAIN
	BSF		STATUS,RP0
	CLRF	ANSEL
	CLRF	TRISB
	BCF		STATUS,RP0

LOOP
	MOVLW	02h
	MOVWF	PORTB
	
	CALL	DLY_1S
	
	MOVLW	01h
	MOVWF	PORTB
	
	CALL	DLY_1S
	
	GOTO	LOOP

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