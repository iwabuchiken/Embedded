	list		p=12f629
	#include	<p12f629.inc>
	
	__CONFIG	_CP_OFF & _CPD_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT
	
w_temp		EQU	0x20
CNT1		EQU	0x21
CNT2		EQU	0x22
CNT3		EQU	0x23
O_DATA		EQU	0x24
TMP_DATA	EQU	0x25
	
				ORG		0x000
				goto	main
				
				ORG		0x004
				retfie
				
main
		; Internal clock
		bsf		STATUS,RP0
		call	0x3ff
		movwf	OSCCAL
		bcf		STATUS,RP0
		
		;Interrupt
		clrf	INTCON
		
		; Comparator
		movlw	0x07
		movwf	CMCON
		
		; GPIO
		bsf		STATUS,RP0
		movlw	b'11101000'
		movwf	TRISIO
		
		bcf		STATUS,RP0
		
		clrf	CNT1
		
;main_loop
;{		
main_loop
		; GPIO3 => Lo?
		btfss	GPIO,3
		goto	main_loop

		; Read CNT1
		movf	CNT1,w
		movwf	TMP_DATA
		
		; Extract => 4th bit
		andlw	b'00001000'
		movwf	O_DATA
		
		; 4th bit => to 5th bit
		bcf		STATUS,C
		rlf		O_DATA,f
		movf	TMP_DATA,w
		
		; The remaining first 3 bits
		andlw	b'00000111'
		iorwf	O_DATA,f
		
		; Output data
		movf	O_DATA,w
		movwf	GPIO
		
		call	DLY_1
		
		incf	CNT1,f
		
		goto	main_loop

;}
;

;DLY_1
;{		
DLY_1
	movlw		d'20'
	movwf		CNT2
	
DLY_1L
	decfsz		CNT2,f
	goto		DLY_1L
	
	return
;}
;
	END