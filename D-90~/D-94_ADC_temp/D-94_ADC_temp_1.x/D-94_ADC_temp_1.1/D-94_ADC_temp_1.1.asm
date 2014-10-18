; ========================== ここから ==============================
;	PIC16F88
;	clock:INTRC 8MHz
;
;	ＡＮ４の温度センサ出力をＡ／Ｄ変換し、PORTBの７セグメントＬＥＤに
;	結果を１６進数で表示する
;
;	PORTB	:７セグメントＬＥＤ（Ａ～Ｇ，ＤＰ）
;	RA0	:2SC1815（７セグ＃１の選択）
;	RA1	:2SC1815（７セグ＃２の選択）
;	RA2	:2SC1815（７セグ＃３の選択）
;	RA3(Vref+)	:VRにより1.024Vの基準電圧
;	RA4(AN4)	:LM35D（温度センサ）
;
;	7セグの配置　888
;	7セグの番号　321	右から順番


	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_ON & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF


	CBLOCK	020h
	timer		;bit0:50μS ,1:5mS ,2:1S
	CNT5mS		;5mSカウンタ＝96（50uS×100＝5mS）
	CNT1S		;1Sカウンタ＝200（50uS×100×200＝1S）
	ADsaveH		;ADRESH保存
	ADsaveL		;ADRESL保存
	ADsaveH1	;ADRESH保存
	ADsaveL1	;ADRESL保存
	ADsaveH2	;ADRESH保存
	ADsaveL2	;ADRESL保存
	ADsaveH3	;ADRESH保存
	ADsaveL3	;ADRESL保存
	ADsaveH4	;ADRESH保存
	ADsaveL4	;ADRESL保存
	ADsaveH5	;ADRESH保存
	ADsaveL5	;ADRESL保存
	ADsaveH6	;ADRESH保存
	ADsaveL6	;ADRESL保存
	sel7seg		;7セグメントLED選択
	ENDC

	CBLOCK	070h	;common register
	save_st		;STATUSのセーブ
	save_w		;W-regのセーブ
	ENDC

f_t50u	EQU	0	;timer bit0:50μSフラグ
f_t5mS	EQU	1	;timer bit1:5mSフラグ
f_t1S	EQU	2	;timer bit2:1Sフラグ

	ORG	0		;リセットの入口
	GOTO	init
; -----------------------------------------------------
; TMR0割り込み処理
;	clock	8MHz
;	TMR0	d'255'-d'100'+d'7'
;	プリスケーラ	なし	
;	割込み周期	50uS

	ORG	4		;割込みの入口
intr
	BCF	INTCON,TMR0IF	;割込みフラグクリア
	MOVWF	save_w		;W-regセーブ
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUSセーブ

	BCF	STATUS,RP0	;■バンク０に切替え

	MOVLW	d'255'-d'100'+d'7'
	MOVWF	TMR0		;TMR0セット(0.5μS*1*100=50μS)

	BSF	timer,f_t50u	;50μS割込みフラグセット

	DECFSZ	CNT5mS,F	;5mS経過？
	GOTO	intr9		; No
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS経過フラグセット

	DECFSZ	CNT1S,F		;1S経過？
	GOTO	intr9		; No
	MOVLW	d'200'
	MOVWF	CNT1S
	BSF	timer,f_t1S	;1S経過フラグセット

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
	MOVLW	d'96'
	MOVWF	CNT5mS
	MOVLW	d'200'
	MOVWF	CNT1S
	MOVLW	04h
	MOVWF	sel7seg

	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	070h
	MOVWF	OSCCON		; CLOCK=8MHz
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2は出力
	CLRF	TRISB		;RB0-7は出力
	MOVLW	88h		;TMR0プリスケーラ未使用
	MOVWF	OPTION_REG	;プリセットカウンタへ出力
	BCF	STATUS,RP0	;■バンク０に切替え
	MOVLW	01h
	MOVWF	PORTB

	MOVLW	d'255'-d'100'+d'7'
	MOVWF	TMR0		;TMR0セット(0.5μS*1*100=50μS)
	BSF	INTCON,TMR0IE	;タイマ割込み許可
	BSF	INTCON,GIE	;全体割込み許可


	; ＜Ａ／Ｄ設定＞
	MOVLW	061h
	MOVWF	ADCON0		;16Tosc,CH4,ADON
	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	0E0h
	MOVWF	ADCON1		;右詰め , Vref+:RA3/Vref+ , Vref-:Vss
	MOVLW	10h
	MOVWF	ANSEL		;AN4使用
	BCF	STATUS,RP0	;■バンク０に切替え


