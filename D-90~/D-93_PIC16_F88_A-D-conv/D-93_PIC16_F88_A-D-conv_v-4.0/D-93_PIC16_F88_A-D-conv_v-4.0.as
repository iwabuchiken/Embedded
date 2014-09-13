opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 10920"

opt pagewidth 120

	opt lm

	processor	16F88
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 5 "C:\WORKS\WS\Embedded\D-90~\D-93_PIC16_F88_A-D-conv\D-93_PIC16_F88_A-D-conv_v-4.0\D-93_PIC16_F88_A-D-conv_v-4.0.c"
	psect config,class=CONFIG,delta=2 ;#
# 5 "C:\WORKS\WS\Embedded\D-90~\D-93_PIC16_F88_A-D-conv\D-93_PIC16_F88_A-D-conv_v-4.0\D-93_PIC16_F88_A-D-conv_v-4.0.c"
	dw 0x2FFF & 0x3FFF & 0x3F7F & 0x3FFF & 0x3FDF & 0x3FF7 & 0x3FFB & 0x3FFC ;#
	FNROOT	_main
	global	_PORTA
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_ANSEL
_ANSEL	set	155
	global	_OSCCON
_OSCCON	set	143
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	file	"D-93_PIC16_F88_A-D-conv_v-4.0.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	??_main
??_main:	; 0 bytes @ 0x0
	ds	2
;;Data sizes: Strings 0, constant 0, data 0, bss 0, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      2       2
;; BANK0           80      0       0
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:



;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 2, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 2     2      0       0
;;                                              0 COMMON     2     2      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 0
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%
;;NULL                 0      0       0       0        0.0%
;;CODE                 0      0       0       0        0.0%
;;COMMON               E      2       2       1       14.3%
;;BITSFR0              0      0       0       1        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;SFR1                 0      0       0       2        0.0%
;;STACK                0      0       0       2        0.0%
;;ABS                  0      0       0       3        0.0%
;;BITBANK0            50      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BANK0               50      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;BANK3               60      0       0       9        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;BANK2               60      0       0      11        0.0%
;;DATA                 0      0       0      12        0.0%

	global	_main
psect	maintext

;; *************** function _main *****************
;; Defined at:
;;		line 7 in file "C:\WORKS\WS\Embedded\D-90~\D-93_PIC16_F88_A-D-conv\D-93_PIC16_F88_A-D-conv_v-4.0\D-93_PIC16_F88_A-D-conv_v-4.0.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          2       0       0       0       0
;;      Totals:         2       0       0       0       0
;;Total ram usage:        2 bytes
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"C:\WORKS\WS\Embedded\D-90~\D-93_PIC16_F88_A-D-conv\D-93_PIC16_F88_A-D-conv_v-4.0\D-93_PIC16_F88_A-D-conv_v-4.0.c"
	line	7
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 8
; Regs used in _main: [wreg+status,2]
	line	9
	
l2317:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 9: OSCCON = 0b0110000;
	movlw	(030h)
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	movwf	(143)^080h	;volatile
	line	16
	
l2319:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 16: ANSEL = 0b00000000;
	clrf	(155)^080h	;volatile
	line	17
	
l2321:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 17: TRISA = 0b00000000;
	clrf	(133)^080h	;volatile
	line	18
	
l2323:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 18: TRISB = 0b00000000;
	clrf	(134)^080h	;volatile
	line	19
	
l2325:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 19: PORTA = 0b00000000;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(5)	;volatile
	line	20
	
l2327:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 20: PORTB = 0b00000000;
	clrf	(6)	;volatile
	goto	l2329
	line	22
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 22: while(1) {
	
l485:	
	line	24
	
l2329:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 24: PORTA = 0x01;
	movlw	(01h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(5)	;volatile
	line	26
	
l2331:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 26: _delay((unsigned long)((50)*(4000000/4000.0)));
	opt asmopt_off
movlw	65
movwf	((??_main+0)+0+1),f
	movlw	238
movwf	((??_main+0)+0),f
u2227:
	decfsz	((??_main+0)+0),f
	goto	u2227
	decfsz	((??_main+0)+0+1),f
	goto	u2227
	clrwdt
opt asmopt_on

	line	28
	
l2333:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 28: PORTA = 0x02;
	movlw	(02h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(5)	;volatile
	line	30
	
l2335:	
;D-93_PIC16_F88_A-D-conv_v-4.0.c: 30: _delay((unsigned long)((50)*(4000000/4000.0)));
	opt asmopt_off
movlw	65
movwf	((??_main+0)+0+1),f
	movlw	238
movwf	((??_main+0)+0),f
u2237:
	decfsz	((??_main+0)+0),f
	goto	u2237
	decfsz	((??_main+0)+0+1),f
	goto	u2237
	clrwdt
opt asmopt_on

	goto	l2329
	line	32
	
l486:	
	line	22
	goto	l2329
	
l487:	
	line	34
	
l488:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
psect	maintext
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
