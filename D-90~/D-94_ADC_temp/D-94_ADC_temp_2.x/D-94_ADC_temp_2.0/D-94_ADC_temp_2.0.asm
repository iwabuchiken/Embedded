; ========================== �������� ==============================
;	PIC16F88
;	clock:INTRC 8MHz
;
;	�`�m�S�̉��x�Z���T�o�͂��`�^�c�ϊ����APORTB�̂V�Z�O�����g�k�d�c��
;	���ʂ��X�X�D�X�ŕ\������
;
;	RB0-6	:�V�Z�O�����g�k�d�c�i�`�`�f�j
;	RA7	:�V�Z�O�����g�k�d�c�i�c�o�j
;	RA0	:2SC1815�i�V�Z�O���P�̑I���j
;	RA1	:2SC1815�i�V�Z�O���Q�̑I���j
;	RA2	:2SC1815�i�V�Z�O���R�̑I���j
;
;	RA3(Vref+)	:LM336-2.5�i2.5V��d���j
;	RA4(AN4)	:LM35D�i���x�Z���T�j
;	RA5		:Cds
;	RA6		:��L�R�̓d��
;
;	RB7	:NaPiOn�@�i�s���ω������݂�SLEEP���ł����o�j
;
;	7�Z�O�̔z�u�@888
;	7�Z�O�̔ԍ��@321	�E���珇��


	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

