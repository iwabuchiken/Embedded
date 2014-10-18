; ========================== �������� ==============================
;	PIC16F88
;	clock:INTRC 8MHz
;
;	�`�m�S�̉��x�Z���T�o�͂��`�^�c�ϊ����APORTB�̂V�Z�O�����g�k�d�c��
;	���ʂ��P�U�i���ŕ\������
;
;	PORTB	:�V�Z�O�����g�k�d�c�i�`�`�f�C�c�o�j
;	RA0	:2SC1815�i�V�Z�O���P�̑I���j
;	RA1	:2SC1815�i�V�Z�O���Q�̑I���j
;	RA2	:2SC1815�i�V�Z�O���R�̑I���j
;	RA3(Vref+)	:VR�ɂ��1.024V�̊�d��
;	RA4(AN4)	:LM35D�i���x�Z���T�j
;
;	7�Z�O�̔z�u�@888
;	7�Z�O�̔ԍ��@321	�E���珇��


	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_ON & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF


	CBLOCK	020h
	timer		;bit0:50��S ,1:5mS ,2:1S
	CNT5mS		;5mS�J�E���^��96�i50uS�~100��5mS�j
	CNT1S		;1S�J�E���^��200�i50uS�~100�~200��1S�j
	ADsaveH		;ADRESH�ۑ�
	ADsaveL		;ADRESL�ۑ�
	ADsaveH1	;ADRESH�ۑ�
	ADsaveL1	;ADRESL�ۑ�
	ADsaveH2	;ADRESH�ۑ�
	ADsaveL2	;ADRESL�ۑ�
	ADsaveH3	;ADRESH�ۑ�
	ADsaveL3	;ADRESL�ۑ�
	ADsaveH4	;ADRESH�ۑ�
	ADsaveL4	;ADRESL�ۑ�
	ADsaveH5	;ADRESH�ۑ�
	ADsaveL5	;ADRESL�ۑ�
	ADsaveH6	;ADRESH�ۑ�
	ADsaveL6	;ADRESL�ۑ�
	sel7seg		;7�Z�O�����gLED�I��
	ENDC

	CBLOCK	070h	;common register
	save_st		;STATUS�̃Z�[�u
	save_w		;W-reg�̃Z�[�u
	ENDC

f_t50u	EQU	0	;timer bit0:50��S�t���O
f_t5mS	EQU	1	;timer bit1:5mS�t���O
f_t1S	EQU	2	;timer bit2:1S�t���O

	ORG	0		;���Z�b�g�̓���
	GOTO	init
; -----------------------------------------------------
; TMR0���荞�ݏ���
;	clock	8MHz
;	TMR0	d'255'-d'100'+d'7'
;	�v���X�P�[��	�Ȃ�	
;	�����ݎ���	50uS

	ORG	4		;�����݂̓���
intr
	BCF	INTCON,TMR0IF	;�����݃t���O�N���A
	MOVWF	save_w		;W-reg�Z�[�u
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUS�Z�[�u

	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�

	MOVLW	d'255'-d'100'+d'7'
	MOVWF	TMR0		;TMR0�Z�b�g(0.5��S*1*100=50��S)

	BSF	timer,f_t50u	;50��S�����݃t���O�Z�b�g

	DECFSZ	CNT5mS,F	;5mS�o�߁H
	GOTO	intr9		; No
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS�o�߃t���O�Z�b�g

	DECFSZ	CNT1S,F		;1S�o�߁H
	GOTO	intr9		; No
	MOVLW	d'200'
	MOVWF	CNT1S
	BSF	timer,f_t1S	;1S�o�߃t���O�Z�b�g

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
	MOVLW	d'96'
	MOVWF	CNT5mS
	MOVLW	d'200'
	MOVWF	CNT1S
	MOVLW	04h
	MOVWF	sel7seg

	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	070h
	MOVWF	OSCCON		; CLOCK=8MHz
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2�͏o��
	CLRF	TRISB		;RB0-7�͏o��
	MOVLW	88h		;TMR0�v���X�P�[�����g�p
	MOVWF	OPTION_REG	;�v���Z�b�g�J�E���^�֏o��
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	MOVLW	01h
	MOVWF	PORTB

	MOVLW	d'255'-d'100'+d'7'
	MOVWF	TMR0		;TMR0�Z�b�g(0.5��S*1*100=50��S)
	BSF	INTCON,TMR0IE	;�^�C�}�����݋���
	BSF	INTCON,GIE	;�S�̊����݋���


	; ���`�^�c�ݒ聄
	MOVLW	061h
	MOVWF	ADCON0		;16Tosc,CH4,ADON
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	0E0h
	MOVWF	ADCON1		;�E�l�� , Vref+:RA3/Vref+ , Vref-:Vss
	MOVLW	10h
	MOVWF	ANSEL		;AN4�g�p
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�


; -----------------------------------------------------
; ���C������

main
	MOVLW	d'255'-d'100'+d'7'	;�J�E���g�l���[�h
	MOVWF	TMR0		;TMR0�֏o��(0.5��S*1*100=50��S)
	BCF	timer,f_t50u	;50��S�����݃t���O�n�e�e
main1
	BTFSS	timer,f_t50u	;50��S�o�߁H(�A�N�C�W�V�����o�߁H�j
	GOTO	main5		; NO
	BCF	timer,f_t50u	;50��S�o�߃t���O�N���A
	BSF	ADCON0,GO	;AD�ϊ��J�n
main2
	BTFSC	ADCON0,GO	;AD�ϊ������H
	GOTO	main2		; NO

	MOVF	ADRESH,W	;AD�ϊ����ʂ̑ޔ�
	MOVWF	ADsaveH1
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVF	ADRESL,W
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	MOVWF	ADsaveL1

	CALL	ADave		;AD�ϊ����ʂ̕��ω�

main5
	BTFSS	timer,f_t5mS	;5mS�o�߁H(7�Z�O�؂�ւ��j
	GOTO	main1		; No
	CALL	chg7seg		; Yes
	BCF	timer,f_t5mS	;5mS�o�߃t���O�N���A(7�Z�O�؂�ւ��j
	GOTO	main1

; -----------------------------------------------------
; �`�c�ϊ����ʂ̕��ω�
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
	ANDLW	0Fh		;ADRESH�̉��ʂS�r�b�g�̎��o��
	CALL	bin2hex		;�V�Z�O�\���p�P�U�i���ɕϊ�
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	XORWF	PORTA,F		;�V�Z�O�\��
	RETURN

; -----------------------------------------------------
; �o�C�i���S�r�b�g���V�Z�O�����g�k�d�c�\���p�P�U�i���ɕϊ�
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
; =========================== �����܂� ===============================