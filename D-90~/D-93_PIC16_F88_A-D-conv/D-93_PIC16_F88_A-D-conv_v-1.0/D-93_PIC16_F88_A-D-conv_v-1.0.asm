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
	
init
	CLRF	timer
	MOVLW	d'98'
	MOVWF	CNT5mS
	MOVLW	04h
	MOVWF	sel7seg
	
	END
	