
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	CBLOCK	020h
	
	sel7seg
	char
	
	ENDC

;=========================== memory
;{
;memory

	; EEPROM Data
	org		0x2100
	
	de		0Ah, 0Bh
	
	;de		"Timer Program"
	;de		0x00, D'34', 'Z'
;
;}
;


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
	movlw	B'00000000'	; RB0~RB3 -> outputs
	movwf	TRISB
	movlw	B'01110000'	; RA0~3 -> outputs
						; RA4~6	-> inputs
						; RA7	-> output
						
	movwf	TRISA
	
	; ADC
	MOVLW	0h
	MOVWF	ANSEL
	
	bcf	STATUS,RP0	; bank 0
	
	;------------ PORTA
	MOVLW	0h
	MOVWF	PORTA
	
;}
;

;=========================== memory
;{
;memory
;
;	; EEPROM Data
;	org	0x2100
;	de	"Timer Program"
;	de	0x00, D'34', 'Z'
;
;}
;

; -----------------------------------------------------
;=========================== main
;{
; ���C������
main
	
	; sel7seg
	MOVLW	01h		; digit 1	
	MOVWF	sel7seg
	
	; char
	;MOVLW	05h
	MOVLW	07h
	MOVWF	char
	
main1

;	MOVF	PORTB,W
;	ANDLW	07H		; 0000 0111
;	
;	SUBLW	01H
;	
;	BTFSS	STATUS,Z	; 01h?
;						; if yes, goto DIGIT_1
	
	BTFSS	PORTA,4
	
	GOTO	DIGIT_2
	GOTO	DIGIT_1

DIGIT_1

	MOVLW	01H
	MOVWF	char
	
	GOTO	DISPLAY

DIGIT_2

	;MOVLW	02H
	;MOVWF	char
	CALL	GET_MEMORY
	
	GOTO	DISPLAY

DISPLAY

	CALL	chg7seg
	
	GOTO	main1

;}
;

; -----------------------------------------------------
;====================== GET_MEMORY
;{
GET_MEMORY

	MOVLW	0h
	
	;BANKSEL	PORTA
	
	
	;BANKSEL	PO
	
	BANKSEL	EEADR
	MOVWF	EEADR
	
	; read
	BANKSEL	EECON1		;Select Bank of EECON1
	BCF		EECON1,EEPGD	;Point to Data memory
	BSF		EECON1,RD	;�ǂݏo���J�n
	
	; move data
	BANKSEL	EEDATA		;Select Bank of EEDATA
	MOVF	EEDATA,W		;Wreg = EEDAT
	
	; back to BANK0
	BANKSEL	PORTB
	
	; data to char
	MOVWF	char		; W -> char
	
;	bsf		STATUS,RP0	; ���W�X�^�o���N�P��I��
;	
;	BCF		EECON1,EEPGD
;	bsf		EECON1, RD	; EEPROM �f�[�^��ǂ݂Ƃ�
;	
;	bcf		STATUS, RP0	; ���W�X�^�o���N�O��I��
;	
;	;movf	EEDATA, 0	; EEPROM �f�[�^ �� W ���W�X�^
;	movf	EEDATA,W
;	
;	MOVWF	char		; W -> char

	RETURN
;}
;

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


;	BTFSC	PORTB,7
;	BSF	PORTA,7		;NaPiOn�̏�Ԃ������_�ŕ\��
	;MOVF	BCD1,W
	
	MOVF	char,W
	
	GOTO	chg7seg9

chg7seg2
	

	;BSF	PORTA,7		;�����_��\��
	;edit
	;BSF		PORTB,0		; period
	
	;MOVF	BCD2,W
	GOTO	chg7seg9
chg7seg3
	
	;MOVF	BCD3,W
	;BTFSC	STATUS,Z	;0?
	;GOTO	chg7segX	; Yes
	
	MOVF	char,W

chg7seg9
	CALL	bcd2led		;�V�Z�O�\���p�P�O�i���ɕϊ�
	MOVWF	PORTB
	MOVF	sel7seg,W
	IORWF	PORTA,F		;�V�Z�O�\��
	;MOVWF	PORTA
	
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
	
	RETLW	077h	;A
	RETLW	07Ch	;b
	RETLW	039h	;C
	RETLW	05Eh	;d
	RETLW	079h	;E
	RETLW	071h	;F

;	RETLW	040h	;a
;	RETLW	040h	;b
;	RETLW	040h	;c
;	RETLW	040h	;d
;	RETLW	040h	;e
;	RETLW	040h	;f	
;}
;

	END
; =========================== �����܂� ===============================