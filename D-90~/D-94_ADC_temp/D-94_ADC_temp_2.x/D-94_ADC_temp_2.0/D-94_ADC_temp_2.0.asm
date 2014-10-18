; ========================== ここから ==============================
;	PIC16F88
;	clock:INTRC 8MHz
;
;	ＡＮ４の温度センサ出力をＡ／Ｄ変換し、PORTBの７セグメントＬＥＤに
;	結果を９９．９で表示する
;
;	RB0-6	:７セグメントＬＥＤ（Ａ～Ｇ）
;	RA7	:７セグメントＬＥＤ（ＤＰ）
;	RA0	:2SC1815（７セグ＃１の選択）
;	RA1	:2SC1815（７セグ＃２の選択）
;	RA2	:2SC1815（７セグ＃３の選択）
;
;	RA3(Vref+)	:LM336-2.5（2.5V基準電圧）
;	RA4(AN4)	:LM35D（温度センサ）
;	RA5		:Cds
;	RA6		:上記３つの電源
;
;	RB7	:NaPiOn　（ピン変化割込みでSLEEP時でも検出）
;
;	7セグの配置　888
;	7セグの番号　321	右から順番


	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

;================================== CBLOCK
;{
	CBLOCK	020h
	timer		;bit0:50μS ,1:0.5mS ,2:3mS ,3:5mS ,4:1S ,5:5S
	CNT05mS		;0.5mSカウンタ＝ 10 (50uS×10＝0.5mS）
	CNT3mS		;3mSカウンタ＝ 60（50uS×60 ＝3mS）
	CNT5mS		;5mSカウンタ＝ 96（50uS×100＝5mS）
	CNT1S		;1Sカウンタ ＝200（5mS×200＝1S）
	CNT5S		;5Sカウンタ ＝  5 (1S×5＝5S）
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
	sel7seg		;7セグメントLED選択
	PORTA_wk	;7セグメントLED選択のワーク
	binH		;BCD変換の上位バイト
	binL		;BCD変換の下位バイト
	BCD3		;BCD変換結果（百の位）
	BCD2		;BCD変換結果（十の位）
	BCD1		;BCD変換結果（一の位）
	BCDwk1		;BCD変換用ワーク
	BCDwk2		;BCD変換用ワーク
	ENDC

	CBLOCK	070h	;common register
	save_st		;STATUSのセーブ
	save_w		;W-regのセーブ
	ENDC

;}
;

;================================== CONSTANTS
;{
f_t50u	EQU	0	;timer bit0:50μSフラグ
f_t05mS	EQU	1	;timer bit1:0.5mSフラグ
f_t3mS	EQU	2	;timer bit2:3mSフラグ
f_t5mS	EQU	3	;timer bit3:5mSフラグ
f_t1S	EQU	4	;timer bit4:1Sフラグ
f_t5S	EQU	5	;timer bit5:5Sフラグ

;}
;

	ORG	0		;リセットの入口
	GOTO	init
; -----------------------------------------------------
;================================== intr
;{
; TMR0割り込み処理
;	clock 8MHz
;	TMR0	100
;	プリスケーラ	なし	
;	割込み周期	50uS

	ORG	4		;割込みの入口
intr
	MOVWF	save_w		;W-regセーブ
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUSセーブ

	BCF	STATUS,RP0	;■バンク０に切替え
	BTFSS	INTCON,TMR0IF	;TMR0割込み？
	GOTO	RBint		; No

	BCF	INTCON,TMR0IF	;割込みフラグクリア
	MOVLW	d'255'-d'100'+d'10'
	MOVWF	TMR0		;TMR0セット(0.5μS*1*100=50μS)

	BSF	timer,f_t50u	;50μS割込みフラグセット

	DECFSZ	CNT05mS,F	;0.5mS経過？
	GOTO	intr5		; No
	MOVLW	d'10'
	MOVWF	CNT05mS
	BSF	timer,f_t05mS	;0.5mS経過フラグセット
intr5
	DECFSZ	CNT3mS,F	;3mS経過？
	GOTO	intr6		; No
	MOVLW	d'60'
	MOVWF	CNT3mS
	BSF	timer,f_t3mS	;3mS経過フラグセット
intr6
	DECFSZ	CNT5mS,F	;5mS経過？
	GOTO	intr9		; No
	MOVLW	d'96'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS経過フラグセット

	DECFSZ	CNT1S,F		;1S経過？
	GOTO	intr9		; No
	MOVLW	d'200'
	MOVWF	CNT1S
	BSF	timer,f_t1S	;1S経過フラグセット

	DECFSZ	CNT5S,F		;10S経過？
	GOTO	intr9		; No
	MOVLW	d'5'
	MOVWF	CNT5S
	BSF	timer,f_t5S	;5S経過フラグセット
	GOTO	intr9

;
; PORTBピン変化割り込み処理
RBint
	BTFSS	PORTB,7
	GOTO	RBint9
	MOVLW	d'5'
	MOVWF	CNT5S
RBint9
	BCF	INTCON,RBIF

intr9
	SWAPF	save_st,W
	MOVWF	STATUS		;STATUSロード
	SWAPF	save_w,F
	SWAPF	save_w,W	;W-regロード
	RETFIE			;割込み許可リターン

;}
;

; -----------------------------------------------------
;================================== 初期処理
;{
; 初期処理

init
	CLRF	timer		;タイマー関連初期化
	MOVLW	d'10'
	MOVWF	CNT05mS
	MOVLW	d'60'
	MOVWF	CNT3mS
	MOVLW	d'96'
	MOVWF	CNT5mS
	MOVLW	d'200'
	MOVWF	CNT1S
	MOVLW	d'5'
	MOVWF	CNT5S

	MOVLW	04h		;７セグ選択ビット初期化
	MOVWF	sel7seg

	BSF	STATUS,RP0	;■バンク１に切替え
	MOVLW	070h
	MOVWF	OSCCON		;CLOCK=8MHz
	MOVLW	038h
	MOVWF	TRISA		;RA0-2,6-7は出力
	MOVLW	080h
	MOVWF	TRISB		;RB0-6は出力,RB7は入力
	MOVLW	88h		;TMR0プリスケーラ未使用
	MOVWF	OPTION_REG	;プリセットカウンタへ出力
	BCF	STATUS,RP0	;■バンク０に切替え
	CLRF	PORTB
	MOVLW	040h
	MOVWF	PORTA

	MOVLW	d'255'-d'100'+d'10'
	MOVWF	TMR0		;TMR0セット(0.5μS*1*100=50μS)
	BSF	INTCON,TMR0IE	;タイマ割込み許可
	BSF	INTCON,RBIE	;ピン変化割込み許可
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

;}
;

; -----------------------------------------------------
;================================== メイン処理
;{
; メイン処理

main
	MOVLW	d'255'-d'100'+d'10'	;カウント値ロード
	MOVWF	TMR0		;TMR0へ出力(0.5μS*1*100=50μS)
	BCF		timer,f_t50u	;50μS割込みフラグＯＦＦ
	
	MOVLW	b'00000011'	; RB0,1 => ON
	MOVWF	PORTB
	
main1
	;BTFSS	timer,f_t50u	;50μS経過？(アクイジション経過？）
	;GOTO	main4		; NO
	;BCF		timer,f_t50u	;50μS経過フラグクリア


main7
	BTFSS	timer,f_t5S	;5S経過？
	GOTO	main1		; No
	CALL	goto_bed	; Yes (SLEEPモードへ)
	BCF		timer,f_t5S	;5S経過フラグクリア
	GOTO	main

;}
;

; -----------------------------------------------------
;================================== ７セグメントＬＥＤ表示切り替え
;
;{
; ７セグメントＬＥＤ表示切り替え
chg7seg
	MOVLW	078h
	ANDWF	PORTA,F		;全７セグ消灯

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
;	BTFSC	PORTB,7
;	BSF	PORTA,7		;NaPiOnの状態を小数点で表示
	MOVF	BCD1,W
	GOTO	chg7seg9

chg7seg2
	BSF	PORTA,7		;小数点を表示
	MOVF	BCD2,W
	GOTO	chg7seg9
chg7seg3
	MOVF	BCD3,W
	BTFSC	STATUS,Z	;0?
	GOTO	chg7segX	; Yes

chg7seg9
	CALL	bcd2led		;７セグ表示用１０進数に変換
	MOVWF	PORTB
	MOVF	sel7seg,W
	IORWF	PORTA,F		;７セグ表示
chg7segX
	RETURN

;}
;

; -----------------------------------------------------
;===================== bcd2led
;{
; ＢＣＤ４ビットを７セグメントＬＥＤ表示用１０進数に変換
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
	RETLW	040h	;a
	RETLW	040h	;b
	RETLW	040h	;c
	RETLW	040h	;d
	RETLW	040h	;e
	RETLW	040h	;f

;}
;

; -----------------------------------------------------
;===================== bin2BCD
;{
; バイナリ１０ビット(ADsaveH,ADsaveL)をＢＣＤに変換
bin2BCD
	MOVF	ADsaveH,W
	MOVWF	binH
	MOVF	ADsaveL,W
	MOVWF	binL

	MOVLW	0FFh
	MOVWF	BCD3		; -1をセット
	MOVWF	BCD2		; -1をセット
			; binLの下位２ビット → BCDwk2
	MOVF	binL,W
	ANDLW	03h
	MOVWF	BCDwk2
			; binH・binL ÷ ４ → BCDwk1
			; 下位２ビットは一旦切り捨て（後で復活）
	BCF	STATUS,C
	RRF	binH,F
	RRF	binL,F		; 1/2する
	BCF	STATUS,C
	RRF	binH,F
	RRF	binL,W		; もう一度1/2する(合計1/4)。
	MOVWF	BCDwk1

			; 百の位(BCD3)を算出
	MOVLW	d'25'		; 1/4にしたので、25で割れば100の位が計算できる。
bin2BCD3
	INCF	BCD3,F
	SUBWF	BCDwk1,F
	BTFSC	STATUS,C	; BCDwk1 ＜ 25  (C=0)
	GOTO	bin2BCD3
	ADDWF	BCDwk1,F

			; 十の位(BCD2)を算出
	BCF	STATUS,C
	RLF	BCDwk1,F	; 2倍する
	RLF	BCDwk1,F	; もう一度2倍する(合計4倍)。前で1/4したものを戻す。
	MOVF	BCDwk2,W
	ADDWF	BCDwk1,F	; 前で切り捨てた下位２ビットを加算
	MOVLW	d'10'		; 10で割って10の位を計算。
bin2BCD2
	INCF	BCD2,F
	SUBWF	BCDwk1,F
	BTFSC	STATUS,C	; BCDwk1 ＜ 10  (C=0)
	GOTO	bin2BCD2
	ADDWF	BCDwk1,F

			; 一の位(BCD1)を算出
	MOVF	BCDwk1,W
	MOVWF	BCD1

	RETURN

;}
;

; -----------------------------------------------------
;===================== goto_bed
;{
; ＳＬＥＥＰモードに移行
goto_bed
	BCF	INTCON,GIE	; 全割込み禁止
	BCF	ADCON0,ADON	; A/D off
	CLRF	PORTA		; LM336,LM35D 電源OFF，7セグOFF
	
	;MOVLW	080h
	;ANDWF	PORTB,F		; 7セグOFF
	
	CLRF	PORTB	; RB0,1 => OFF
	
	BCF	INTCON,RBIF	; RBピン変化割込みフラグクリア

	SLEEP

	BSF	PORTA,6		; LM336,LM35D 電源ON
	MOVLW	d'5'
	MOVWF	CNT5S		; 5秒カウンタ初期設定
	MOVF	PORTB,W
	BCF	INTCON,RBIF	; RBピン変化割込みフラグクリア
	BSF	INTCON,GIE	; 全割込み許可
	BSF	ADCON0,ADON	; A/D on

	RETURN

;}
;

; -----------------------------------------------------
;===================== ADave
; ＡＤ変換結果の平均化
;{
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
	ADDWF	ADsaveH,F
	MOVF	ADsaveL5,W
	ADDWF	ADsaveL,F
	BTFSC	STATUS,C
	INCF	ADsaveH,F
	BCF	STATUS,C
	RRF	ADsaveH,F
	RRF	ADsaveL,F

	RETURN

;}
;


	END
; =========================== ここまで ===============================