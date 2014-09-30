	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	ORG		0
	GOTO	START

	ORG		4
	CALL	Timer0_interrupt
	RETFIE

; ====================================== START
;START
;{
START
	BSF		STATUS,RP0
	BCF		STATUS,RP1
	
	CLRF	ANSEL

	;------------------ TRISB
	CLRF	TRISB		; output

	;------------------ TMR0
	BCF		OPTION_REG,T0CS		; FOSC, FOSC/4 = XMh/4
	BCF		OPTION_REG,PSA		; pre-scaler to TMR0
								; 	=> PSA = 1, then pre-scaler to WDT
	BSF		OPTION_REG,PS2
	BSF		OPTION_REG,PS1
	BSF		OPTION_REG,PS0		; TMR0 clock => FOSC/4/256

	;------------------ TMR0 => reset
	MOVLW	B'00000000'
	
	MOVWF	TMR0			; set the initial val to TMR0
	
	;------------------ interrupt
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
	BSF		INTCON,PEIE		; all interrupt from peripheries => permitted
							;	--> except masked ones
	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
	BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	
	BCF	STATUS,RP0	;Å°ÉyÅ[ÉWÇOÇ…êÿë÷Ç¶
	BCF	STATUS,RP1	;
	
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

	MOVLW	B'00000001'
	MOVWF	PORTB
	
	MOVLW	B'00000000'
	MOVWF	PORTB
	
	;------------------- TMR0
;	MOVLW	B'11100000'
;	
;	MOVWF	TMR0			; set the initial val to TMR0
;	
	BCF		INTCON,TMR0IF	; permit re-interrupt by TMR0
	
	RETURN

;}
;

	END