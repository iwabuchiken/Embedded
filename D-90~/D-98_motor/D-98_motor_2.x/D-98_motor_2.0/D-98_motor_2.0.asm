
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
	MEM1
	TIME1	
	TIME2
	TIME3

	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ
	
	cnt
	
	flag_Rotate
	
	ENDC

;=========================== CONSTANTS
MEMORY_START_ADDR	EQU	03h

;WAIT_LENGTH			EQU D'15'	; Pulse will be
; Pulse will be
								; 	=> LENGTH x 0.2 x 2 (ms)
;WAIT_LENGTH			EQU D'30'	; 30 x 0.2 x 2 = 12 ms
;WAIT_LENGTH			EQU D'60'	; 60 x 0.2 x 2 = 24 ms	=> working
;WAIT_LENGTH			EQU D'30'	; 30 x 0.2 x 2 = 12 ms		=> working

WAIT_LENGTH			EQU D'15'		; 15 x 0.2 x 2 = 6 ms		=> w, 1 s/rotate (average)

DEGREE				EQU D'9'

BIT_1				EQU 0

;=========================== ORG
	ORG	0		;リセットの入口
	GOTO	init

	ORG	4		;割込みの入口
	
;=========================== INTR
;{
INTR

	; steps
	BCF		INTCON,GIE		; global intr => disabled

	; dispatch
	BTFSC	INTCON,INTF		; if RB0-intr flag set
							; => goto INT_RB0
	GOTO	INT_RB0
	GOTO	INT_EXIT
	
INT_RB0

	; disable intr
	BCF		INTCON,INT0IE	; disable => RB0 intr

	; flag => clear
	BCF		INTCON,INT0IF	; disable => RB0 intr

	; test => flag set?
	BTFSC	flag_Rotate,BIT_1

	; process
	;CALL	RotateR_2_PORTA
	CALL	RotateR_90	; flag => set; rotate

	BCF		flag_Rotate,BIT_1	; clear flag
								; => when already cleared
								; => still, execute clearing the flag
								; => b/c --> can't figure out a better
								; => way of coding it
	
	GOTO	intr_1
	;MOVLW	D'
	;CALL	RotateR_X

intr_1

	; reset PORTA
	MOVLW	0h
	MOVWF	PORTA

	;-------------------
	; anti-chattering
	;-------------------	
	;MOVLW	D'5'	; 5 x 0.2 = 1.0 ms
	MOVLW	D'50'	; 50 x 0.2 = 10.0 ms
	CALL	T02XmS
	
;
;	; process
;	BCF		PORTA,0
;	BSF		PORTA,0
;
;	MOVLW	05h
;	CALL	T02XmS	
;
;	BCF		PORTA,0
;
;	; wait
;	;MOVLW	D'5'	; 5 x 0.2 = 1.0 ms
;	MOVLW	05h
;	CALL	T02XmS
;		
	; enable intr
	BSF		INTCON,INT0IE	; eable => RB0 intr

INT_EXIT
	
	RETFIE
	
;}
;


; 初期処理
;=========================== init
;{
init
	; change bank
	bsf		STATUS, RP0	; bank 1
	
	; TRISA, TRISB
	movlw	B'00000001'	; RB1~RB7	=> outputs
						; RB0		=> inputs
	movwf	TRISB
	
	;movlw	B'00000000'	; RA0~7		=> outputs
	movlw	B'00010000'	; RA0~3, 5~7	=> outputs
						; RA4		=> input
	movwf	TRISA
	
	; ANSEL
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
	
	;------------ INTCON
	BSF		INTCON,GIE		; global intr	=> allow
	BSF		INTCON,INT0IE	; rb0 intr 		=> allow
	
	;------------ PORTA, PORTB
	MOVLW	B'00000000'		; initial => all off
	MOVWF	PORTB
	
	
	MOVWF	PORTA

	;------------ vars
	MOVLW	0h
	MOVWF	cnt

	;CLRF	flag_Rotate
	BSF		flag_Rotate,BIT_1	; set flag => interrupt, then rotate
	
;}
;

; -----------------------------------------------------
;=========================== main
;{
; メイン処理
main

main1

	;CALL	RotateR
	;CALL	RotateR_2
	
;	BSF		PORTB,1
;	CALL	COUNT1
;	
;	BCF		PORTB,1
;	CALL	COUNT1
	
	; test => RB4 --> pushed?
	BTFSC	PORTA,4
	
	GOTO	RESET_ROTATE	; RB4 is HIGH --> reset flag
	
	GOTO	main1			; RB4 is LOW --> go back to main1

;}main
;

;=========================== RESET_ROTATE
;{
RESET_ROTATE
	
	; test => flag set?
	BTFSC	flag_Rotate,BIT_1
	
	GOTO	main1	; flag => set; go back to main1
	
	; flag => not set; now, set the flag
	BSF		flag_Rotate,BIT_1
	
	; report
	BCF		PORTA,0
	BSF		PORTA,0
	
	MOVLW	D'5'
	CALL	T02XmS

	BCF		PORTA,0
	
	GOTO	main1

;}RESET_ROTATE
;

;====================== RotateR_X
;{
RotateR_X

	;MOVLW	DEGREE		; D'9'
	MOVWF	cnt

Rotate_X

	CALL	RotateR_2_PORTA
	
	DECFSZ	cnt,F

	GOTO	Rotate_X

END_RotateR_90_X

	RETURN
	
;}RotateR_X
;

;====================== RotateR_90
;{
RotateR_90

	MOVLW	DEGREE		; D'9'
	MOVWF	cnt

Rotate

	CALL	RotateR_2_PORTA
	
	DECFSZ	cnt,F

	GOTO	Rotate

END_RotateR_90

	RETURN
	
;}
;

;====================== RotateR_2_PORTA
;{
RotateR_2_PORTA

	MOVLW	B'00000101'
	MOVWF	PORTA
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00000110'
	MOVWF	PORTA
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001010'
	MOVWF	PORTA
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001001'
	MOVWF	PORTA
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	RETURN
	
;}RotateR_2_PORTA
;

;====================== RotateR_2
;{
RotateR_2

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
	
	RETURN
	
;}
;

;====================== RotateR
;{
RotateR

	MOVLW	B'00000101'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00000110'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00001010'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00001001'
	MOVWF	PORTB
	CALL	COUNT1
	
	RETURN
	
;}
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