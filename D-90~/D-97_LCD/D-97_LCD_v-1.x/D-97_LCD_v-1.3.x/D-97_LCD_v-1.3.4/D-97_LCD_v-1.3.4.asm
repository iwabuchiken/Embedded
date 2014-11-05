; ========================== ここから ==============================
;	PIC16F84A
;	clock:20MHz
;
;	ＬＣＤを４ビットで制御
;
;	ＰＩＣのピン接続
;		RB0	LCD DB4
;		RB1	LCD DB5
;		RB2	LCD DB6
;		RB3	LCD DB7
;
;		RA0	LCD R/W	(6:Read/Write)
;		RA1	LCD E	(5:Enable Signal)
;		RA2	LCD RS	(4:Register Select)
;
;	使用タイマ（プログラムループ）
;		 15mS	ＬＣＤパワーオンリセット待ち
;		  5mS	ＬＣＤ初期化ルーチン
;		  1mS	ＬＣＤ初期化ルーチン
;		 50uS	ＬＣＤ初期化ルーチン，書き込み待ち
;


       ;LIST    P=PIC16F84A
       ;INCLUDE P16F84A.INC
		LIST      P=PIC16F88
		#INCLUDE  P16F88.INC
       ;__CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

	CBLOCK	020h
	save_st			;STATUSのセーブ
	save_w			;W-regのセーブ
	CNT15mS			;15ｍＳカウンタ
	CNT5mS			;5ｍＳカウンタ
	CNT1mS			;1ｍＳカウンタ
	CNT50uS			;50μＳカウンタ
	char			;LCD表示データ
	
	CHR				; LCS char data
	
	VAL				; hex value
	
	HEX_ORIG		; original hex value
	HEX_CHRS_1		; hex value converted to chars
	HEX_CHRS_2		; hex value converted to chars

	TMP				; used in swapping the W register value
		
	ENDC

RW	EQU	00h		;LCD R/W
E	EQU	01h		;LCD Enable
RS	EQU	02h		;LCD Register Select

;*********************
BUSY	EQU	07h
;*********************
;BUSY	EQU	03h		;BUSY FLAG (PORTB,3)

;MSG	EQU	0AFh
MSG	EQU	0CEh

; ==================== 初期処理 =====================
;{
	org	0
init
	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2は出力
	;MOVLW	0F0h
	MOVLW	0h
	MOVWF	TRISB		;RB0-3は出力
	
	; ADC
	MOVLW	0h
	MOVWF	ANSEL

	BCF	STATUS,RP0	;■バンク０に切替え

	CLRF	PORTA
	CLRF	PORTB

	;----------------- debug: 1-1
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms


	CALL	LCD_init	;LCD 初期化

	;----------------- vars
	MOVLW	30h		; '0'
	MOVWF	CHR

	MOVLW	0EAh		;
	MOVWF	VAL

	;----------------- debug: 1-1-1-1
	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms
	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

;}
;
	
; ==================== メイン処理 =====================
;{main
main

	;------------------- line: 1
	CALL	LCD_home	;カーソルを１行目の先頭に
	
	;----------------- debug: 5-1
	BCF		PORTB,0

	BSF		PORTB,0
	CALL	wait5ms
	BCF		PORTB,0
	CALL	wait1ms
	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms
	
	;---------- label
	CALL	SHOW_LABEL
	
	;---------- set message
	MOVLW	MSG
	MOVWF	HEX_ORIG
	
	CALL	hex2HexChars
	
	;---------- digit: 1
	MOVF	HEX_CHRS_1,W
	
	CALL	LCD_write
	
	;---------- digit: 2
	MOVF	HEX_CHRS_2,W
	
	CALL	LCD_write
	
	;-------------------- ending
	CLRF	PORTA
	CLRF	PORTB

	;----------------- debug: 5-1-1
	BCF		PORTB,0

	BSF		PORTB,0
	CALL	wait5ms
	BCF		PORTB,0
	CALL	wait1ms
	
	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms


	SLEEP

	GOTO	main

;}
;main

