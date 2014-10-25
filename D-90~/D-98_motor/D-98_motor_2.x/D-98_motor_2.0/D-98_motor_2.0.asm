
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG  _CONFIG1, _HS_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF
	
	;REF http://homepage3.nifty.com/mitt/pic/pic88_3_1.html
	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

	CBLOCK	020h

	Memory
	MEM1
	TIME1	
	TIME2
	TIME3

	C02mS	; 0.2mS�J�E���^
	C5mS	; 5mS�J�E���^
	C1S	; 1S�J�E���^
	
	cnt
	
	ENDC

;=========================== CONSTANTS
MEMORY_START_ADDR	EQU	03h

;WAIT_LENGTH			EQU D'15'	; Pulse will be
; Pulse will be
								; 	=> LENGTH x 0.2 x 2 (ms)
;WAIT_LENGTH			EQU D'30'	; 30 x 0.2 x 2 = 12 ms
;WAIT_LENGTH			EQU D'60'	; 60 x 0.2 x 2 = 24 ms	=> working
;WAIT_LENGTH			EQU D'30'	; 30 x 0.2 x 2 = 12 ms		=> working

WAIT_LENGTH			EQU D'15'		; 15 x 0.2 x 2 = 6 ms		=> w, 1 s/rotate (average)

;=========================== ORG
	ORG	0		;���Z�b�g�̓���
	GOTO	init

	ORG	4		;�����݂̓���
	
;=========================== INTR
;{
INTR

	BTFSC	INTCON,INTF
	
	GOTO	INT_RB0
	GOTO	INT_EXIT
	
INT_RB0

	BCF		PORTA,0
	BSF		PORTA,0

	MOVLW	05h
	CALL	T02XmS	

	BCF		PORTA,0

INT_EXIT
	
	RETFIE
	
;}
;


; ��������
;=========================== init
;{
init
	bsf		STATUS, RP0	; bank 1
	
	;bcf		OPTION_REG, NOT_RBPU
	movlw	B'11000000'	; RB0~RB5	-> outputs
						; RB6,7		=> inputs
	movwf	TRISB
	
	movlw	B'00000000'	; RA0~7 -> outputs
	movwf	TRISA
	
	; ADC
	MOVLW	0h
	MOVWF	ANSEL
	
	bcf	STATUS,RP0	; bank 0
	
	;------------ PORTB
	MOVLW	B'00000101'
	MOVWF	PORTB

	;------------ vars
	MOVLW	0h
	MOVWF	cnt
	
;}
;

; -----------------------------------------------------
;=========================== main
;{
; ���C������
main

main1

	;CALL	RotateR
	CALL	RotateR_2
	
;	BSF		PORTB,1
;	CALL	COUNT1
;	
;	BCF		PORTB,1
;	CALL	COUNT1
	
	GOTO	main1

;}
;

;====================== RotateR_2
;{
RotateR_2

	MOVLW	B'00000101'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00000110'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001010'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	MOVLW	B'00001001'
	MOVWF	PORTB
	
	MOVLW	WAIT_LENGTH
	CALL	T02XmS
	
	RETURN
	
;}
;

;====================== RotateR
;{
RotateR

	MOVLW	B'00000101'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00000110'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00001010'
	MOVWF	PORTB
	CALL	COUNT1
	
	MOVLW	B'00001001'
	MOVWF	PORTB
	CALL	COUNT1
	
	RETURN
	
;}
;

;====================== COUNT1
;{
COUNT1

	MOVLW	0x16
	MOVWF	TIME1
	
STEPM
	MOVWF	TIME2

STEPM1
	MOVWF	TIME3
	
STEPM2
	DECFSZ	TIME3,1
	GOTO	STEPM2
	
	DECFSZ	TIME2,1
	GOTO	STEPM1
	
	DECFSZ	TIME1,1
	GOTO	STEPM
	
	RETURN
;}
;

; ============================================================
;{
    ; �����@1S�҂T�u���[�`���@����   
T1S
	MOVLW	d'200'
	MOVWF	C1S		; ���[�v�񐔂Ƃ���200���Z�b�g�j
T1SLP	CALL	T5mS		; 5mS�҂�
	DECFSZ	C1S,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T1SLP		;
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@5mS�҂T�u���[�`���@����   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ���[�v�񐔂Ƃ���25���Z�b�g�j
T5mLP	CALL	T02mS		; 0.2mS�҂�
	DECFSZ	C5mS,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T5mLP
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@0.2mS�҂T�u���[�`���@����   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ���[�v�񐔂Ƃ���249���Z�b�g
T02mLP	NOP			; ���������P�T�C�N������
	DECFSZ	C02mS,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T02mLP
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�

;}
;

;====================== T02XmS
;{
T02XmS
	;MOVLW	d'25'
	MOVWF	C5mS		; ���[�v�񐔂Ƃ���25���Z�b�g�j
	
	CALL	T5mLP
	
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�



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