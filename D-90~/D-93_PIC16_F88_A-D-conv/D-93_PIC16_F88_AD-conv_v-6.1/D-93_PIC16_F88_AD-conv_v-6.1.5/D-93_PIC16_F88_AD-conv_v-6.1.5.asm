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
	
	CNT			; counter
	
	ADsaveL
	ADsaveH
	
	sel7seg
	
	ENDC	
;}
;
	ORG		0
	GOTO	SETUP

;	ORG		4
;	CALL	Timer0_interrupt
;	RETFIE

; ====================================== SETUP
;SETUP
;{
SETUP

	;------------------ switch bank
	BSF		STATUS,RP0
	
	;------------------ ANSEL
	;CLRF	ANSEL

	;------------------ TRISB, TRISB
	MOVLW	0F8h		; 1111 1000
	CLRF	TRISA		; output

	CLRF	TRISB		; output

	;------------------ OPTION_REG
	MOVLW	88h
	MOVWF	OPTION_REG
	
	;------------------ switch bank
	BCF		STATUS,RP0
	

	;------------------ RB0 => ON, RA => OFF
	MOVLW	01h
	MOVWF	PORTB

	;------------------ A/D
	MOVLW	099h	; 1001 1001
	MOVWF	ADCON0
	
	BSF		STATUS,RP0	; BANK 1
	
	MOVLW	80h		; 1000 0000
	MOVWF	ADCON1
	
	MOVLW	08h		; 0000 1000
	MOVWF	ANSEL
	
	BCF		STATUS,RP0	; BANK 0
	
	MOVLW	0ABh
	MOVWF	ADsaveL
	
	MOVLW	0h
	MOVWF	CNT
	
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
; ====================================== INIT
;{
INIT_1

	MOVLW	03h
	MOVWF	PORTB		; RA0,1 --> ON (while reading ANS3)

	BSF		ADCON0,GO	; start ADC
	
INIT_2
	
	BTFSC	ADCON0,GO	; ADC --> done?
	GOTO	INIT_2		; NO

INIT_3	; get values

	MOVF	ADRESH,W
	MOVWF	ADsaveH
	
	BSF		STATUS,RP0
	
	MOVF	ADRESL,W
	
	BCF		STATUS,RP0
	
	MOVWF	ADsaveL
	
INIT_4	; digits
	MOVLW	04h
	MOVWF	sel7seg

INIT_5	; counter
	MOVLW	0h
	MOVWF	CNT

;}
;

; ====================================== LOOP
;{
LOOP	
	
;ADC ;----------------------------------
;	BSF		ADCON0,GO	; start ADC	
;	BTFSC	ADCON0,GO	; ADC --> done?
;	GOTO	ADC		; NO	
;
;GET_VALUES ;----------------------------
;	MOVF	ADRESH,W
;	MOVWF	ADsaveH
;	
;	BSF		STATUS,RP0
;	
;	MOVF	ADRESL,W
;	
;	BCF		STATUS,RP0
;	
;	MOVWF	ADsaveL
	
CHG ;----------------------------------	
	CALL	chg7seg		; ADsaveL, upper 4 bits
	
;CHG ;----------------------------------	
;	CALL	chg7seg		; ADsaveL, upper 4 bits
;	CALL	T5mS
;	
;	CALL	chg7seg		; ADsaveL, lower 4 bits
;	CALL	T5mS
;	
;	CALL	chg7seg		; ADsaveH
;	CALL	T5mS

WAIT ;----------------------------------	
	CALL	T5mS
	;CALL	T1S
	
	GOTO	LOOP
;}
;

;====================================== chg7seg
;{
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
	
;}
;

;====================================== chg7seg1
;{
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
	
	ANDLW	0Fh
	
	CALL	bin2hex		;�V�Z�O�\���p�P�U�i���ɕϊ�
	MOVWF	PORTB
	GOTO	chg7seg9

chg7seg9
	MOVF	sel7seg,W
	MOVWF	PORTA		;�V�Z�O�\��
	RETURN

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

; ====================================== bin2hex
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