;================= SHOW_LABEL
;{
SHOW_LABEL

	MOVLW	'D'	
	CALL	LCD_write

	MOVLW	'e'	
	CALL	LCD_write

	MOVLW	'g'	
	CALL	LCD_write

	MOVLW	'r'	
	CALL	LCD_write

	MOVLW	'e'	
	CALL	LCD_write

	MOVLW	'e'	
	CALL	LCD_write

	MOVLW	'='	
	CALL	LCD_write

	RETURN

;}
;

;
;================= hex2HexChars
;{
;	Convert hex value in HEX_ORIG
;	into a char code, contained in HEX_CHRS
hex2HexChars
	
	;-------------------
	;	digit: 1
	;-------------------
	; e.g. HEX_ORIG is 0CBh
	
	SWAPF	HEX_ORIG,W	; 1100 1011 (CB)
						;	--> W = 1011 1100 (BC)
	
	ANDLW	0Fh			; W = 0000 1100 (0C)

	ADDLW	037h		; W = 0100 0011 (43 = 'C' in S1602)

	MOVWF	HEX_CHRS_1	;

	;-------------------
	;	digit: 2
	;-------------------
	MOVF	HEX_ORIG,W	; W = 1100 1011 (CB)
	
	ANDLW	0Fh			; W = 0000 1011 (0B)
	
	ADDLW	037h		; W = 0100 0010 (42 = 'B')

	MOVWF	HEX_CHRS_2	;
		
	RETURN

;}
;hex2HexChars


;
;================= ＬＣＤ表示をクリアする ===================
;{
LCD_clear
	MOVLW	01h
	CALL	LCD_command
	RETURN

;================= ＬＣＤのカーソル位置を先頭に戻す =========
LCD_home
	MOVLW	02h
	CALL	LCD_command
	RETURN

;================= ＬＣＤのカーソル位置を２行目の先頭に =====
LCD_2line
	MOVLW	0C0h
	CALL	LCD_command
	RETURN

;================= ＬＣＤのディスプレイをＯＮにする =========
LCD_on
	MOVLW	0Ch
	CALL	LCD_command
	RETURN

;================= ＬＣＤのディスプレイとカーソルをＯＮにする ==
LCD_on_cur
	MOVLW	0Eh
	CALL	LCD_command
	RETURN

;================= ＬＣＤのディスプレイをＯＦＦにする =======
LCD_off
	MOVLW	08h
	CALL	LCD_command
	RETURN
;}
;LCD_clear

;================= ＬＣＤにデータを送る =====================
;{
LCD_write
	MOVWF	char
	CALL	LCD_BF_wait	;LCD busy 解除待ち

	BCF	PORTA,RW	;R/W=0(Write)
	BSF	PORTA,RS	;RS=1(Data)

	;------------- Upper 4 bits
	MOVLW	0Fh			; clear PORTB,4-7
	
	ANDWF	PORTB,F
						; e.g. char = 042h
	MOVF	char,W		; W = 0100 0010 (42)
	ANDLW	0F0h		; W = 0100 0000 (40)
	
	IORWF	PORTB,F

	BSF	PORTA,E		;ＬＣＤにデータ書き込み
	NOP
	BCF	PORTA,E

	;------------- Lower 4 bits
	MOVLW	0Fh			; clear PORTB,4-7
	ANDWF	PORTB,F

	SWAPF	char,W		; W = 0010 0100 (24)
	ANDLW	0F0h		; W = 0010 0000 (20)
	
	IORWF	PORTB,F
		
	BSF	PORTA,E		;ＬＣＤにデータ書き込み
	NOP
	BCF	PORTA,E
	
;	MOVLW	0F0h		;PORTBの下位４ビットを
;	ANDWF	PORTB,F		;　クリア
;	SWAPF	char,W		;上位
;	ANDLW	0Fh		;４ビットを
;	IORWF	PORTB,F		;PORTB(3-0)にセット（PORTB(7-4)はそのまま）
;	BSF	PORTA,E		;ＬＣＤにデータ書き込み
;	NOP
;	BCF	PORTA,E

;	MOVLW	0F0h		;PORTBの下位４ビットを
;	ANDWF	PORTB,F		;　クリア
;	MOVF	char,W		;下位
;	ANDLW	0Fh		;４ビットを
;	IORWF	PORTB,F		;PORTB(3-0)にセット（PORTB(7-4)はそのまま）
;	BSF	PORTA,E		;ＬＣＤにデータ書き込み
;	NOP
;	BCF	PORTA,E

	RETURN
;}
;LCD_write

