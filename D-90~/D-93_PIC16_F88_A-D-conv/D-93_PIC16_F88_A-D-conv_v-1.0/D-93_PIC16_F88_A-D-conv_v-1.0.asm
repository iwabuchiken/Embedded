	LIST      P=16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF


	CBLOCK	020h
	save_st		;STATUS�̃Z�[�u
	save_w		;W-reg�̃Z�[�u
	timer		;1:996mS
	CNT5mS		;5mS�J�E���^���X�W�i51.2uS�~98��5.02mS�j
	ADsaveH		;ADRESH�ۑ�
	ADsaveL		;ADRESL�ۑ�
	sel7seg		;7�Z�O�����gLED�I��
	ENDC

f_t50u	EQU	0	;timer bit0:51.2��S�t���O
f_t5mS	EQU	1	;timer bit1:5mS�t���O

	ORG	0		;���Z�b�g�̓���
	GOTO	init
	
init
	CLRF	timer
	MOVLW	d'98'
	MOVWF	CNT5mS
	MOVLW	04h
	MOVWF	sel7seg
	
	END
	