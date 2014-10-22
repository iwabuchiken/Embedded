
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	CBLOCK	020h
	
	sel7seg
	char
	
	cnt
	
	ENDC

;=========================== memory
;{
;memory

;	; EEPROM Data
;	org		0x2100
;	
;	de		0Ah, 0Bh
;	
;	;de		"Timer Program"
;	;de		0x00, D'34', 'Z'
;
;}
;


	ORG	0		;リセットの入口
	GOTO	init

	ORG	4		;割込みの入口
;



; -----------------------------------------------------
; 初期処理
;=========================== init
;{
init
	bsf		STATUS, RP0	; bank 1
	
	;bcf		OPTION_REG, NOT_RBPU
	movlw	B'00000000'	; RB0~RB3 -> outputs
	movwf	TRISB
	movlw	B'01110000'	; RA0~3 -> outputs
						; RA4~6	-> inputs
						; RA7	-> output
						
	movwf	TRISA
	
	; ADC
	MOVLW	0h
	MOVWF	ANSEL
	
	bcf	STATUS,RP0	; bank 0
	
	;------------ PORTA
	MOVLW	0h
	MOVWF	PORTA

	;------------ vars
	MOVLW	0h
	MOVWF	cnt
	
;}
;

;=========================== memory
;{
;memory
;
;	; EEPROM Data
;	org	0x2100
;	de	"Timer Program"
;	de	0x00, D'34', 'Z'
;
;}
;

; -----------------------------------------------------
;=========================== main
;{
; メイン処理
main
	
	; sel7seg
	MOVLW	01h		; digit 1	
	MOVWF	sel7seg
	
	; char
	;MOVLW	05h
	MOVLW	07h
	MOVWF	char
	
main1
	
	;debug
	BANKSEL PORTA
	
	BCF		PORTA,7
	BSF		PORTA,7
	BCF		PORTA,7
	

;	MOVF	PORTB,W
;	ANDLW	07H		; 0000 0111
;	
;	SUBLW	01H
;	
;	BTFSS	STATUS,Z	; 01h?
;						; if yes, goto DIGIT_1
	
	BTFSS	PORTA,4		; if the button pushed
						;	--> DIGIT_2
	
	GOTO	DIGIT_1		; RB4 --> L(i.e. button being not pushed)
	GOTO	DIGIT_2		; RB4 --> H(i.e. button being pushed)

DIGIT_1

	MOVLW	01H
	MOVWF	char
	
	GOTO	DISPLAY

DIGIT_2

	;MOVLW	02H
	;MOVWF	char
	CALL	WRITE_MEMORY
	
	GOTO	DISPLAY

DISPLAY

	CALL	chg7seg
	
	GOTO	main1

;}
;

; -----------------------------------------------------
;====================== WRITE_MEMORY
;{
WRITE_MEMORY

	;increment cnt
	INCFSZ	cnt,F
	GOTO	RESET_CNT
	GOTO	WRITE

RESET_CNT

	MOVLW	0FFh
	MOVWF	cnt

WRITE
	;debug
	BANKSEL PORTA
	BSF		PORTA,7

	;REF http://cai.cs.shinshu-u.ac.jp/susi/Lecture/microcomp/d_07-08.html "データを書き込むために"
	BANKSEL	INTCON
	BCF		INTCON,GIE	;Disable INTs.
	
	;REF http://ktsite.ddo.jp/PIC/16f88/EEPROM.html?PHPSESSID=aebaedf74eee0cfadb4e9fb393447fb4
	; setup: write
	BANKSEL	EECON1		;Select Bank of EECON1
	BTFSC	EECON1,WR	;Wait for write
	GOTO	$-1		;to complete
	
	; addressing
	BANKSEL	EEADR		;Select Bank of EEADR
	MOVLW	08h
	;MOVF	addr,W		;データアドレス指定
	MOVWF	EEADR		;Data Memory Address to write
	
	; prep: data
	MOVLW	0Eh
	;MOVF	value,W		;書き込むデータ
	MOVWF	EEDATA		;Data Memory Value to write
	
	; write: setup
	BANKSEL	EECON1		;Select Bank of EECON1
	BCF		EECON1,EEPGD	;Point to DATA memory
	BSF		EECON1,WREN	;Enable writes
	
	BCF		INTCON,GIE	;Disable INTs.
	
	; write: pre-defined sequence
	;MOVLW	55h
	MOVLW	055h
	MOVWF	EECON2		;Write 55h
	;MOVLW	AAh
	MOVLW	0AAh
	MOVWF	EECON2		;Write AAh
	
	;debug
	;BSF		PORTA,7
	
	; write: begin
	BSF	EECON1,WR	;Set WR bit to begin write
	
	;debug
	;BCF		PORTA,7
	
	BSF	INTCON,GIE	;Enable INTs.
	BCF	EECON1,WREN	;Disable writes

	; BANKSEL => reset
	BANKSEL	PORTA

	; report
	;BSF		PORTA,7
	BCF		PORTA,7

	RETURN

;}
;

;====================== READ_MEMORY
;{
READ_MEMORY

	MOVLW	0h
	
	; address	
	BANKSEL	EEADR
	MOVWF	EEADR
	
	; read
	BANKSEL	EECON1		;Select Bank of EECON1
	BCF		EECON1,EEPGD	;Point to Data memory
	BSF		EECON1,RD	;読み出し開始
	
	; move data
	BANKSEL	EEDATA		;Select Bank of EEDATA
	MOVF	EEDATA,W		;Wreg = EEDAT
	
	; back to BANK0
	BANKSEL	PORTB
	
	; data to char
	MOVWF	char		; W -> char
	
	RETURN
	
;}
;

;====================== chg7seg
;{
; ７セグメントＬＥＤ表示切り替え
chg7seg
	;MOVLW	078h
	;ANDWF	PORTA,F		;全７セグ消灯

;	BCF	STATUS,C
;	RRF	sel7seg,F	;次の７セグへ
;
	BTFSC	sel7seg,0	;７セグ＃１？
	GOTO	chg7seg1	; Yes
	BTFSC	sel7seg,1	;７セグ＃２？
	GOTO	chg7seg2	; Yes

	;MOVLW	04h
	;MOVWF	sel7seg
	GOTO	chg7seg3	;７セグ＃３

chg7seg1


;	BTFSC	PORTB,7
;	BSF	PORTA,7		;NaPiOnの状態を小数点で表示
	;MOVF	BCD1,W
	
	MOVF	char,W
	
	GOTO	chg7seg9

chg7seg2
	

	;BSF	PORTA,7		;小数点を表示
	;edit
	;BSF		PORTB,0		; period
	
	;MOVF	BCD2,W
	GOTO	chg7seg9
chg7seg3
	
	;MOVF	BCD3,W
	;BTFSC	STATUS,Z	;0?
	;GOTO	chg7segX	; Yes
	
	MOVF	char,W

chg7seg9
	CALL	bcd2led		;７セグ表示用１０進数に変換
	MOVWF	PORTB
	MOVF	sel7seg,W
	IORWF	PORTA,F		;７セグ表示
	;MOVWF	PORTA
	
chg7segX
	RETURN

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