	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF
;
;
;{CBLOCK
	CBLOCK	020h
	C02mS	; 0.2mS�J�E���^
	C5mS	; 5mS�J�E���^
	C1S	; 1S�J�E���^
	
	ADsaveL
	ADsaveH
	
	ENDC	
;}
;
	ORG		0
	GOTO	INIT

;	ORG		4
;	CALL	Timer0_interrupt
;	RETFIE

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

	;------------------ RB0 => ON, RA => OFF
	;MOVLW	01h
	MOVLW	00h
	MOVWF	PORTB

	MOVLW	00h
	MOVWF	PORTA
	
;	;------------------ OPTION_REG
;	MOVLW	88h
;	MOVWF	OPTION_REG
;	
	;------------------ switch bank
	BCF		STATUS,RP0
	
	;------------------ vars
	MOVLW	0ABh
	MOVWF	ADsaveL
	
	
;	;------------------ interrupt
;	CLRF	TMR0
;
;	BSF		INTCON,TMR0IE	; permit TMR0 interrupt
;							; |= 0x20
;							
;	BSF		INTCON,GIE		; all interrupt => permitted
;							;	--> except masked ones
;							; |= 0x80
;	
;	;BCF		INTCON,TMR0IF	; clear the interrupt flag of TMR0
	

;}
;
; ====================================== STEP1
;{
STEP1	
	
	;---------------- digit 1: RB0 --> socket 9
	;MOVLW	D'1'
	MOVLW	01h
	MOVWF	PORTA
	
	;MOVLW	00h
	;MOVF	ADsaveL,W
	SWAPF	ADsaveL,W
	ANDLW	0Fh
	
	CALL	bin2hex
	
	MOVWF	PORTB

	CALL	T5mS
	
	;---------------- digit 2: RB1 ---> socket 10
	MOVLW	02h
	MOVWF	PORTA
	
	;MOVLW	01h
	;SWAPF	ADsaveL,W
	MOVF	ADsaveL,W
	ANDLW	0Fh

	CALL	bin2hex
	MOVWF	PORTB
	
	CALL	T5mS
	
	;---------------- digit 3: RB2 ---> socket 11
	MOVLW	04h
	MOVWF	PORTA
	
	MOVLW	010h	; 0110 1110, 'H'
	
	CALL	bin2hex
	MOVWF	PORTB
	
	CALL	T5mS

	
	GOTO	STEP1
;}
;

; ====================================== Timer0_interrupt
;{
Timer0_interrupt

	BCF		INTCON,GIE		; forbid global interrupt
	BCF		INTCON,TMR0IE	; forbid timer interrupt
	
	BCF		INTCON,TMR0IF	; clear flag

	;------------------- change LED
	
	MOVLW	B'00000001'
	MOVWF	PORTA
	MOVWF	PORTB
	
	MOVLW	B'00000010'
	MOVWF	PORTA
	MOVWF	PORTB
	
	;------------------- re-init TMR0
	MOVLW	B'11110000'
	MOVWF	TMR0
	
	;------------------- reset
	BSF		INTCON,TMR0IE	; permit timer interrupt
	BSF		INTCON,GIE		; permit global interrupt
	

	RETURN

;}
;
; ====================================== T1S
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

; -----------------------------------------------------
;{ �o�C�i���S�r�b�g���V�Z�O�����g�k�d�c�\���p�P�U�i���ɕϊ�
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
;}
;

;========================================
	END