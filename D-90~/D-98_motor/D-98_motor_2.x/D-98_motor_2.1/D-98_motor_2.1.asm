
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG  _CONFIG1, _HS_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF
	
	;REF http://homepage3.nifty.com/mitt/pic/pic88_3_1.html
	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

	CBLOCK	020h

	Memory
	MEM1	; store the value of PORTB	
	TIME1	
	TIME2
	TIME3

	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ

	ENDC

;=========================== CONSTANTS
MEMORY_START_ADDR	EQU	03h

WAIT_LENGTH			EQU D'15'		; 15 x 0.2 x 2 = 6 ms		=> w, 1 s/rotate (average)

;=========================== ORG
	ORG	0		;リセットの入口
	GOTO	init

	ORG	4		;割込みの入口
	
; 初期処理
;=========================== init
;{
init
	; change bank
	bsf		STATUS, RP0	; bank 1
	
	; TRISA, TRISB -------------------
	CLRF	TRISA		; RA0~7		=> outputs
	
	movlw	B'00110000'	; RB4,5		=> inputs						
	movwf	TRISB
	
	; ANSEL ------------------------
	MOVLW	0h
	MOVWF	ANSEL

	; change bank	
	bcf	STATUS,RP0	; bank 0
	
	;------------ OPTION_REG
	BSF		OPTION_REG,7	; RBPU		=> 1 (pull-up disabled)
	BSF		OPTION_REG,6	; INTEDG	=> 1 (rising edge)
	BCF		OPTION_REG,5	; T0CS		=> 0 (internal)
	
	BCF		OPTION_REG,4	; T0SE		=> 0 (low-to-high)
	BCF		OPTION_REG,3	; PSA		=> 0 (assigned to Timer0)
	
	BCF		OPTION_REG,2	; PS2		=> 0 (000)
	BCF		OPTION_REG,1	; PS1		=> 0
	BCF		OPTION_REG,0	; PS0		=> 0
	
	;------------ PORTA, PORTB
	CLRF	PORTB		; initial => all off
	
	CLRF	PORTA

	;------------ vars
	
;}
;

; -----------------------------------------------------
;=========================== main
;{
; メイン処理
main

	; get values of RB4,5 --------------------
	MOVF	PORTB,W
	
	ANDLW	B'00110000'		; get => RB4,5
	
	MOVWF	MEM1			; RB4,5 --> MEM1
	
	; dispatch --------------------
	;BTFSS	MEM1,4			; RB4 --> High?
	BTFSC	MEM1,4
	
	CALL	Rotate_R
	
	;BTFSS	MEM1,5			; RB5 --> High?
	BTFSC	MEM1,5
	
	CALL	Rotate_L
	
	; loop --------------------
	GOTO	main
	
;}main
;

;====================== RotateR
;{
Rotate_R

	; debug ---------------------
	BSF		PORTA,0
	BCF		PORTA,1

	MOVLW	B'00000101'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00000110'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001010'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001001'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS

	; debug ---------------------
	BCF		PORTA,0
	BCF		PORTA,1
	
	RETURN
	
;}Rotate_R
;

;====================== Rotate_L
;{
Rotate_L

	; debug ---------------------
	BCF		PORTA,0
	BSF		PORTA,1

	MOVLW	B'00000101'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001001'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001010'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00000110'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	; debug ---------------------
	BCF		PORTA,0
	BCF		PORTA,1

	RETURN
	
;}Rotate_L
;

;====================== COUNT1
;{
COUNT1

	MOVLW	0x16
	MOVWF	TIME1
	
STEPM
	MOVWF	TIME2

STEPM1
	MOVWF	TIME3
	
STEPM2
	DECFSZ	TIME3,1
	GOTO	STEPM2
	
	DECFSZ	TIME2,1
	GOTO	STEPM1
	
	DECFSZ	TIME1,1
	GOTO	STEPM
	
	RETURN
;}
;

; ============================================================
;{
    ; ＜＜　1S待つサブルーチン　＞＞   
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

;====================== T02XmS
;{
T02XmS
	;MOVLW	d'25'
	MOVWF	C5mS		; ループ回数として25をセット）
	
	CALL	T5mLP
	
	RETURN			; このサブルーチン呼出し元に戻る



;}
;


; -----------------------------------------------------
;====================== bcd2led
; ＢＣＤ４ビットを７セグメントＬＥＤ表示用１０進数に変換
;{
bcd2led
	ADDWF	PCL,F

	RETLW	03Fh	;0
	RETLW	006h	;1
	RETLW	05Bh	;2
	RETLW	04Fh	;3
	RETLW	066h	;4
	RETLW	06Dh	;5
	RETLW	07Dh	;6
	RETLW	007h	;7
	RETLW	07Fh	;8
	RETLW	06Fh	;9
	
	RETLW	077h	;A
	RETLW	07Ch	;b
	RETLW	039h	;C
	RETLW	05Eh	;d
	RETLW	079h	;E
	RETLW	071h	;F

;	RETLW	040h	;a
;	RETLW	040h	;b
;	RETLW	040h	;c
;	RETLW	040h	;d
;	RETLW	040h	;e
;	RETLW	040h	;f	
;}
;

	END
; =========================== ここまで ===============================