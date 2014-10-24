
	LIST      P=PIC16F88
	#INCLUDE  P16F88.INC

	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _INTRC_IO & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	;__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _MCLR_OFF & _BODEN_OFF & _PWRTE_ON & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
	__CONFIG  _CONFIG1, _HS_OSC & _CP_OFF & _WDT_OFF & _PWRTE_ON
	;__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

	CBLOCK	020h

	Memory
	MEM1
	TIME1	
	TIME2
	TIME3

	cnt
	
	ENDC

;=========================== CONSTANTS
MEMORY_START_ADDR	EQU	03h

;=========================== ORG
	ORG	0		;ÉäÉZÉbÉgÇÃì¸å˚
	GOTO	init

	ORG	4		;äÑçûÇ›ÇÃì¸å˚
;



; -----------------------------------------------------
; èâä˙èàóù
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
; ÉÅÉCÉìèàóù
main

main1

	;CALL	RotateR
	
	BSF		PORTA,0
	CALL	COUNT1
	
	BCF		PORTA,0
	CALL	COUNT1
	
	GOTO	main1

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


; -----------------------------------------------------
;====================== bcd2led
; ÇaÇbÇcÇSÉrÉbÉgÇÇVÉZÉOÉÅÉìÉgÇkÇdÇcï\é¶ópÇPÇOêiêîÇ…ïœä∑
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
; =========================== Ç±Ç±Ç‹Ç≈ ===============================