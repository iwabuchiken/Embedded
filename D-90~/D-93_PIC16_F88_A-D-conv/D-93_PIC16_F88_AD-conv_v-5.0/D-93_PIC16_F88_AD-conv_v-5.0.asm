	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	;__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRITE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

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
	
	ORG		0
;}
;

; ====================================== MAIN
;MAIN
;{
MAIN
	BSF		STATUS,RP0
	CLRF	ANSEL

	;------------------ TRISB
	CLRF	TRISB		; output
	
	;------------------ TRISA
	MOVLW	018h
	MOVWF	TRISA		;RA0,1,2は出力，RA3,4は入力
	
	BCF	STATUS,RP0	;■ページ０に切替え

;}
;
; ====================================== LOOP
;{
LOOP
	;------------------- digit 3
	CLRF	PORTB
	
	MOVLW	d'0'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'0'
	CALL	SET_NUM
	MOVWF	PORTB
	
	CALL	T02mLP
	
	;------------------- digit 2
	CLRF	PORTB
	
	MOVLW	d'1'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'1'
	CALL	SET_NUM
	MOVWF	PORTB

	CALL	T02mLP
		
	;------------------- digit 1
	CLRF	PORTB
	
	MOVLW	d'2'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'2'
	CALL	SET_NUM
	MOVWF	PORTB
	
	CALL	T02mLP
	
	GOTO	LOOP
;}
;

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