;================= ＬＣＤにコマンドを送る ===================
;{
LCD_command
	MOVWF	char
	CALL	LCD_BF_wait	;LCD busy 解除待ち

	BCF	PORTA,RW	;R/W=0(Write)
	BCF	PORTA,RS	;RS=0(Command)

	MOVLW	0F0h		;PORTBの下位４ビットを
	
	; swap
	MOVWF	TMP
	SWAPF	TMP,W
	
	
	ANDWF	PORTB,F		;　クリア		==> i.e. AND with '0000'
	
	SWAPF	char,W		;上位
	ANDLW	0Fh		;４ビットを
	
	; swap
	MOVWF	TMP
	SWAPF	TMP,W
	
	
	IORWF	PORTB,F		;PORTB(3-0)にセット（PORTB(7-4)はそのまま）
	BSF	PORTA,E		;ＬＣＤにデータ書き込み
	NOP
	BCF	PORTA,E

	MOVLW	0F0h		;PORTBの下位４ビットを
	
	; swap
	MOVWF	TMP
	SWAPF	TMP,W
	
	
	ANDWF	PORTB,F		;　クリア
	MOVF	char,W		;下位
	ANDLW	0Fh		;４ビットを

	; swap
	MOVWF	TMP
	SWAPF	TMP,W

	IORWF	PORTB,F		;PORTB(3-0)にセット（PORTB(7-4)はそのまま）

	BSF	PORTA,E		;ＬＣＤにデータ書き込み
	NOP
	BCF	PORTA,E

	RETURN
;}
;LCD_command

;================= LCD Busy 解除待ち ========================
;{
LCD_BF_wait
	BCF	PORTA,E
	BCF	PORTA,RS	;RS=0(Control)
	BSF	PORTA,RW	;R/W=1(Read) Busy Flag read

	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	0FFh
	MOVWF	TRISB		;RB0-7は入力
	BCF	STATUS,RP0	;■バンク０に切替え
	BSF	PORTA,E		;ＬＣＤ上位４ビット読み込み
	NOP
	BTFSS	PORTB,BUSY	;LCD Busy ?
	GOTO	LCD_BF_wait1	; No
	BCF	PORTA,E
	NOP
	BSF	PORTA,E		;ＬＣＤ下位４ビット読み飛ばし
	NOP
	BCF	PORTA,E
	GOTO	LCD_BF_wait

LCD_BF_wait1
	BSF	PORTA,E		;ＬＣＤ下位４ビット読み飛ばし
	NOP
	BCF	PORTA,E
	BSF	STATUS,RP0	;■バンク１に切替え
	
	;******************
	MOVLW	0h
	
	;******************
	;MOVLW	0F0h		;RB0-3は出力
	
	
	MOVWF	TRISB
	BCF	STATUS,RP0	;■バンク０に切替え

	RETURN
;}
;LCD_BF_wait


