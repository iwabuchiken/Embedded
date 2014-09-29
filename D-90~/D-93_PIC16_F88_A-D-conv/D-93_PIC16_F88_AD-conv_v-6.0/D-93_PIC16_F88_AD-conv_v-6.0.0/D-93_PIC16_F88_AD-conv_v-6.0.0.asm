	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

;CBLOCK
;{
	CBLOCK	020h
	
	CNT1	
	CNT2
	CNT3

	MEM1
	
	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ
	
	ENDC
;}
;	
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
	
	;------------------ interrupt
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
	BSF		INTCON,PEIE		; all interrupt from peripheries => permitted
							;	--> except masked ones
	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
	BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	
	BCF	STATUS,RP0	;■ページ０に切替え
	BCF	STATUS,RP1	;

;}
;
; ====================================== STEP1
;{
STEP1	

	MOVLW	B'00000000'
	MOVWF	PORTB
	
	GOTO	STEP1
;}
;

; ====================================== Timer0_interrupt
;{
Timer0_interrupt

	MOVLW	B'00000001'
	;MOVLW	B'00000010'
	MOVWF	PORTB

;	;CALL	T5mS
;	CALL	T02mS
;	
;	;MOVLW	B'00000010'
;	;MOVLW	B'00000000'
;	MOVLW	B'00000001'
;	MOVWF	PORTB
;
;	;CALL	T5mS
;	CALL	T02mS
;	
	;----------------- COUNT UP
	;MOVLW	B'11100000'
	MOVLW	B'00000000'
	
	MOVWF	TMR0			; set the initial val to TMR0
	
	BCF		INTCON,TMR0IF	; permit re-interrupt by TMR0
	
	RETURN

;REF block comment http://www.microchip.com/forums/m177800.aspx
;{
;	MOVLW	02h
;	MOVWF	PORTB
;	
;	CALL	DLY_1S
;	
;	MOVLW	01h
;	MOVWF	PORTB
;	
;	CALL	DLY_1S
;	
;	GOTO	LOOP
;}
;
; ====================================== DLY_1S
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

; ====================================== T1S
;T1S
;{    ; ＜＜　1S待つサブルーチン　＞＞   
T1S
	MOVLW	d'200'
	MOVWF	C1S		; ループ回数として200をセット）
T1SLP	CALL	T5mS		; 5mS待つ
	DECFSZ	C1S,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T1SLP		;
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　5mS待つサブルーチン　＞＞   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ループ回数として25をセット）
T5mLP	CALL	T02mS		; 0.2mS待つ
	DECFSZ	C5mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T5mLP
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　0.2mS待つサブルーチン　＞＞   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ループ回数として249をセット
T02mLP	NOP			; 何もせず１サイクル消費
	DECFSZ	C02mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T02mLP
	RETURN			; このサブルーチン呼出し元に戻る
;}
;	

; ====================================== SET_NUM
;SET_NUM
;{
SET_NUM
	ADDWF	PCL,F
	
	RETLW	0FCh	; 1111 1100, 0
	RETLW	060h	; 0110 0000, 1
	RETLW	0DAh	; 1101 1010, 2
;}
;

; ====================================== SET_DIGIT
;{
SET_DIGIT
	ADDWF	PCL,F
	
	RETLW	01h	; 0000 0001, 1
	RETLW	02h	; 0000 0010, 2
	RETLW	04h	; 0000 0100, 4

;}
;
;==================================
	END