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
	
; -----------------------------------------------------
; TMR0���荞�ݏ���
;	clock 20MHz
;	TMR0	�t���[����
;	�v���X�P�[��	�Ȃ�	
;	�����ݎ���	51.2uS

	ORG	4		;�����݂̓���
intr
	BCF	INTCON,TMR0IF	;�����݃t���O�N���A
	MOVWF	save_w		;W-reg�Z�[�u
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUS�Z�[�u

	BSF	timer,f_t50u	;51.2��S�����݃t���O�Z�b�g

	DECFSZ	CNT5mS,F	;5mS�o�߁H
	GOTO	intr9		; No
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS�o�߃t���O�Z�b�g

intr9
	SWAPF	save_st,W
	MOVWF	STATUS		;STATUS���[�h
	SWAPF	save_w,F
	SWAPF	save_w,W	;W-reg���[�h
	RETFIE			;�����݋����^�[��

; -----------------------------------------------------
; ��������

init
	CLRF	timer
	MOVLW	d'98'
	MOVWF	CNT5mS
	MOVLW	04h
	MOVWF	sel7seg
	
BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2�͏o��
	CLRF	TRISB		;RB0-7�͏o��
	MOVLW	88h		;TMR0�v���X�P�[�����g�p
	MOVWF	OPTION_REG	;�v���Z�b�g�J�E���^�֏o��
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	MOVLW	01h
	MOVWF	PORTB
	CLRF	TMR0		;TMR0�Z�b�g(0.2��S*1*256=51.2��S)
	BSF	INTCON,TMR0IE	;�^�C�}�����݋���
	BSF	INTCON,GIE	;�S�̊����݋���


	; ���`�^�c�ݒ聄
	MOVLW	099h
	MOVWF	ADCON0		;32Tosc,CH3,ADON
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	80h
	MOVWF	ADCON1		;�E�l��,Vref=Vdd
	MOVLW	08h
	MOVWF	ANSEL		;AN3�g�p
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�

; -----------------------------------------------------
; ���C������

main
	MOVLW	d'0'		;�J�E���g�l���[�h
	MOVWF	TMR0		;TMR0�֏o��(0.2��S*1*256=51.2��S)
	BCF	timer,f_t50u	;51.2��S�����݃t���O�n�e�e
main1
	BTFSS	timer,f_t50u	;51.2��S�o�߁H(�A�N�C�W�V�����o�߁H�j
	GOTO	main5		; NO
	BCF	timer,f_t50u	;51.2��S�o�߃t���O�N���A
	BSF	ADCON0,GO	;AD�ϊ��J�n
main2
	BTFSC	ADCON0,GO	;AD�ϊ������H
	GOTO	main2		; NO

	MOVF	ADRESH,W	;AD�ϊ����ʂ̑ޔ�
	MOVWF	ADsaveH
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVF	ADRESL,W
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	MOVWF	ADsaveL

main5
	BTFSC	timer,f_t5mS	;5mS�o�߁H(7�Z�O�؂�ւ��j
	CALL	chg7seg		; Yes
	GOTO	main1		; No

; -----------------------------------------------------
; �V�Z�O�����g�k�d�c�\���؂�ւ�
chg7seg
	CLRF	PORTA		;�S�V�Z�O����

	BCF	STATUS,C
	RRF	sel7seg,F	;���̂V�Z�O��

	BTFSC	sel7seg,0	;�V�Z�O���P�H
	GOTO	chg7seg1	; Yes
	BTFSC	sel7seg,1	;�V�Z�O���Q�H
	GOTO	chg7seg2	; Yes

	MOVLW	04h
	MOVWF	sel7seg
	GOTO	chg7seg3	;�V�Z�O���R

chg7seg1
	MOVF	ADsaveL,W
	ANDLW	0Fh		;ADRESL�̉��ʂS�r�b�g�̎��o��
	CALL	bin2hex		;�V�Z�O�\���p�P�U�i���ɕϊ�
	MOVWF	PORTB
	GOTO	chg7seg9
chg7seg2
	SWAPF	ADsaveL,W
	ANDLW	0Fh		;ADRESL�̏�ʂS�r�b�g�̎��o��
	CALL	bin2hex		;�V�Z�O�\���p�P�U�i���ɕϊ�
	MOVWF	PORTB
	GOTO	chg7seg9
chg7seg3
	MOVF	ADsaveH,W	;ADRESH��
	CALL	bin2hex		;�V�Z�O�\���p�P�U�i���ɕϊ�
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	MOVWF	PORTA		;�V�Z�O�\��
	RETURN

; -----------------------------------------------------
; �o�C�i���S�r�b�g���V�Z�O�����g�k�d�c�\���p�P�U�i���ɕϊ�
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
	