; ========================== �������� ==============================
;	PIC16F84A
;	clock:20MHz
;
;	�k�b�c���S�r�b�g�Ő���
;
;	�o�h�b�̃s���ڑ�
;		RB0	LCD DB4
;		RB1	LCD DB5
;		RB2	LCD DB6
;		RB3	LCD DB7
;
;		RA0	LCD R/W	(6:Read/Write)
;		RA1	LCD E	(5:Enable Signal)
;		RA2	LCD RS	(4:Register Select)
;
;	�g�p�^�C�}�i�v���O�������[�v�j
;		 15mS	�k�b�c�p���[�I�����Z�b�g�҂�
;		  5mS	�k�b�c���������[�`��
;		  1mS	�k�b�c���������[�`��
;		 50uS	�k�b�c���������[�`���C�������ݑ҂�
;


       ;LIST    P=PIC16F84A
       ;INCLUDE P16F84A.INC
		LIST      P=PIC16F88
		#INCLUDE  P16F88.INC
       ;__CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

	CBLOCK	020h
	save_st			;STATUS�̃Z�[�u
	save_w			;W-reg�̃Z�[�u
	CNT15mS			;15���r�J�E���^
	CNT5mS			;5���r�J�E���^
	CNT1mS			;1���r�J�E���^
	CNT50uS			;50�ʂr�J�E���^
	char			;LCD�\���f�[�^
	
	CHR
	
	ENDC

RW	EQU	00h		;LCD R/W
E	EQU	01h		;LCD Enable
RS	EQU	02h		;LCD Register Select
BUSY	EQU	03h		;BUSY FLAG (PORTB,3)


; ==================== �������� =====================
	org	0
init
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	0F8h
	MOVWF	TRISA		;RA0-2�͏o��
	MOVLW	0F0h
	MOVWF	TRISB		;RB0-3�͏o��
	
	; ADC
	MOVLW	0h
	MOVWF	ANSEL

	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�

	CLRF	PORTA
	CLRF	PORTB

	CALL	LCD_init	;LCD ������

	;----------------- vars
	MOVLW	30h		; '0'
	MOVWF	CHR
	
; ==================== ���C������ =====================
main

	;---------------- line: 1
	CALL	LCD_home	;�J�[�\�����P�s�ڂ̐擪��
	
	;MOVLW	'H'
	;MOVLW	0Ah		;=> display --> no char in the whole display
	
	MOVF	CHR,W
	CALL	LCD_write
	
	INCF	CHR,F
	;MOVLW	'e'
	;MOVLW	'a'
	MOVF	CHR,W
	CALL	LCD_write

	;---------------- line: 2	
	CALL	LCD_2line	;�J�[�\�����Q�s�ڂ̐擪��

	INCF	CHR,F
	;MOVLW	'e'
	;MOVLW	'a'
	MOVF	CHR,W
	CALL	LCD_write

	INCF	CHR,F
	;MOVLW	'e'
	;MOVLW	'a'
	MOVF	CHR,W
	CALL	LCD_write

;	MOVLW	'w'
;	CALL	LCD_write
;	MOVLW	'o'
;	CALL	LCD_write
;	MOVLW	'r'
;	CALL	LCD_write
;	MOVLW	'l'
;	CALL	LCD_write
;	MOVLW	'd'
;	CALL	LCD_write
;	MOVLW	'!'
;	CALL	LCD_write
;
	CLRF	PORTA
	CLRF	PORTB
	SLEEP

	GOTO	main


;================= �k�b�c�\�����N���A���� ===================
LCD_clear
	MOVLW	01h
	CALL	LCD_command
	RETURN

;================= �k�b�c�̃J�[�\���ʒu��擪�ɖ߂� =========
LCD_home
	MOVLW	02h
	CALL	LCD_command
	RETURN

;================= �k�b�c�̃J�[�\���ʒu���Q�s�ڂ̐擪�� =====
LCD_2line
	MOVLW	0C0h
	CALL	LCD_command
	RETURN

;================= �k�b�c�̃f�B�X�v���C���n�m�ɂ��� =========
LCD_on
	MOVLW	0Ch
	CALL	LCD_command
	RETURN

;================= �k�b�c�̃f�B�X�v���C�ƃJ�[�\�����n�m�ɂ��� ==
LCD_on_cur
	MOVLW	0Eh
	CALL	LCD_command
	RETURN

;================= �k�b�c�̃f�B�X�v���C���n�e�e�ɂ��� =======
LCD_off
	MOVLW	08h
	CALL	LCD_command
	RETURN

;================= �k�b�c�Ƀf�[�^�𑗂� =====================
LCD_write
	MOVWF	char
	CALL	LCD_BF_wait	;LCD busy �����҂�

	BCF	PORTA,RW	;R/W=0(Write)
	BSF	PORTA,RS	;RS=1(Data)

	MOVLW	0F0h		;PORTB�̉��ʂS�r�b�g��
	ANDWF	PORTB,F		;�@�N���A
	SWAPF	char,W		;���
	ANDLW	0Fh		;�S�r�b�g��
	IORWF	PORTB,F		;PORTB(3-0)�ɃZ�b�g�iPORTB(7-4)�͂��̂܂܁j
	BSF	PORTA,E		;�k�b�c�Ƀf�[�^��������
	NOP
	BCF	PORTA,E

	MOVLW	0F0h		;PORTB�̉��ʂS�r�b�g��
	ANDWF	PORTB,F		;�@�N���A
	MOVF	char,W		;����
	ANDLW	0Fh		;�S�r�b�g��
	IORWF	PORTB,F		;PORTB(3-0)�ɃZ�b�g�iPORTB(7-4)�͂��̂܂܁j
	BSF	PORTA,E		;�k�b�c�Ƀf�[�^��������
	NOP
	BCF	PORTA,E

	RETURN

;================= �k�b�c�ɃR�}���h�𑗂� ===================
LCD_command
	MOVWF	char
	CALL	LCD_BF_wait	;LCD busy �����҂�

	BCF	PORTA,RW	;R/W=0(Write)
	BCF	PORTA,RS	;RS=0(Command)

	MOVLW	0F0h		;PORTB�̉��ʂS�r�b�g��
	ANDWF	PORTB,F		;�@�N���A
	SWAPF	char,W		;���
	ANDLW	0Fh		;�S�r�b�g��
	IORWF	PORTB,F		;PORTB(3-0)�ɃZ�b�g�iPORTB(7-4)�͂��̂܂܁j
	BSF	PORTA,E		;�k�b�c�Ƀf�[�^��������
	NOP
	BCF	PORTA,E

	MOVLW	0F0h		;PORTB�̉��ʂS�r�b�g��
	ANDWF	PORTB,F		;�@�N���A
	MOVF	char,W		;����
	ANDLW	0Fh		;�S�r�b�g��
	IORWF	PORTB,F		;PORTB(3-0)�ɃZ�b�g�iPORTB(7-4)�͂��̂܂܁j
	BSF	PORTA,E		;�k�b�c�Ƀf�[�^��������
	NOP
	BCF	PORTA,E

	RETURN

;================= LCD Busy �����҂� ========================
LCD_BF_wait
	BCF	PORTA,E
	BCF	PORTA,RS	;RS=0(Control)
	BSF	PORTA,RW	;R/W=1(Read) Busy Flag read

	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	0FFh
	MOVWF	TRISB		;RB0-7�͓���
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�
	BSF	PORTA,E		;�k�b�c��ʂS�r�b�g�ǂݍ���
	NOP
	BTFSS	PORTB,BUSY	;LCD Busy ?
	GOTO	LCD_BF_wait1	; No
	BCF	PORTA,E
	NOP
	BSF	PORTA,E		;�k�b�c���ʂS�r�b�g�ǂݔ�΂�
	NOP
	BCF	PORTA,E
	GOTO	LCD_BF_wait

LCD_BF_wait1
	BSF	PORTA,E		;�k�b�c���ʂS�r�b�g�ǂݔ�΂�
	NOP
	BCF	PORTA,E
	BSF	STATUS,RP0	;���o���N�P�ɐؑւ�
	MOVLW	0F0h		;RB0-3�͏o��
	MOVWF	TRISB
	BCF	STATUS,RP0	;���o���N�O�ɐؑւ�

	RETURN

;================= LCD������ ================================
LCD_init
	CALL	wait15ms	;15mS�҂�
	BCF	PORTA,RW	;R/W=0
	BCF	PORTA,RS	;RS=0
	BCF	PORTA,E		;E=0

	MOVLW	0F0h		;PORTB�̏�ʂS�r�b�g��
	ANDWF	PORTB,W		;���o���i�ύX���Ȃ��悤�Ɂj
	IORLW	03h		;���ʂS�r�b�g��'�R'���Z�b�g
	MOVWF	PORTB
	BSF	PORTA,E		;�t�@���N�V�����Z�b�g�i�P��ځj
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS�҂�

	MOVLW	0F0h		;PORTB�̏�ʂS�r�b�g��
	ANDWF	PORTB,W		;���o���i�ύX���Ȃ��悤�Ɂj
	IORLW	03h		;���ʂS�r�b�g��'�R'���Z�b�g
	MOVWF	PORTB
	BSF	PORTA,E		;�t�@���N�V�����Z�b�g�i�Q��ځj
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS�҂�

	MOVLW	0F0h		;PORTB�̏�ʂS�r�b�g��
	ANDWF	PORTB,W		;���o���i�ύX���Ȃ��悤�Ɂj
	IORLW	03h		;���ʂS�r�b�g��'�R'���Z�b�g
	MOVWF	PORTB
	BSF	PORTA,E		;�t�@���N�V�����Z�b�g�i�R��ځj
	NOP
	BCF	PORTA,E
	CALL	wait5ms		;5mS�҂�

	MOVLW	0F0h		;PORTB�̏�ʂS�r�b�g��
	ANDWF	PORTB,W		;���o���i�ύX���Ȃ��悤�Ɂj
	IORLW	02h		;�S�r�b�g���[�h
	MOVWF	PORTB		;��
	BSF	PORTA,E		;�ݒ�
	NOP
	BCF	PORTA,E
	CALL	wait1ms		;1mS�҂�

	MOVLW	028h		;�S�r�b�g���[�h�C�Q�s�\���C�V�h�b�g
	CALL	LCD_command
	CALL	LCD_off		;�f�B�X�v���C�n�e�e
	CALL	LCD_clear	;�k�b�c�N���A
	MOVLW	06h		;
	CALL	LCD_command	;�J�[�\�����[�h�Z�b�g (Increment)
	CALL	LCD_on		;�f�B�X�v���C�n�m�C�J�[�\���n�e�e

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

;================= 50��S WAIT ===============================
wait50us
	; �P�T�C�N���i�S�N���b�N�j�F�O�D�Q�ʂr
	; �T�O�ʂr���O�D�Q�ʂr�~�Q�T�O�T�C�N��

	MOVLW	d'82'		;1
	MOVWF	CNT50uS		;1
wait50us_loop
	DECFSZ	CNT50uS,F	;1
	GOTO	wait50us_loop	;2
	RETURN			;2+1

	END
; ========================== �����܂� ==============================
