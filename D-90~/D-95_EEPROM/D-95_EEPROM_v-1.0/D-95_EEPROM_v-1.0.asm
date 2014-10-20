; Program 7.8-1
; EEPROM write
; (write data along with the program)
; by D. Asano
; 2004/7

;	list p=PIC16F84A
;	#include <p16f84a.inc>
;
;	__CONFIG _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
	LIST	P=PIC16F88
	INCLUDE	P16F88.INC

	__CONFIG _CONFIG1, _HS_OSC & _WDT_OFF & _PWRTE_OFF & _CP_OFF & _LVP_OFF & _CPD_OFF
	__CONFIG _CONFIG2, _FCMEN_OFF & _IESO_OFF

; EEPROM Data
	org	0x2100
	de	"Timer Program"
	de	0x00, D'34', 'Z'

	end