	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	ORG		0
	GOTO	INIT

	ORG		4
	CALL	Timer0_interrupt
	RETFIE

; ====================================== INIT
;INIT
;{
INIT
	BSF		STATUS,RP0
	
	;CLRF	ANSEL

	;------------------ TRISB
	CLRF	TRISB		; output

	;------------------ TMR0
	MOVLW	88h
	MOVWF	OPTION_REG
	
	BCF		STATUS,RP0
	
	CLRF	TMR0

	;------------------ RB0 => ON
	MOVLW	01h
	MOVWF	PORTB

	;------------------ interrupt
	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
							; |= 0x20
							
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
							; |= 0x80
	
	;BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	

;}
;
; ====================================== STEP1
;{
STEP1	

	;MOVLW	B'00000000'
	;MOVWF	PORTB
	
	GOTO	STEP1
;}
;

; ====================================== Timer0_interrupt
;{
Timer0_interrupt

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; permit re-interrupt by TMR0

	MOVLW	B'00000001'
	MOVWF	PORTB
	
	MOVLW	B'00000000'
	MOVWF	PORTB
	
	;------------------- reset
	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt
	

	RETURN

;}
;

	END