	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

; ====================================== VARS
	CBLOCK	020h
	save_st		;STATUSのセーブ
	save_w		;W-regのセーブ
	timer		;1:996mS
	CNT5mS		;5mSカウンタ＝９８（51.2uS×98＝5.02mS）
	ADsaveH		;ADRESH保存
	ADsaveL		;ADRESL保存
	sel7seg		;7セグメントLED選択
	
	MASK
	
	ENDC

; ====================================== constants
f_t50u	EQU	0	;timer bit0:51.2μSフラグ
f_t5mS	EQU	1	;timer bit1:5mSフラグ

; ====================================== ORG 0
	ORG		0
	GOTO	INIT

; ====================================== ORG 4
	ORG		4
	CALL	intr
	
	RETFIE

; ====================================== INIT
;INIT
;{
INIT

	;------------------ switch bank
	BSF		STATUS,RP0
	
	;------------------ ANSEL
	CLRF	ANSEL

	;------------------ TRISB, TRISB
	CLRF	TRISB		; output
	CLRF	TRISA		; output

	;------------------ RB0 => ON, RA => OFF
	;MOVLW	01h
	;MOVWF	PORTB

	;MOVLW	00h
	;MOVWF	PORTA
	
	;------------------ OPTION_REG
	MOVLW	88h
	MOVWF	OPTION_REG
	;MOVLW	88h
	;MOVWF	OPTION_REG
	
	;------------------ switch bank
	BCF		STATUS,RP0
	
	;------------------ vars
	MOVLW	01h
	MOVWF	PORTB
	
	MOVLW	03h
	MOVWF	MASK
	
	MOVLW	d'98'
	MOVWF	CNT5mS

	BCF		timer,f_t5mS
	
	;------------------ interrupt
	CLRF	TMR0

	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
							; |= 0x20
							
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
							; |= 0x80
	
	;BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	

;}
;
; ====================================== LOOP
;{
LOOP	

main
	
main_1
	
	MOVLW	01h
	
	MOVWF	PORTB
	
	BTFSC	timer,f_t5mS
	
	CALL	LED_ON
	
	GOTO	LOOP
;}
;

; ====================================== LED_ON
;{
LED_ON

	MOVLW	02h
	
	MOVWF	PORTB

	;MOVLW	PORTB
	
	;XORWF	MASK,PORTB

	BCF		timer,f_t5mS
	
	RETURN
;}
;

; ====================================== Timer0_interrupt
;{
intr

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; clear flag

intr_1

	DECFSZ	CNT5mS,F
	
	GOTO	intr9
	
	MOVLW	d'98'
	MOVWF	CNT5mS
	
	BSF		timer,f_t5mS

intr9
	;------------------- reset
	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt
	

	RETURN

;}
;

	END