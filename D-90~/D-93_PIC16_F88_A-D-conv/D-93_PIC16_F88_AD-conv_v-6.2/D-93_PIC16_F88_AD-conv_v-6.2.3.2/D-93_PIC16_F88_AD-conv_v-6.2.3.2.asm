	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

; ====================================== VARS
	CBLOCK	020h

	C02mS	; 0.2mS�J�E���^
	C5mS	; 5mS�J�E���^
	C1S	; 1S�J�E���^	

	CNT5mS
	timer		;1:996mS	
	
	ENDC

; ====================================== constants
f_t50u	EQU	0	;timer bit0:51.2��S�t���O
f_t5mS	EQU	1	;timer bit1:5mS�t���O

; ====================================== ORG 0
	ORG		0
	GOTO	INIT

; ====================================== ORG 4
	ORG		4
	CALL	intr
	
	RETFIE

; ====================================== INIT
;INIT
;{
INIT

	;------------------ switch bank
	BSF		STATUS,RP0
	
	;------------------ ANSEL
	CLRF	ANSEL

	;------------------ TRISB, TRISB
	CLRF	TRISB		; output
	CLRF	TRISA		; output

	;------------------ OPTION_REG
	MOVLW	88h
	MOVWF	OPTION_REG
	
	;------------------ switch bank
	BCF		STATUS,RP0
	
	;------------------ PORTA,B
	MOVLW	0h
	MOVWF	PORTB
	
	;------------------ vars
		
	MOVLW	d'98'
	MOVWF	CNT5mS
	
	;------------------ interrupt
	CLRF	TMR0

	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
							; |= 0x20
							
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
							; |= 0x80
;}
;

; ====================================== LOOP
;{
	MOVLW	00h
	
	MOVWF	PORTB

LOOP	

	BTFSC	timer,f_t5mS
	
	CALL	LED_ON
	
	GOTO	LOOP
;}
;

; ====================================== LED_2_ON
;{
LED_ON

	MOVLW	01h
	
	MOVWF	PORTB

	MOVLW	00h
	
	MOVWF	PORTB

;	MOVLW	d'100'
;	
;	CALL	TX5mS
	
	;XORWF	MASK,PORTB

	BCF		timer,f_t5mS
	
	RETURN
;}
;

; ====================================== intr
;{
intr

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; clear flag

	DECFSZ	CNT5mS,F	;5mS�o�߁H
	GOTO	intr9		; No
	
	MOVLW	d'98'
	MOVWF	CNT5mS
	BSF	timer,f_t5mS	;5mS�o�߃t���O�Z�b�g
;	
;	MOVLW	01h
;	MOVWF	PORTB
;	
;	MOVLW	d'200'
;	CALL	TX5mS
;
;	MOVLW	02h
;	MOVWF	PORTB
;
;	MOVLW	d'100'
;	CALL	TX5mS
;
;	MOVLW	00h
;	MOVWF	PORTB

	CLRF	TMR0

intr9
	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt

	RETURN
	
;intr_1

;	DECFSZ	CNT5mS,F
;	
;	GOTO	intr9
;	
;	MOVLW	d'50'
;	MOVWF	CNT5mS
	
	;BSF		timer,f_t5mS

;intr9
	;------------------- reset
	;BSF		INTCON,TMR0IE	; permit timer interrupt
	;BSF		INTCON,GIE		; permit global interrupt
	

	;RETURN

;}
;

;
; ====================================== TX5mS
;{TX5mS
; �����@X * 5mS �҂T�u���[�`���@����   
TX5mS
	;MOVLW	d'200'
	MOVWF	C1S		; ���[�v�񐔂Ƃ���200���Z�b�g�j
T1SLP	
	CALL	T5mS		; 5mS�҂�
	DECFSZ	C1S,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T1SLP		;
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@5mS�҂T�u���[�`���@����   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ���[�v�񐔂Ƃ���25���Z�b�g�j
T5mLP	
	CALL	T02mS		; 0.2mS�҂�
	DECFSZ	C5mS,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T5mLP
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@0.2mS�҂T�u���[�`���@����   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ���[�v�񐔂Ƃ���249���Z�b�g
T02mLP	
	NOP			; ���������P�T�C�N������
	DECFSZ	C02mS,F		; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
	GOTO	T02mLP
	RETURN			; ���̃T�u���[�`���ďo�����ɖ߂�

;}
;

	END