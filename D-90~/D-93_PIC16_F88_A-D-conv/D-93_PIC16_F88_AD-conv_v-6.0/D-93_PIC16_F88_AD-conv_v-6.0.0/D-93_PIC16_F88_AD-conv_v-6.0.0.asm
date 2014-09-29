	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

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
;}
;	
	ORG		0
	GOTO	START

	ORG		4
	CALL	Timer0_interrupt
	RETFIE

; ====================================== START
;START
;{
START
	BSF		STATUS,RP0
	BCF		STATUS,RP1
	
	CLRF	ANSEL

	;------------------ TRISB
	CLRF	TRISB		; output

	;------------------ TMR0
	BCF		OPTION_REG,T0CS		; FOSC, FOSC/4 = XMh/4
	BCF		OPTION_REG,PSA		; pre-scaler to TMR0
								; 	=> PSA = 1, then pre-scaler to WDT
	BSF		OPTION_REG,PS2
	BSF		OPTION_REG,PS1
	BSF		OPTION_REG,PS0		; TMR0 clock => FOSC/4/256
	
	;------------------ interrupt
	BSF		INTCON,GIE		; all interrupt => permitted
							;	--> except masked ones
	BSF		INTCON,PEIE		; all interrupt from peripheries => permitted
							;	--> except masked ones
	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
	BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	
	BCF	STATUS,RP0	;���y�[�W�O�ɐؑւ�
	BCF	STATUS,RP1	;

;}
;
; ====================================== STEP1
;{
STEP1	

	MOVLW	B'00000000'
	MOVWF	PORTB
	
	GOTO	STEP1
;}
;

; ====================================== Timer0_interrupt
;{
Timer0_interrupt

	MOVLW	B'00000001'
	;MOVLW	B'00000010'
	MOVWF	PORTB

;	;CALL	T5mS
;	CALL	T02mS
;	
;	;MOVLW	B'00000010'
;	;MOVLW	B'00000000'
;	MOVLW	B'00000001'
;	MOVWF	PORTB
;
;	;CALL	T5mS
;	CALL	T02mS
;	
	;----------------- COUNT UP
	;MOVLW	B'11100000'
	MOVLW	B'00000000'
	
	MOVWF	TMR0			; set the initial val to TMR0
	
	BCF		INTCON,TMR0IF	; permit re-interrupt by TMR0
	
	RETURN

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