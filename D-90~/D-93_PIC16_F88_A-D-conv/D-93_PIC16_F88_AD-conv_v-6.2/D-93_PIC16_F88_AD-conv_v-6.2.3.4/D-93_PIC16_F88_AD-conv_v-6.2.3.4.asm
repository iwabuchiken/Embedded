	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

; ====================================== VARS
	CBLOCK	020h

	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ	

	CNT5mS
	timer		;1:996mS	

	CNT			; counter
	
	ADsaveL
	ADsaveH
	
	sel7seg
	
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
	;CLRF	ANSEL

	;------------------ TRISB, TRISB
	CLRF	TRISB		; output
	CLRF	TRISA		; output

	;------------------ OPTION_REG
	MOVLW	88h
	MOVWF	OPTION_REG
	
	;------------------ switch bank
	BCF		STATUS,RP0
	
	;------------------ A/D
	MOVLW	099h	; 1001 1001
	MOVWF	ADCON0
	
	BSF		STATUS,RP0	; BANK 1
	
	MOVLW	80h		; 1000 0000
	MOVWF	ADCON1
	
	MOVLW	08h		; 0000 1000
	MOVWF	ANSEL
	
	BCF		STATUS,RP0	; BANK 0
	
	;------------------ ADC
	; start ADC
	BSF		ADCON0,GO
	
ADC
	
	BTFSC	ADCON0,GO	; ADC --> done?
	GOTO	ADC			; NO

	; get values
	MOVF	ADRESH,W
	MOVWF	ADsaveH
	
	BSF		STATUS,RP0
	
	MOVF	ADRESL,W
	
	BCF		STATUS,RP0
	
	MOVWF	ADsaveL
	
	;------------------ PORTA,B
	MOVLW	0h
	MOVWF	PORTB
	
	MOVLW	03h
	MOVWF	PORTA
	
	;------------------ vars
		
	MOVLW	d'98'
	MOVWF	CNT5mS
	
	; timer
	BCF		timer,f_t5mS
	
	;------------------ interrupt
	CLRF	TMR0

	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
							; |= 0x20
							
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
							; |= 0x80
;}
;

; ====================================== LOOP
;{
	MOVLW	00h
	
	MOVWF	PORTB

LOOP	

	BTFSC	timer,f_t5mS
	
	;CALL	LED_ON
	CALL	chg7seg
	
	GOTO	LOOP
;}
;

; ====================================== LED_ON
;{
LED_ON

	MOVLW	01h
	
	MOVWF	PORTB

	BCF		INTCON,TMR0IE	; permit timer interrupt
	BCF		INTCON,GIE		; permit global interrupt

	; wait => 
	MOVLW	d'5'	; 5 * 0.2ms = 1.0ms
	
	;CALL	TX5mS
	CALL	TX02mS
	;XORWF	MASK,PORTB

	MOVLW	00h
	
	MOVWF	PORTB

	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt

	; reset TMR0
	CLRF	TMR0

	BCF		timer,f_t5mS
	
	RETURN
;}
;

; ====================================== intr
;{
intr

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; clear flag

	MOVLW	0h
	MOVWF	PORTB	

	DECFSZ	CNT5mS,F	;5mS経過？
	GOTO	intr9		; No
	
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS経過フラグセット

;	MOVLW	01h
;	MOVWF	PORTB
;	
;	MOVLW	d'200'
;	CALL	TX5mS
;
;	MOVLW	02h
;	MOVWF	PORTB
;
;	MOVLW	d'100'
;	CALL	TX5mS
;
;	MOVLW	00h
;	MOVWF	PORTB

	CLRF	TMR0

intr9
	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt

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
	DECFSZ	C1S,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T1SLP		;
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　5mS待つサブルーチン　＞＞   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ループ回数として25をセット）
T5mLP	
	CALL	T02mS		; 0.2mS待つ
	DECFSZ	C5mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T5mLP
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　0.2mS待つサブルーチン　＞＞   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ループ回数として249をセット
T02mLP	
	NOP			; 何もせず１サイクル消費
	DECFSZ	C02mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T02mLP
	RETURN			; このサブルーチン呼出し元に戻る

;}
;

;
; ====================================== TX02mS
;{TX02mS
TX02mS

	MOVWF	C5mS		; 

	CALL	T5mLP

	RETURN			; このサブルーチン呼出し元に戻る

;}
;

;====================================== chg7seg
;{
chg7seg
	CLRF	PORTA		;全７セグ消灯

	BCF		STATUS,C
	RRF		sel7seg,F	;次の７セグへ

	BTFSC	sel7seg,0	;７セグ＃１？
	GOTO	chg7seg1	; Yes
	BTFSC	sel7seg,1	;７セグ＃２？
	GOTO	chg7seg2	; Yes

	MOVLW	04h
	MOVWF	sel7seg
	GOTO	chg7seg3	;７セグ＃３
;}
;

;====================================== chg7seg1
;{
chg7seg1
	MOVF	ADsaveL,W
	ANDLW	0Fh		;ADRESLの下位４ビットの取り出し
	CALL	bin2hex		;７セグ表示用１６進数に変換
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg2
	SWAPF	ADsaveL,W
	ANDLW	0Fh		;ADRESLの上位４ビットの取り出し
	CALL	bin2hex		;７セグ表示用１６進数に変換
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg3
	MOVF	ADsaveH,W	;ADRESHを
	
	ANDLW	0Fh
	
	CALL	bin2hex		;７セグ表示用１６進数に変換
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	MOVWF	PORTA		;７セグ表示
	RETURN

;}
;

; ====================================== bin2hex
;{ バイナリ４ビットを７セグメントＬＥＤ表示用１６進数に変換
bin2hex
	ADDWF	PCL,f

	RETLW	0FCh	;0
	RETLW	060h	;1
	RETLW	0DAh	;2
	
	RETLW	0F2h	;3
	RETLW	066h	;4
	RETLW	0B6h	;5
	
	RETLW	0BEh	;6
	RETLW	0E4h	;7
	RETLW	0FEh	;8
	RETLW	0F6h	;9
	
	RETLW	0EEh	;A
	RETLW	03Eh	;b
	RETLW	09Ch	;C
	
	RETLW	07Ah	;d
	RETLW	09Eh	;E
	RETLW	08Eh	;F
	
	RETLW	06Eh	;10h
;}
;

	END