;================= LCD初期化 ================================
;{LCD_init
LCD_init
	CALL	wait15ms	;15mS待つ
	BCF	PORTA,RW	;R/W=0
	BCF	PORTA,RS	;RS=0
	BCF	PORTA,E		;E=0

;	MOVLW	0F0h		;PORTBの上位４ビットを
;	ANDWF	PORTB,W		;取り出す（変更しないように）



;	IORLW	03h		;下位４ビットに'３'をセット
;	MOVWF	PORTB

	;************************
	MOVLW	0Fh
	ANDWF	PORTB,W		; extract the lower 4 bits
	
	IORLW	030h
	MOVWF	PORTB		; to the upper 4 bits => set '3'
	;************************

	;----------------- debug: 1-1
	BCF		PORTB,0

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms

	BSF		PORTB,0
	CALL	wait1ms
	BCF		PORTB,0
	CALL	wait1ms


	BSF	PORTA,E		;ファンクションセット（１回目）
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS待つ

	;------------------------------------
;	MOVLW	0F0h		;PORTBの上位４ビットを
;	ANDWF	PORTB,W		;取り出す（変更しないように）
;	IORLW	03h		;下位４ビットに'３'をセット
;	MOVWF	PORTB

	;************************
	MOVLW	0Fh
	ANDWF	PORTB,W		; extract the lower 4 bits
	
	IORLW	030h
	MOVWF	PORTB		; to the upper 4 bits => set '3'
	;************************

	BSF	PORTA,E		;ファンクションセット（２回目）
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS待つ

	;------------------------------------
;	MOVLW	0F0h		;PORTBの上位４ビットを
;	ANDWF	PORTB,W		;取り出す（変更しないように）
;	IORLW	03h		;下位４ビットに'３'をセット
;	MOVWF	PORTB
	
	;************************
	MOVLW	0Fh
	ANDWF	PORTB,W		; extract the lower 4 bits
	
	IORLW	030h
	MOVWF	PORTB		; to the upper 4 bits => set '3'
	;************************
	
	BSF	PORTA,E		;ファンクションセット（３回目）
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS待つ

	;------------------------------------
;	MOVLW	0F0h		;PORTBの上位４ビットを
;	ANDWF	PORTB,W		;取り出す（変更しないように）
;	IORLW	02h		;４ビットモード
;	MOVWF	PORTB		;に

	;************************
	MOVLW	0Fh
	ANDWF	PORTB,W		; extract the lower 4 bits
	
	IORLW	020h		; 4-bit mode
	MOVWF	PORTB		;
	;************************

	BSF	PORTA,E		;設定
	NOP
	BCF	PORTA,E
	CALL	wait1ms		;1mS待つ

	MOVLW	028h		;４ビットモード，２行表示，７ドット
	CALL	LCD_command
	CALL	LCD_off		;ディスプレイＯＦＦ
	CALL	LCD_clear	;ＬＣＤクリア
	MOVLW	06h		;
	CALL	LCD_command	;カーソルモードセット (Increment)
	CALL	LCD_on		;ディスプレイＯＮ，カーソルＯＦＦ

	RETURN

;================= 15mS WAIT ================================
wait15ms
	MOVLW	d'3'
	MOVWF	CNT15mS
wait15ms_loop
	CALL	wait5ms
	DECFSZ	CNT15mS,F
	GOTO	wait15ms_loop
	RETURN

;================= 5mS WAIT =================================
wait5ms
	MOVLW	d'100'
	MOVWF	CNT5mS
wait5ms_loop
	CALL	wait50us
	DECFSZ	CNT5mS,F
	GOTO	wait5ms_loop
	RETURN

;================= 1mS WAIT =================================
wait1ms
	MOVLW	d'20'
	MOVWF	CNT1mS
wait1ms_loop
	CALL	wait50us
	DECFSZ	CNT1mS,F
	GOTO	wait1ms_loop
	RETURN

;================= 50μS WAIT ===============================
wait50us
	; １サイクル（４クロック）：０．２μＳ
	; ５０μＳ＝０．２μＳ×２５０サイクル

	MOVLW	d'82'		;1
	MOVWF	CNT50uS		;1
wait50us_loop
	DECFSZ	CNT50uS,F	;1
	GOTO	wait50us_loop	;2
	RETURN			;2+1
;}
;LCD_init


	END
; ========================== ここまで ==============================