;================================== CBLOCK
;{
	CBLOCK	020h
	timer		;bit0:50��S ,1:0.5mS ,2:3mS ,3:5mS ,4:1S ,5:5S
	CNT05mS		;0.5mS�J�E���^�� 10 (50uS�~10��0.5mS�j
	CNT3mS		;3mS�J�E���^�� 60�i50uS�~60 ��3mS�j
	CNT5mS		;5mS�J�E���^�� 96�i50uS�~100��5mS�j
	CNT1S		;1S�J�E���^ ��200�i5mS�~200��1S�j
	CNT5S		;5S�J�E���^ ��  5 (1S�~5��5S�j
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
	sel7seg		;7�Z�O�����gLED�I��
	PORTA_wk	;7�Z�O�����gLED�I���̃��[�N
	binH		;BCD�ϊ��̏�ʃo�C�g
	binL		;BCD�ϊ��̉��ʃo�C�g
	BCD3		;BCD�ϊ����ʁi�S�̈ʁj
	BCD2		;BCD�ϊ����ʁi�\�̈ʁj
	BCD1		;BCD�ϊ����ʁi��̈ʁj
	BCDwk1		;BCD�ϊ��p���[�N
	BCDwk2		;BCD�ϊ��p���[�N
	ENDC

	CBLOCK	070h	;common register
	save_st		;STATUS�̃Z�[�u
	save_w		;W-reg�̃Z�[�u
	ENDC

;}
;

;================================== CONSTANTS
;{
f_t50u	EQU	0	;timer bit0:50��S�t���O
f_t05mS	EQU	1	;timer bit1:0.5mS�t���O
f_t3mS	EQU	2	;timer bit2:3mS�t���O
f_t5mS	EQU	3	;timer bit3:5mS�t���O
f_t1S	EQU	4	;timer bit4:1S�t���O
f_t5S	EQU	5	;timer bit5:5S�t���O

;}
;

	ORG	0		;���Z�b�g�̓���
	GOTO	init
; -----------------------------------------------------
;================================== intr
;{
; TMR0���荞�ݏ���
;	clock 8MHz
;	TMR0	100
;	�v���X�P�[��	�Ȃ�	
;	�����ݎ���	50uS

	ORG	4		;�����݂̓���
intr
	MOVWF	save_w		;W-reg�Z�[�u
	SWAPF	STATUS,W
	MOVWF	save_st		;STATUS�Z�[�u

	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	BTFSS	INTCON,TMR0IF	;TMR0�����݁H
	GOTO	RBint		; No

	BCF	INTCON,TMR0IF	;�����݃t���O�N���A
	MOVLW	d'255'-d'100'+d'10'
	MOVWF	TMR0		;TMR0�Z�b�g(0.5��S*1*100=50��S)

	BSF	timer,f_t50u	;50��S�����݃t���O�Z�b�g

	DECFSZ	CNT05mS,F	;0.5mS�o�߁H
	GOTO	intr5		; No
	MOVLW	d'10'
	MOVWF	CNT05mS
	BSF	timer,f_t05mS	;0.5mS�o�߃t���O�Z�b�g
intr5
	DECFSZ	CNT3mS,F	;3mS�o�߁H
	GOTO	intr6		; No
	MOVLW	d'60'
	MOVWF	CNT3mS
	BSF	timer,f_t3mS	;3mS�o�߃t���O�Z�b�g
intr6
	DECFSZ	CNT5mS,F	;5mS�o�߁H
	GOTO	intr9		; No
	MOVLW	d'96'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS�o�߃t���O�Z�b�g

	DECFSZ	CNT1S,F		;1S�o�߁H
	GOTO	intr9		; No
	MOVLW	d'200'
	MOVWF	CNT1S
	BSF	timer,f_t1S	;1S�o�߃t���O�Z�b�g

	DECFSZ	CNT5S,F		;10S�o�߁H
	GOTO	intr9		; No
	MOVLW	d'5'
	MOVWF	CNT5S
	BSF	timer,f_t5S	;5S�o�߃t���O�Z�b�g
	GOTO	intr9

;
; PORTB�s���ω����荞�ݏ���
RBint
	BTFSS	PORTB,7
	GOTO	RBint9
	MOVLW	d'5'
	MOVWF	CNT5S
RBint9
	BCF	INTCON,RBIF

intr9
	SWAPF	save_st,W
	MOVWF	STATUS		;STATUS���[�h
	SWAPF	save_w,F
	SWAPF	save_w,W	;W-reg���[�h
	RETFIE			;�����݋����^�[��

;}
;

; -----------------------------------------------------
;================================== ��������
;{
; ��������

init
	CLRF	timer		;�^�C�}�[�֘A������
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

	MOVLW	04h		;�V�Z�O�I���r�b�g������
	MOVWF	sel7seg

	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	070h
	MOVWF	OSCCON		;CLOCK=8MHz
	MOVLW	038h
	MOVWF	TRISA		;RA0-2,6-7�͏o��
	MOVLW	080h
	MOVWF	TRISB		;RB0-6�͏o��,RB7�͓���
	MOVLW	88h		;TMR0�v���X�P�[�����g�p
	MOVWF	OPTION_REG	;�v���Z�b�g�J�E���^�֏o��
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	CLRF	PORTB
	MOVLW	040h
	MOVWF	PORTA

	MOVLW	d'255'-d'100'+d'10'
	MOVWF	TMR0		;TMR0�Z�b�g(0.5��S*1*100=50��S)
	BSF	INTCON,TMR0IE	;�^�C�}�����݋���
	BSF	INTCON,RBIE	;�s���ω������݋���
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

;}
;

; -----------------------------------------------------
;================================== ���C������
;{
; ���C������

main
	MOVLW	d'255'-d'100'+d'10'	;�J�E���g�l���[�h
	MOVWF	TMR0		;TMR0�֏o��(0.5��S*1*100=50��S)
	BCF		timer,f_t50u	;50��S�����݃t���O�n�e�e
	
	MOVLW	b'00000011'	; RB0,1 => ON
	MOVWF	PORTB
	
main1
	;BTFSS	timer,f_t50u	;50��S�o�߁H(�A�N�C�W�V�����o�߁H�j
	;GOTO	main4		; NO
	;BCF		timer,f_t50u	;50��S�o�߃t���O�N���A


main7
	BTFSS	timer,f_t5S	;5S�o�߁H
	GOTO	main1		; No
	CALL	goto_bed	; Yes (SLEEP���[�h��)
	BCF		timer,f_t5S	;5S�o�߃t���O�N���A
	GOTO	main

;}
;

; -----------------------------------------------------
;================================== �V�Z�O�����g�k�d�c�\���؂�ւ�
;
;{
; �V�Z�O�����g�k�d�c�\���؂�ւ�
chg7seg
	MOVLW	078h
	ANDWF	PORTA,F		;�S�V�Z�O����

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
;	BTFSC	PORTB,7
;	BSF	PORTA,7		;NaPiOn�̏�Ԃ������_�ŕ\��
	MOVF	BCD1,W
	GOTO	chg7seg9

chg7seg2
	BSF	PORTA,7		;�����_��\��
	MOVF	BCD2,W
	GOTO	chg7seg9
chg7seg3
	MOVF	BCD3,W
	BTFSC	STATUS,Z	;0?
	GOTO	chg7segX	; Yes

chg7seg9
	CALL	bcd2led		;�V�Z�O�\���p�P�O�i���ɕϊ�
	MOVWF	PORTB
	MOVF	sel7seg,W
	IORWF	PORTA,F		;�V�Z�O�\��
chg7segX
	RETURN

;}
;

; -----------------------------------------------------
;===================== bcd2led
;{
; �a�b�c�S�r�b�g���V�Z�O�����g�k�d�c�\���p�P�O�i���ɕϊ�
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
; �o�C�i���P�O�r�b�g(ADsaveH,ADsaveL)���a�b�c�ɕϊ�
bin2BCD
	MOVF	ADsaveH,W
	MOVWF	binH
	MOVF	ADsaveL,W
	MOVWF	binL

	MOVLW	0FFh
	MOVWF	BCD3		; -1���Z�b�g
	MOVWF	BCD2		; -1���Z�b�g
			; binL�̉��ʂQ�r�b�g �� BCDwk2
	MOVF	binL,W
	ANDLW	03h
	MOVWF	BCDwk2
			; binH�EbinL �� �S �� BCDwk1
			; ���ʂQ�r�b�g�͈�U�؂�̂āi��ŕ����j
	BCF	STATUS,C
	RRF	binH,F
	RRF	binL,F		; 1/2����
	BCF	STATUS,C
	RRF	binH,F
	RRF	binL,W		; ������x1/2����(���v1/4)�B
	MOVWF	BCDwk1

			; �S�̈�(BCD3)���Z�o
	MOVLW	d'25'		; 1/4�ɂ����̂ŁA25�Ŋ����100�̈ʂ��v�Z�ł���B
bin2BCD3
	INCF	BCD3,F
	SUBWF	BCDwk1,F
	BTFSC	STATUS,C	; BCDwk1 �� 25  (C=0)
	GOTO	bin2BCD3
	ADDWF	BCDwk1,F

			; �\�̈�(BCD2)���Z�o
	BCF	STATUS,C
	RLF	BCDwk1,F	; 2�{����
	RLF	BCDwk1,F	; ������x2�{����(���v4�{)�B�O��1/4�������̂�߂��B
	MOVF	BCDwk2,W
	ADDWF	BCDwk1,F	; �O�Ő؂�̂Ă����ʂQ�r�b�g�����Z
	MOVLW	d'10'		; 10�Ŋ�����10�̈ʂ��v�Z�B
bin2BCD2
	INCF	BCD2,F
	SUBWF	BCDwk1,F
	BTFSC	STATUS,C	; BCDwk1 �� 10  (C=0)
	GOTO	bin2BCD2
	ADDWF	BCDwk1,F

			; ��̈�(BCD1)���Z�o
	MOVF	BCDwk1,W
	MOVWF	BCD1

	RETURN

;}
;

; -----------------------------------------------------
;===================== goto_bed
;{
; �r�k�d�d�o���[�h�Ɉڍs
goto_bed
	BCF	INTCON,GIE	; �S�����݋֎~
	BCF	ADCON0,ADON	; A/D off
	CLRF	PORTA		; LM336,LM35D �d��OFF�C7�Z�OOFF
	
	;MOVLW	080h
	;ANDWF	PORTB,F		; 7�Z�OOFF
	
	CLRF	PORTB	; RB0,1 => OFF
	
	BCF	INTCON,RBIF	; RB�s���ω������݃t���O�N���A

	SLEEP

	BSF	PORTA,6		; LM336,LM35D �d��ON
	MOVLW	d'5'
	MOVWF	CNT5S		; 5�b�J�E���^�����ݒ�
	MOVF	PORTB,W
	BCF	INTCON,RBIF	; RB�s���ω������݃t���O�N���A
	BSF	INTCON,GIE	; �S�����݋���
	BSF	ADCON0,ADON	; A/D on

	RETURN

;}
;

; -----------------------------------------------------
;===================== ADave
; �`�c�ϊ����ʂ̕��ω�
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
; =========================== �����܂� ===============================