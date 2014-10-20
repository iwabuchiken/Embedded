
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	CBLOCK	020h
	
	sel7seg
	char
	
	ENDC

	ORG	0		;���Z�b�g�̓���
	GOTO	init

	ORG	4		;�����݂̓���
;

; -----------------------------------------------------
; ��������
;=========================== init
;{
init
	bsf		STATUS, RP0	; bank 1
	
	;bcf		OPTION_REG, NOT_RBPU
	movlw	B'00000000'	; PORTB -> inputs
	movwf	TRISB
	movlw	B'00000000'	; PORTA -> outputs
	movwf	TRISA
	
	bcf	STATUS,RP0	; bank 0
;}
;

; -----------------------------------------------------
; ���C������
main
	
	; sel7seg
	MOVLW	01h		; digit 1	
	MOVWF	sel7seg
	
	; char
	MOVLW	0Ah
	MOVWF	char
	

main1

	CALL	chg7seg
	
	GOTO	main1

; -----------------------------------------------------
;====================== chg7seg
;{
; �V�Z�O�����g�k�d�c�\���؂�ւ�
chg7seg
	;MOVLW	078h
	;ANDWF	PORTA,F		;�S�V�Z�O����

;	BCF	STATUS,C
;	RRF	sel7seg,F	;���̂V�Z�O��
;
	BTFSC	sel7seg,0	;�V�Z�O���P�H
	GOTO	chg7seg1	; Yes
	BTFSC	sel7seg,1	;�V�Z�O���Q�H
	GOTO	chg7seg2	; Yes

	;MOVLW	04h
	;MOVWF	sel7seg
	GOTO	chg7seg3	;�V�Z�O���R

chg7seg1

	BSF		PORTB,1
	BCF		PORTB,1

;	BTFSC	PORTB,7
;	BSF	PORTA,7		;NaPiOn�̏�Ԃ������_�ŕ\��
	;MOVF	BCD1,W
	GOTO	chg7seg9

chg7seg2
	
	BSF		PORTB,1
	BCF		PORTB,1
	BSF		PORTB,1
	BCF		PORTB,1

	;BSF	PORTA,7		;�����_��\��
	;edit
	;BSF		PORTB,0		; period
	
	;MOVF	BCD2,W
	GOTO	chg7seg9
chg7seg3
	
	BSF		PORTB,1
	BCF		PORTB,1
	BSF		PORTB,1
	BCF		PORTB,1
	BSF		PORTB,1
	BCF		PORTB,1

	;MOVF	BCD3,W
	;BTFSC	STATUS,Z	;0?
	;GOTO	chg7segX	; Yes

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
;====================== bcd2led
; �a�b�c�S�r�b�g���V�Z�O�����g�k�d�c�\���p�P�O�i���ɕϊ�
;{
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

	END
; =========================== �����܂� ===============================