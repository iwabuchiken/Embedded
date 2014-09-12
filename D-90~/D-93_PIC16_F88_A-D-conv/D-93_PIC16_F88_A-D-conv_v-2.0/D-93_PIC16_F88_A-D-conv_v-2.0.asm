	LIST      P=16F88
	#INCLUDE  P16F88.INC

	__CONFIG  _CONFIG1, _CP_OFF & _WDT_OFF & _BODEN_ON & _PWRTE_ON & _HS_OSC & _LVP_OFF & _CPD_OFF & _DEBUG_OFF



;MEM1	EQU		0x0C
MEM1	EQU		0x20

		ORG		0
		goto	START
		
		ORG		4
		

START
		BSF		STATUS,RP0
		
		MOVLW	B'00000111'
		MOVWF	TRISB
		
		BCF		STATUS,RP0
		
STEP1	MOVF	PORTB,0
		ANDLW	B'00000111'
		MOVWF	MEM1
		
		RLF		MEM1,1
		RLF		MEM1,1
		RLF		MEM1,1
		RLF		MEM1,1
		
		MOVF	MEM1,0
		MOVWF	PORTB
		
		GOTO	STEP1
		
		END
		