; -----------------------------------------------------
; メイン処理

main
	MOVLW	d'255'-d'100'+d'7'	;カウント値ロード
	MOVWF	TMR0		;TMR0へ出力(0.5μS*1*100=50μS)
	BCF	timer,f_t50u	;50μS割込みフラグＯＦＦ
main1
	BTFSS	timer,f_t50u	;50μS経過？(アクイジション経過？）
	GOTO	main5		; NO
	BCF	timer,f_t50u	;50μS経過フラグクリア
	BSF	ADCON0,GO	;AD変換開始
main2
	BTFSC	ADCON0,GO	;AD変換完了？
	GOTO	main2		; NO

	MOVF	ADRESH,W	;AD変換結果の退避
	MOVWF	ADsaveH1
	BSF	STATUS,RP0	;■バンク１に切替え
	MOVF	ADRESL,W
	BCF	STATUS,RP0	;■バンク０に切替え
	MOVWF	ADsaveL1

	CALL	ADave		;AD変換結果の平均化

main5
	BTFSS	timer,f_t5mS	;5mS経過？(7セグ切り替え）
	GOTO	main1		; No
	CALL	chg7seg		; Yes
	BCF	timer,f_t5mS	;5mS経過フラグクリア(7セグ切り替え）
	GOTO	main1

; -----------------------------------------------------
; ＡＤ変換結果の平均化
ADave
	MOVF	ADsaveH1,W
	ADDWF	ADsaveH2,F
	MOVF	ADsaveL1,W
	ADDWF	ADsaveL2,F
	BTFSC	STATUS,C
	INCF	ADsaveH2,F
	BCF	STATUS,C
	RRF	ADsaveH2,F
	RRF	ADsaveL2,F

	MOVF	ADsaveH2,W
	ADDWF	ADsaveH3,F
	MOVF	ADsaveL2,W
	ADDWF	ADsaveL3,F
	BTFSC	STATUS,C
	INCF	ADsaveH3,F
	BCF	STATUS,C
	RRF	ADsaveH3,F
	RRF	ADsaveL3,F

	MOVF	ADsaveH3,W
	ADDWF	ADsaveH4,F
	MOVF	ADsaveL3,W
	ADDWF	ADsaveL4,F
	BTFSC	STATUS,C
	INCF	ADsaveH4,F
	BCF	STATUS,C
	RRF	ADsaveH4,F
	RRF	ADsaveL4,F

	MOVF	ADsaveH4,W
	ADDWF	ADsaveH5,F
	MOVF	ADsaveL4,W
	ADDWF	ADsaveL5,F
	BTFSC	STATUS,C
	INCF	ADsaveH5,F
	BCF	STATUS,C
	RRF	ADsaveH5,F
	RRF	ADsaveL5,F

	MOVF	ADsaveH5,W
	ADDWF	ADsaveH6,F
	MOVF	ADsaveL5,W
	ADDWF	ADsaveL6,F
	BTFSC	STATUS,C
	INCF	ADsaveH6,F
	BCF	STATUS,C
	RRF	ADsaveH6,F
	RRF	ADsaveL6,F

	BTFSS	timer,f_t1S
	GOTO	ADave9
	BCF	timer,f_t1S

	MOVF	ADsaveH6,W
	ADDWF	ADsaveH,F
	MOVF	ADsaveL6,W
	ADDWF	ADsaveL,F
	BTFSC	STATUS,C
	INCF	ADsaveH,F
	BCF	STATUS,C
	RRF	ADsaveH,F
	RRF	ADsaveL,F

ADave9
	RETURN

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
	ANDLW	0Fh		;ADRESHの下位４ビットの取り出し
	CALL	bin2hex		;７セグ表示用１６進数に変換
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	XORWF	PORTA,F		;７セグ表示
	RETURN

; -----------------------------------------------------
; バイナリ４ビットを７セグメントＬＥＤ表示用１６進数に変換
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
	
	END
; =========================== ここまで ===============================