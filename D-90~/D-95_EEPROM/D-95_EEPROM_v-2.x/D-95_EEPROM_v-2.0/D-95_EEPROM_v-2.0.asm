
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	CBLOCK	020h
	
	sel7seg
	char
	
	ENDC

;=========================== memory
;{
;memory

	; EEPROM Data
	org		0x2100
	
	de		0Ah, 0Bh
	
	;de		"Timer Program"
	;de		0x00, D'34', 'Z'
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

;	MOVF	PORTB,W
;	ANDLW	07H		; 0000 0111
;	
;	SUBLW	01H
;	
;	BTFSS	STATUS,Z	; 01h?
;						; if yes, goto DIGIT_1
	
	BTFSS	PORTA,4
	
	GOTO	DIGIT_2
	GOTO	DIGIT_1

DIGIT_1

	MOVLW	01H
	MOVWF	char
	
	GOTO	DISPLAY

DIGIT_2

	;MOVLW	02H
	;MOVWF	char
	CALL	GET_MEMORY
	
	GOTO	DISPLAY

DISPLAY

	CALL	chg7seg
	
	GOTO	main1

;}
;

; -----------------------------------------------------
;====================== GET_MEMORY
;{
GET_MEMORY

	MOVLW	0h
	
	;BANKSEL	PORTA
	
	
	;BANKSEL	PO
	
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
	
;	bsf		STATUS,RP0	; レジスタバンク１を選択
;	
;	BCF		EECON1,EEPGD
;	bsf		EECON1, RD	; EEPROM データを読みとる
;	
;	bcf		STATUS, RP0	; レジスタバンク０を選択
;	
;	;movf	EEDATA, 0	; EEPROM データ → W レジスタ
;	movf	EEDATA,W
;	
;	MOVWF	char		; W -> char

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