	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	;__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRITE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF & _BODEN_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF

;CBLOCK
;{
	CBLOCK	020h
	
	CNT1	
	CNT2
	CNT3

	MEM1
	
	C02mS	; 0.2mS�J�E���^
	C5mS	; 5mS�J�E���^
	C1S	; 1S�J�E���^
	
	ENDC
	
	ORG		0
;}
;

; ====================================== MAIN
;MAIN
;{
MAIN
	BSF		STATUS,RP0
	CLRF	ANSEL

	;------------------ TRISB
	CLRF	TRISB		; output
	
	;------------------ TRISA
	MOVLW	018h
	MOVWF	TRISA		;RA0,1,2�͏o�́CRA3,4�͓���
	
	BCF	STATUS,RP0	;���y�[�W�O�ɐؑւ�

;}
;
; ====================================== LOOP
;{
LOOP
	;------------------- digit 3
	CLRF	PORTB
	
	MOVLW	d'0'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'0'
	CALL	SET_NUM
	MOVWF	PORTB
	
	CALL	T02mLP
	
	;------------------- digit 2
	CLRF	PORTB
	
	MOVLW	d'1'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'1'
	CALL	SET_NUM
	MOVWF	PORTB

	CALL	T02mLP
		
	;------------------- digit 1
	CLRF	PORTB
	
	MOVLW	d'2'
	CALL	SET_DIGIT
	MOVWF	PORTA
	
	MOVLW	d'2'
	CALL	SET_NUM
	MOVWF	PORTB
	
	CALL	T02mLP
	
	GOTO	LOOP
;}
;

;REF block comment http://www.microchip.com/forums/m177800.aspx
;{
;	MOVLW	02h
;	MOVWF	PORTB
;	
;	CALL	DLY_1S
;	
;	MOVLW	01h
;	MOVWF	PORTB
;	
;	CALL	DLY_1S
;	
;	GOTO	LOOP
;}
;
; ====================================== DLY_1S
;DLY_1S
;{		
DLY_1S
	movlw		d'10'
	movwf		CNT3
	
DLY_100
	movlw		d'100'
	movwf		CNT1

DLP1
	movlw		d'200'
	movwf		CNT2
	
DLP2
	nop
	nop
	
	decfsz		CNT2,f
	goto		DLP2
	
	decfsz		CNT1,f
	goto		DLP1
	
	decfsz		CNT3,f
	goto		DLY_100
	
	retlw		0
;}

;

; ====================================== T1S
;T1S
;{    ; �����@1S�҂T�u���[�`���@����   
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

; ====================================== SET_NUM
;SET_NUM
;{
SET_NUM
	ADDWF	PCL,F
	
	RETLW	0FCh	; 1111 1100, 0
	RETLW	060h	; 0110 0000, 1
	RETLW	0DAh	; 1101 1010, 2
;}
;

; ====================================== SET_DIGIT
;{
SET_DIGIT
	ADDWF	PCL,F
	
	RETLW	01h	; 0000 0001, 1
	RETLW	02h	; 0000 0010, 2
	RETLW	04h	; 0000 0100, 4

;}
;
;==================================
	END