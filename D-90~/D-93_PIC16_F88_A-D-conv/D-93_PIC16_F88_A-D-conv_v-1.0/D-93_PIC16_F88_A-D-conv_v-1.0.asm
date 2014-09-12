	LIST      P=16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF


	CBLOCK	020h
	save_st		;STATUSのセーブ
	save_w		;W-regのセーブ
	timer		;1:996mS
	CNT5mS		;5mSカウンタ＝９８（51.2uS×98＝5.02mS）
	ADsaveH		;ADRESH保存
	ADsaveL		;ADRESL保存
	sel7seg		;7セグメントLED選択
	ENDC

f_t50u	EQU	0	;timer bit0:51.2μSフラグ
f_t5mS	EQU	1	;timer bit1:5mSフラグ

	ORG	0		;リセットの入口
	GOTO	init
	
; -----------------------------------------------------
; TMR0割り込み処理
;	clock 20MHz
;	TMR0	フリーラン
;	プリスケーラ	なし	
;	割込み周期	51.2uS

	ORG	4		;割込みの入口
intr
	BCF	INTCON,TMR0IF	;割込みフラグクリア
	MOVWF	save_w		;W-regセーブ
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUSセーブ

	BSF	timer,f_t50u	;51.2μS割込みフラグセット

	DECFSZ	CNT5mS,F	;5mS経過？
	GOTO	intr9		; No
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS経過フラグセット

intr9
	SWAPF	save_st,W
	MOVWF	STATUS		;STATUSロード
	SWAPF	save_w,F
	SWAPF	save_w,W	;W-regロード
	RETFIE			;割込み許可リターン

; -----------------------------------------------------
; 初期処理

init
	CLRF	timer
	MOVLW	d'98'
	MOVWF	CNT5mS
	MOVLW	04h
	MOVWF	sel7seg
	
BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2は出力
	CLRF	TRISB		;RB0-7は出力
	MOVLW	88h		;TMR0プリスケーラ未使用
	MOVWF	OPTION_REG	;プリセットカウンタへ出力
	BCF	STATUS,RP0	;■バンク０に切替え
	MOVLW	01h
	MOVWF	PORTB
	CLRF	TMR0		;TMR0セット(0.2μS*1*256=51.2μS)
	BSF	INTCON,TMR0IE	;タイマ割込み許可
	BSF	INTCON,GIE	;全体割込み許可


	; ＜Ａ／Ｄ設定＞
	MOVLW	099h
	MOVWF	ADCON0		;32Tosc,CH3,ADON
	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	80h
	MOVWF	ADCON1		;右詰め,Vref=Vdd
	MOVLW	08h
	MOVWF	ANSEL		;AN3使用
	BCF	STATUS,RP0	;■バンク０に切替え

; -----------------------------------------------------
; メイン処理

main
	MOVLW	d'0'		;カウント値ロード
	MOVWF	TMR0		;TMR0へ出力(0.2μS*1*256=51.2μS)
	BCF	timer,f_t50u	;51.2μS割込みフラグＯＦＦ
main1
	BTFSS	timer,f_t50u	;51.2μS経過？(アクイジション経過？）
	GOTO	main5		; NO
	BCF	timer,f_t50u	;51.2μS経過フラグクリア
	BSF	ADCON0,GO	;AD変換開始
main2
	BTFSC	ADCON0,GO	;AD変換完了？
	GOTO	main2		; NO

	MOVF	ADRESH,W	;AD変換結果の退避
	MOVWF	ADsaveH
	BSF	STATUS,RP0	;■バンク１に切替え
	MOVF	ADRESL,W
	BCF	STATUS,RP0	;■バンク０に切替え
	MOVWF	ADsaveL

main5
	BTFSC	timer,f_t5mS	;5mS経過？(7セグ切り替え）
	CALL	chg7seg		; Yes
	GOTO	main1		; No

; -----------------------------------------------------
; ７セグメントＬＥＤ表示切り替え
chg7seg
	CLRF	PORTA		;全７セグ消灯

	BCF	STATUS,C
	RRF	sel7seg,F	;次の７セグへ

	BTFSC	sel7seg,0	;７セグ＃１？
	GOTO	chg7seg1	; Yes
	BTFSC	sel7seg,1	;７セグ＃２？
	GOTO	chg7seg2	; Yes

	MOVLW	04h
	MOVWF	sel7seg
	GOTO	chg7seg3	;７セグ＃３

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
	CALL	bin2hex		;７セグ表示用１６進数に変換
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	MOVWF	PORTA		;７セグ表示
	RETURN

; -----------------------------------------------------
; バイナリ４ビットを７セグメントＬＥＤ表示用１６進数に変換
bin2hex
	ADDWF	PCL,f

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

	END
	