	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

; ====================================== VARS
	CBLOCK	020h

	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ	
	
	ENDC

; ====================================== constants
;f_t50u	EQU	0	;timer bit0:51.2μSフラグ
;f_t5mS	EQU	1	;timer bit1:5mSフラグ

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
	
	;MOVLW	03h
	;MOVWF	MASK
	
;	MOVLW	d'98'
;	MOVWF	CNT5mS
;
;	BCF		timer,f_t5mS
	
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
	MOVLW	00h
	
	MOVWF	PORTB

LOOP	

main
	
main_1
	
	MOVLW	03h
	
	MOVWF	PORTB
	
	MOVLW	d'40'		; 40 x 5 ms = 200 ms
	CALL	TX5mS
;	
;	;BTFSC	timer,f_t5mS
;	
;	CALL	LED_2_ON
;	
	GOTO	LOOP
;}
;

; ====================================== LED_2_ON
;{
LED_2_ON

	MOVLW	02h
	
	MOVWF	PORTB

	MOVLW	d'100'
	;MOVLW	PORTB
	
	CALL	TX5mS
	
	;XORWF	MASK,PORTB

	;BCF		timer,f_t5mS
	
	RETURN
;}
;

; ====================================== intr
;{
intr

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; clear flag

	
	MOVLW	01h
	MOVWF	PORTB
	
	MOVLW	d'200'
	CALL	TX5mS

	MOVLW	02h
	MOVWF	PORTB

	MOVLW	d'100'
	CALL	TX5mS

	MOVLW	00h
	MOVWF	PORTB

	CLRF	TMR0

	BSF		INTCON,TMR0IE	; forbid timer interrupt
	BSF		INTCON,GIE		; forbid global interrupt

	RETURN
	
;intr_1

;	DECFSZ	CNT5mS,F
;	
;	GOTO	intr9
;	
;	MOVLW	d'50'
;	MOVWF	CNT5mS
	
	;BSF		timer,f_t5mS

;intr9
	;------------------- reset
	;BSF		INTCON,TMR0IE	; permit timer interrupt
	;BSF		INTCON,GIE		; permit global interrupt
	

	;RETURN

;}
;

;
; ====================================== TX5mS
;{TX5mS
; ＜＜　X * 5mS 待つサブルーチン　＞＞   
TX5mS
	;MOVLW	d'200'
	MOVWF	C1S		; ループ回数として200をセット）
T1SLP	
	CALL	T5mS		; 5mS待つ
	DECFSZ	C1S,F		; ループ回数−１して０になったら次の命令をスキップ
	GOTO	T1SLP		;
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　5mS待つサブルーチン　＞＞   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ループ回数として25をセット）
T5mLP	
	CALL	T02mS		; 0.2mS待つ
	DECFSZ	C5mS,F		; ループ回数−１して０になったら次の命令をスキップ
	GOTO	T5mLP
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　0.2mS待つサブルーチン　＞＞   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ループ回数として249をセット
T02mLP	
	NOP			; 何もせず１サイクル消費
	DECFSZ	C02mS,F		; ループ回数−１して０になったら次の命令をスキップ
	GOTO	T02mLP
	RETURN			; このサブルーチン呼出し元に戻る

;}
;

	END