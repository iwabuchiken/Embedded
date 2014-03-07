;  ASM code generated by mikroVirtualMachine for PIC - V. 8.2.0.0
;  Date/Time: 2014/03/07 15:57:08
;  Info: http://www.mikroe.com


; ADDRESS	OPCODE	ASM
; ----------------------------------------------
$0000	$28E3			GOTO	_main
$0273	$	_____DoICP:
$0273	$1303			BCF	STATUS, RP1
$0274	$1283			BCF	STATUS, RP0
$0275	$080D			MOVF	___DoICPHiAddr, 0
$0276	$008A			MOVWF	PCLATH
$0277	$080E			MOVF	___DoICPLoAddr, 0
$0278	$0082			MOVWF	PCL
$0279	$0008			RETURN
$018F	$	_strConstCpy2:
;utils.h,12 :: 		(char *dest, const char *source)
;utils.h,14 :: 		while(*source)
$018F	$	L_strConstCpy2_6:
$018F	$1303			BCF	STATUS, RP1
$0190	$1283			BCF	STATUS, RP0
$0191	$0823			MOVF	FARG_strConstCpy2+1, 0
$0192	$008E			MOVWF	___DoICPLoAddr
$0193	$0824			MOVF	FARG_strConstCpy2+2, 0
$0194	$008D			MOVWF	___DoICPHiAddr
$0195	$080A			MOVF	PCLATH, 0
$0196	$008C			MOVWF	___DoICPSavePCLATH
$0197	$2273			CALL	_____DoICP
$0198	$00C0			MOVWF	STACK_0
$0199	$080C			MOVF	___DoICPSavePCLATH, 0
$019A	$008A			MOVWF	PCLATH
$019B	$0840			MOVF	STACK_0, 0
$019C	$1903			BTFSC	STATUS, Z
$019D	$29B1			GOTO	L_strConstCpy2_7
;utils.h,15 :: 		*dest++ = *source++ ;
$019E	$0823			MOVF	FARG_strConstCpy2+1, 0
$019F	$008E			MOVWF	___DoICPLoAddr
$01A0	$0824			MOVF	FARG_strConstCpy2+2, 0
$01A1	$008D			MOVWF	___DoICPHiAddr
$01A2	$080A			MOVF	PCLATH, 0
$01A3	$008C			MOVWF	___DoICPSavePCLATH
$01A4	$2273			CALL	_____DoICP
$01A5	$00C0			MOVWF	STACK_0
$01A6	$080C			MOVF	___DoICPSavePCLATH, 0
$01A7	$008A			MOVWF	PCLATH
$01A8	$0822			MOVF	FARG_strConstCpy2+0, 0
$01A9	$0084			MOVWF	FSR
$01AA	$0840			MOVF	STACK_0, 0
$01AB	$0080			MOVWF	INDF
$01AC	$0AA2			INCF	FARG_strConstCpy2+0, 1
$01AD	$0AA3			INCF	FARG_strConstCpy2+1, 1
$01AE	$1903			BTFSC	STATUS, Z
$01AF	$0AA4			INCF	FARG_strConstCpy2+2, 1
$01B0	$298F			GOTO	L_strConstCpy2_6
$01B1	$	L_strConstCpy2_7:
;utils.h,17 :: 		*dest = 0 ;
$01B1	$0822			MOVF	FARG_strConstCpy2+0, 0
$01B2	$0084			MOVWF	FSR
$01B3	$0180			CLRF	INDF, 1
;utils.h,18 :: 		}
$01B4	$0008			RETURN
$023E	$	table___s1:
;D_82_16F84A_SD1602_v_4_1.c,6 :: 		const char s1[]  = "Versionsgeschichte";
$023E	$3456			RETLW	86
$023F	$3465			RETLW	101
$0240	$3472			RETLW	114
$0241	$3473			RETLW	115
$0242	$3469			RETLW	105
$0243	$346F			RETLW	111
$0244	$346E			RETLW	110
$0245	$3473			RETLW	115
$0246	$3467			RETLW	103
$0247	$3465			RETLW	101
$0248	$3473			RETLW	115
$0249	$3463			RETLW	99
$024A	$3468			RETLW	104
$024B	$3469			RETLW	105
$024C	$3463			RETLW	99
$024D	$3468			RETLW	104
$024E	$3474			RETLW	116
$024F	$3465			RETLW	101
$0250	$3400			RETLW	0
$0251	$0008			RETURN
$0264	$	table___s2:
;D_82_16F84A_SD1602_v_4_1.c,9 :: 		const char s2[]  = "Schmargendorf";
$0264	$3453			RETLW	83
$0265	$3463			RETLW	99
$0266	$3468			RETLW	104
$0267	$346D			RETLW	109
$0268	$3461			RETLW	97
$0269	$3472			RETLW	114
$026A	$3467			RETLW	103
$026B	$3465			RETLW	101
$026C	$346E			RETLW	110
$026D	$3464			RETLW	100
$026E	$346F			RETLW	111
$026F	$3472			RETLW	114
$0270	$3466			RETLW	102
$0271	$3400			RETLW	0
$0272	$0008			RETURN
$0145	$	_Mul_16x16_S:
$0145	$1303			BCF	STATUS, RP1
$0146	$1283			BCF	STATUS, RP0
$0147	$01CB			CLRF	STACK_11
$0148	$01CA			CLRF	STACK_10
$0149	$01C9			CLRF	STACK_9
$014A	$3080			MOVLW	128
$014B	$00C8			MOVWF	STACK_8
$014C	$01CD			CLRF	STACK_13
$014D	$1FC1			BTFSS	STACK_1, 7
$014E	$2955			GOTO	$+7
$014F	$09C1			COMF	STACK_1, F
$0150	$09C0			COMF	STACK_0, F
$0151	$0AC0			INCF	STACK_0, F
$0152	$1903			BTFSC	STATUS, Z
$0153	$0AC1			INCF	STACK_1, F
$0154	$0ACD			INCF	STACK_13, F
$0155	$1FC5			BTFSS	STACK_5, 7
$0156	$295D			GOTO	$+7
$0157	$09C5			COMF	STACK_5, F
$0158	$09C4			COMF	STACK_4, F
$0159	$0AC4			INCF	STACK_4, F
$015A	$1903			BTFSC	STATUS, Z
$015B	$0AC5			INCF	STACK_5, F
$015C	$0ACD			INCF	STACK_13, F
$015D	$0CC1			RRF	STACK_1, F
$015E	$0CC0			RRF	STACK_0, F
$015F	$1C03			BTFSS	STATUS, C
$0160	$296A			GOTO	$+10
$0161	$0844			MOVF	STACK_4, W
$0162	$07C9			ADDWF	STACK_9, F
$0163	$0845			MOVF	STACK_5, W
$0164	$1803			BTFSC	STATUS, C
$0165	$0F45			INCFSZ	STACK_5, W
$0166	$07CA			ADDWF	STACK_10, F
$0167	$1803			BTFSC	STATUS, C
$0168	$0ACB			INCF	STACK_11, F
$0169	$1003			BCF	STATUS, C
$016A	$1FC0			BTFSS	STACK_0, 7
$016B	$2972			GOTO	$+7
$016C	$0844			MOVF	STACK_4, W
$016D	$07CA			ADDWF	STACK_10, F
$016E	$1803			BTFSC	STATUS, C
$016F	$0ACB			INCF	STACK_11, F
$0170	$0845			MOVF	STACK_5, W
$0171	$07CB			ADDWF	STACK_11, F
$0172	$0CCB			RRF	STACK_11, F
$0173	$0CCA			RRF	STACK_10, F
$0174	$0CC9			RRF	STACK_9, F
$0175	$0CC8			RRF	STACK_8, F
$0176	$1C03			BTFSS	STATUS, C
$0177	$295D			GOTO	$-26
$0178	$1C4D			BTFSS	STACK_13, 0
$0179	$2985			GOTO	$+12
$017A	$09CB			COMF	STACK_11, F
$017B	$09CA			COMF	STACK_10, F
$017C	$09C9			COMF	STACK_9, F
$017D	$09C8			COMF	STACK_8, F
$017E	$0AC8			INCF	STACK_8, F
$017F	$1903			BTFSC	STATUS, Z
$0180	$0AC9			INCF	STACK_9, F
$0181	$1903			BTFSC	STATUS, Z
$0182	$0ACA			INCF	STACK_10, F
$0183	$1903			BTFSC	STATUS, Z
$0184	$0ACB			INCF	STACK_11, F
$0185	$084B			MOVF	STACK_11, W
$0186	$00C3			MOVWF	STACK_3
$0187	$084A			MOVF	STACK_10, W
$0188	$00C2			MOVWF	STACK_2
$0189	$0849			MOVF	STACK_9, W
$018A	$00C1			MOVWF	STACK_1
$018B	$0848			MOVF	STACK_8, W
$018C	$00C0			MOVWF	STACK_0
$018D	$0000			NOP
$018E	$0008			RETURN
$0004	$	_interrupt:
$0004	$00CF			MOVWF	STACK_15
$0005	$0E03			SWAPF	STATUS, 0
$0006	$0183			CLRF	STATUS
$0007	$00A0			MOVWF	?saveSTATUS
$0008	$0804			MOVF	FSR, 0
$0009	$009F			MOVWF	?saveFSR
$000A	$080A			MOVF	PCLATH, 0
$000B	$00A1			MOVWF	?savePCLATH
$000C	$018A			CLRF	PCLATH
$000D	$084B			MOVF	STACK_11, 0
$000E	$00AC			MOVWF	STSAVED_11
$000F	$084A			MOVF	STACK_10, 0
$0010	$00AB			MOVWF	STSAVED_10
$0011	$0841			MOVF	STACK_1, 0
$0012	$00AA			MOVWF	STSAVED_1
$0013	$0840			MOVF	STACK_0, 0
$0014	$00A9			MOVWF	STSAVED_0
;D_82_16F84A_SD1602_v_4_1.c,27 :: 		void interrupt(void)
;D_82_16F84A_SD1602_v_4_1.c,29 :: 		INTCON         &= 0x7F;
$0015	$307F			MOVLW	127
$0016	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,30 :: 		INTCON         &= 0xEF;
$0017	$30EF			MOVLW	239
$0018	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,31 :: 		INTCON         &= 0xFD;
$0019	$30FD			MOVLW	253
$001A	$058B			ANDWF	INTCON, 1
;D_82_16F84A_SD1602_v_4_1.c,33 :: 		Delay_ms(20);
$001B	$3082			MOVLW	130
$001C	$00CB			MOVWF	STACK_11
$001D	$30FF			MOVLW	255
$001E	$00CA			MOVWF	STACK_10
$001F	$0BCB			DECFSZ	STACK_11, F
$0020	$2822			GOTO	$+2
$0021	$2825			GOTO	$+4
$0022	$0BCA			DECFSZ	STACK_10, F
$0023	$2822			GOTO	$-1
$0024	$281F			GOTO	$-5
$0025	$3087			MOVLW	135
$0026	$00CA			MOVWF	STACK_10
$0027	$0BCA			DECFSZ	STACK_10, F
$0028	$2827			GOTO	$-1
$0029	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,35 :: 		if((PORTB & 0x01) == 0)
$002A	$3001			MOVLW	1
$002B	$0506			ANDWF	PORTB, 0
$002C	$00C2			MOVWF	STACK_2
$002D	$0842			MOVF	STACK_2, 0
$002E	$3A00			XORLW	0
$002F	$1D03			BTFSS	STATUS, Z
$0030	$2862			GOTO	L_interrupt_8
;D_82_16F84A_SD1602_v_4_1.c,37 :: 		if (flag == 1)
$0031	$3000			MOVLW	0
$0032	$0610			XORWF	_flag+1, 0
$0033	$1D03			BTFSS	STATUS, Z
$0034	$2837			GOTO	L_interrupt_13
$0035	$3001			MOVLW	1
$0036	$060F			XORWF	_flag, 0
$0037	$	L_interrupt_13:
$0037	$1D03			BTFSS	STATUS, Z
$0038	$284E			GOTO	L_interrupt_9
;D_82_16F84A_SD1602_v_4_1.c,41 :: 		strConstCpy2(s, s1);
$0039	$3011			MOVLW	_s
$003A	$00A2			MOVWF	FARG_strConstCpy2+0
$003B	$303E			MOVLW	#_s1
$003C	$00A3			MOVWF	FARG_strConstCpy2+1
$003D	$3002			MOVLW	@#_s1
$003E	$00A4			MOVWF	FARG_strConstCpy2+2
$003F	$218F			CALL	_strConstCpy2
;D_82_16F84A_SD1602_v_4_1.c,43 :: 		flag *= -1;
$0040	$080F			MOVF	_flag, 0
$0041	$00C0			MOVWF	STACK_0
$0042	$0810			MOVF	_flag+1, 0
$0043	$00C1			MOVWF	STACK_0+1
$0044	$30FF			MOVLW	255
$0045	$00C4			MOVWF	STACK_4
$0046	$30FF			MOVLW	255
$0047	$00C5			MOVWF	STACK_4+1
$0048	$2145			CALL	_mul_16x16_s
$0049	$0840			MOVF	STACK_0, 0
$004A	$008F			MOVWF	_flag
$004B	$0841			MOVF	STACK_0+1, 0
$004C	$0090			MOVWF	_flag+1
;D_82_16F84A_SD1602_v_4_1.c,45 :: 		} else {
$004D	$2862			GOTO	L_interrupt_10
$004E	$	L_interrupt_9:
;D_82_16F84A_SD1602_v_4_1.c,48 :: 		strConstCpy2(s, s2);
$004E	$3011			MOVLW	_s
$004F	$00A2			MOVWF	FARG_strConstCpy2+0
$0050	$3064			MOVLW	#_s2
$0051	$00A3			MOVWF	FARG_strConstCpy2+1
$0052	$3002			MOVLW	@#_s2
$0053	$00A4			MOVWF	FARG_strConstCpy2+2
$0054	$218F			CALL	_strConstCpy2
;D_82_16F84A_SD1602_v_4_1.c,50 :: 		flag *= -1;
$0055	$080F			MOVF	_flag, 0
$0056	$00C0			MOVWF	STACK_0
$0057	$0810			MOVF	_flag+1, 0
$0058	$00C1			MOVWF	STACK_0+1
$0059	$30FF			MOVLW	255
$005A	$00C4			MOVWF	STACK_4
$005B	$30FF			MOVLW	255
$005C	$00C5			MOVWF	STACK_4+1
$005D	$2145			CALL	_mul_16x16_s
$005E	$0840			MOVF	STACK_0, 0
$005F	$008F			MOVWF	_flag
$0060	$0841			MOVF	STACK_0+1, 0
$0061	$0090			MOVWF	_flag+1
;D_82_16F84A_SD1602_v_4_1.c,52 :: 		}
$0062	$	L_interrupt_10:
;D_82_16F84A_SD1602_v_4_1.c,63 :: 		}
$0062	$	L_interrupt_8:
;D_82_16F84A_SD1602_v_4_1.c,65 :: 		INTCON         |= 0x10;
$0062	$160B			BSF	INTCON, 4
;D_82_16F84A_SD1602_v_4_1.c,66 :: 		INTCON         |= 0x80;
$0063	$178B			BSF	INTCON, 7
;D_82_16F84A_SD1602_v_4_1.c,68 :: 		}//void interrupt(void)
$0064	$	L_Interrupt_end:
$0064	$082C			MOVF	STSAVED_11, 0
$0065	$00CB			MOVWF	STACK_11
$0066	$082B			MOVF	STSAVED_10, 0
$0067	$00CA			MOVWF	STACK_10
$0068	$082A			MOVF	STSAVED_1, 0
$0069	$00C1			MOVWF	STACK_1
$006A	$0829			MOVF	STSAVED_0, 0
$006B	$00C0			MOVWF	STACK_0
$006C	$0821			MOVF	?savePCLATH, 0
$006D	$008A			MOVWF	PCLATH
$006E	$081F			MOVF	?saveFSR, 0
$006F	$0084			MOVWF	FSR
$0070	$0E20			SWAPF	?saveSTATUS, 0
$0071	$0083			MOVWF	STATUS
$0072	$0ECF			SWAPF	STACK_15, 1
$0073	$0E4F			SWAPF	STACK_15, 0
$0074	$0009			RETFIE
$01D7	$	_SD1602_write:
;sd1602_4bit_mode.h,1 :: 		void SD1602_write(char c, char r)
;sd1602_4bit_mode.h,3 :: 		PORTB = c & 0xF0; /* RB4〜RB7にデータの上位4bitをセットする */
$01D7	$30F0			MOVLW	240
$01D8	$1303			BCF	STATUS, RP1
$01D9	$1283			BCF	STATUS, RP0
$01DA	$0527			ANDWF	FARG_SD1602_write+0, 0
$01DB	$0086			MOVWF	PORTB
;sd1602_4bit_mode.h,5 :: 		if (r == 1) /* 文字コードの場合 */
$01DC	$0828			MOVF	FARG_SD1602_write+1, 0
$01DD	$3A01			XORLW	1
$01DE	$1D03			BTFSS	STATUS, Z
$01DF	$29E2			GOTO	L_SD1602_write_0
;sd1602_4bit_mode.h,7 :: 		PORTA |= 0x02; /* RSを1にする */
$01E0	$1485			BSF	PORTA, 1
;sd1602_4bit_mode.h,8 :: 		}
$01E1	$29E4			GOTO	L_SD1602_write_1
$01E2	$	L_SD1602_write_0:
;sd1602_4bit_mode.h,11 :: 		PORTA &= 0xFD; /* RSを0にする */
$01E2	$30FD			MOVLW	253
$01E3	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,12 :: 		}
$01E4	$	L_SD1602_write_1:
;sd1602_4bit_mode.h,14 :: 		PORTA &= 0xFE; /* Eを0にする */
$01E4	$30FE			MOVLW	254
$01E5	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,15 :: 		Delay_us(1); /* 1us（40ns以上）の時間待ち */
$01E6	$3001			MOVLW	1
$01E7	$00CA			MOVWF	STACK_10
$01E8	$0BCA			DECFSZ	STACK_10, F
$01E9	$29E8			GOTO	$-1
$01EA	$0000			NOP
;sd1602_4bit_mode.h,16 :: 		PORTA |= 0x01; /* Eを1にする */
$01EB	$1405			BSF	PORTA, 0
;sd1602_4bit_mode.h,17 :: 		Delay_us(1);  /* 1us（230ns以上）の時間待ち */
$01EC	$3001			MOVLW	1
$01ED	$00CA			MOVWF	STACK_10
$01EE	$0BCA			DECFSZ	STACK_10, F
$01EF	$29EE			GOTO	$-1
$01F0	$0000			NOP
;sd1602_4bit_mode.h,18 :: 		PORTA &= 0xFE; /* Eを0にする */
$01F1	$30FE			MOVLW	254
$01F2	$0585			ANDWF	PORTA, 1
;sd1602_4bit_mode.h,19 :: 		}
$01F3	$0008			RETURN
$0227	$	_SD1602_control:
;sd1602_4bit_mode.h,28 :: 		void SD1602_control(char c)
;sd1602_4bit_mode.h,30 :: 		SD1602_write(c, 0); /* 制御コードの上位4bitを渡す */
$0227	$1303			BCF	STATUS, RP1
$0228	$1283			BCF	STATUS, RP0
$0229	$0826			MOVF	FARG_SD1602_control+0, 0
$022A	$00A7			MOVWF	FARG_SD1602_write+0
$022B	$01A8			CLRF	FARG_SD1602_write+1, 1
$022C	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,31 :: 		SD1602_write(c << 4, 0); /* 制御コードの下位4bitを渡す */
$022D	$0826			MOVF	FARG_SD1602_control+0, 0
$022E	$00A7			MOVWF	FARG_SD1602_write+0
$022F	$0DA7			RLF	FARG_SD1602_write+0, 1
$0230	$1027			BCF	FARG_SD1602_write+0, 0
$0231	$0DA7			RLF	FARG_SD1602_write+0, 1
$0232	$1027			BCF	FARG_SD1602_write+0, 0
$0233	$0DA7			RLF	FARG_SD1602_write+0, 1
$0234	$1027			BCF	FARG_SD1602_write+0, 0
$0235	$0DA7			RLF	FARG_SD1602_write+0, 1
$0236	$1027			BCF	FARG_SD1602_write+0, 0
$0237	$01A8			CLRF	FARG_SD1602_write+1, 1
$0238	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,32 :: 		Delay_us(50); /* 50us（40us以上）の時間待ち */
$0239	$3053			MOVLW	83
$023A	$00CA			MOVWF	STACK_10
$023B	$0BCA			DECFSZ	STACK_10, F
$023C	$2A3B			GOTO	$-1
;sd1602_4bit_mode.h,33 :: 		}
$023D	$0008			RETURN
$020E	$	_SD1602_display:
;sd1602_4bit_mode.h,21 :: 		void SD1602_display(char c)
;sd1602_4bit_mode.h,23 :: 		SD1602_write(c, 1); /* 文字コードの上位4bitを渡す */
$020E	$1303			BCF	STATUS, RP1
$020F	$1283			BCF	STATUS, RP0
$0210	$0826			MOVF	FARG_SD1602_display+0, 0
$0211	$00A7			MOVWF	FARG_SD1602_write+0
$0212	$3001			MOVLW	1
$0213	$00A8			MOVWF	FARG_SD1602_write+1
$0214	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,24 :: 		SD1602_write(c << 4, 1); /* 文字コードの下位4bitを渡す */
$0215	$0826			MOVF	FARG_SD1602_display+0, 0
$0216	$00A7			MOVWF	FARG_SD1602_write+0
$0217	$0DA7			RLF	FARG_SD1602_write+0, 1
$0218	$1027			BCF	FARG_SD1602_write+0, 0
$0219	$0DA7			RLF	FARG_SD1602_write+0, 1
$021A	$1027			BCF	FARG_SD1602_write+0, 0
$021B	$0DA7			RLF	FARG_SD1602_write+0, 1
$021C	$1027			BCF	FARG_SD1602_write+0, 0
$021D	$0DA7			RLF	FARG_SD1602_write+0, 1
$021E	$1027			BCF	FARG_SD1602_write+0, 0
$021F	$3001			MOVLW	1
$0220	$00A8			MOVWF	FARG_SD1602_write+1
$0221	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,25 :: 		Delay_us(50); /* 50us（40us以上）の時間待ち */
$0222	$3053			MOVLW	83
$0223	$00CA			MOVWF	STACK_10
$0224	$0BCA			DECFSZ	STACK_10, F
$0225	$2A24			GOTO	$-1
;sd1602_4bit_mode.h,26 :: 		}
$0226	$0008			RETURN
$0075	$	_SD1602_init:
;sd1602_4bit_mode.h,42 :: 		void SD1602_init(void)
;sd1602_4bit_mode.h,44 :: 		Delay_ms(20); /* 20ms（15ms以上）の時間待ち */
$0075	$3082			MOVLW	130
$0076	$1303			BCF	STATUS, RP1
$0077	$1283			BCF	STATUS, RP0
$0078	$00CB			MOVWF	STACK_11
$0079	$30FF			MOVLW	255
$007A	$00CA			MOVWF	STACK_10
$007B	$0BCB			DECFSZ	STACK_11, F
$007C	$287E			GOTO	$+2
$007D	$2881			GOTO	$+4
$007E	$0BCA			DECFSZ	STACK_10, F
$007F	$287E			GOTO	$-1
$0080	$287B			GOTO	$-5
$0081	$3087			MOVLW	135
$0082	$00CA			MOVWF	STACK_10
$0083	$0BCA			DECFSZ	STACK_10, F
$0084	$2883			GOTO	$-1
$0085	$0000			NOP
;sd1602_4bit_mode.h,45 :: 		SD1602_write(0x30, 0); /* 8bitモード設定 */
$0086	$3030			MOVLW	48
$0087	$00A7			MOVWF	FARG_SD1602_write+0
$0088	$01A8			CLRF	FARG_SD1602_write+1, 1
$0089	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,46 :: 		Delay_ms(5); /* 5ms（4.1ms以上）の時間待ち */
$008A	$3021			MOVLW	33
$008B	$00CB			MOVWF	STACK_11
$008C	$30FF			MOVLW	255
$008D	$00CA			MOVWF	STACK_10
$008E	$0BCB			DECFSZ	STACK_11, F
$008F	$2891			GOTO	$+2
$0090	$2894			GOTO	$+4
$0091	$0BCA			DECFSZ	STACK_10, F
$0092	$2891			GOTO	$-1
$0093	$288E			GOTO	$-5
$0094	$3060			MOVLW	96
$0095	$00CA			MOVWF	STACK_10
$0096	$0BCA			DECFSZ	STACK_10, F
$0097	$2896			GOTO	$-1
$0098	$0000			NOP
$0099	$0000			NOP
;sd1602_4bit_mode.h,47 :: 		SD1602_write(0x30, 0); /* 8bitモード設定 */
$009A	$3030			MOVLW	48
$009B	$00A7			MOVWF	FARG_SD1602_write+0
$009C	$01A8			CLRF	FARG_SD1602_write+1, 1
$009D	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,48 :: 		Delay_ms(5); /* 5ms（100us以上）の時間待ち */
$009E	$3021			MOVLW	33
$009F	$00CB			MOVWF	STACK_11
$00A0	$30FF			MOVLW	255
$00A1	$00CA			MOVWF	STACK_10
$00A2	$0BCB			DECFSZ	STACK_11, F
$00A3	$28A5			GOTO	$+2
$00A4	$28A8			GOTO	$+4
$00A5	$0BCA			DECFSZ	STACK_10, F
$00A6	$28A5			GOTO	$-1
$00A7	$28A2			GOTO	$-5
$00A8	$3060			MOVLW	96
$00A9	$00CA			MOVWF	STACK_10
$00AA	$0BCA			DECFSZ	STACK_10, F
$00AB	$28AA			GOTO	$-1
$00AC	$0000			NOP
$00AD	$0000			NOP
;sd1602_4bit_mode.h,49 :: 		SD1602_write(0x30, 0); /* 8bitモード設定 */
$00AE	$3030			MOVLW	48
$00AF	$00A7			MOVWF	FARG_SD1602_write+0
$00B0	$01A8			CLRF	FARG_SD1602_write+1, 1
$00B1	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,50 :: 		Delay_ms(5); /* 5ms（4.1ms以上）の時間待ち */
$00B2	$3021			MOVLW	33
$00B3	$00CB			MOVWF	STACK_11
$00B4	$30FF			MOVLW	255
$00B5	$00CA			MOVWF	STACK_10
$00B6	$0BCB			DECFSZ	STACK_11, F
$00B7	$28B9			GOTO	$+2
$00B8	$28BC			GOTO	$+4
$00B9	$0BCA			DECFSZ	STACK_10, F
$00BA	$28B9			GOTO	$-1
$00BB	$28B6			GOTO	$-5
$00BC	$3060			MOVLW	96
$00BD	$00CA			MOVWF	STACK_10
$00BE	$0BCA			DECFSZ	STACK_10, F
$00BF	$28BE			GOTO	$-1
$00C0	$0000			NOP
$00C1	$0000			NOP
;sd1602_4bit_mode.h,51 :: 		SD1602_write(0x20, 0); /* 4bitモード設定 */
$00C2	$3020			MOVLW	32
$00C3	$00A7			MOVWF	FARG_SD1602_write+0
$00C4	$01A8			CLRF	FARG_SD1602_write+1, 1
$00C5	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,52 :: 		Delay_ms(5); /* 5ms（40us以上）の時間待ち */
$00C6	$3021			MOVLW	33
$00C7	$00CB			MOVWF	STACK_11
$00C8	$30FF			MOVLW	255
$00C9	$00CA			MOVWF	STACK_10
$00CA	$0BCB			DECFSZ	STACK_11, F
$00CB	$28CD			GOTO	$+2
$00CC	$28D0			GOTO	$+4
$00CD	$0BCA			DECFSZ	STACK_10, F
$00CE	$28CD			GOTO	$-1
$00CF	$28CA			GOTO	$-5
$00D0	$3060			MOVLW	96
$00D1	$00CA			MOVWF	STACK_10
$00D2	$0BCA			DECFSZ	STACK_10, F
$00D3	$28D2			GOTO	$-1
$00D4	$0000			NOP
$00D5	$0000			NOP
;sd1602_4bit_mode.h,53 :: 		SD1602_control(0x28); /* 4bitモードで2行表示に設定する */
$00D6	$3028			MOVLW	40
$00D7	$00A6			MOVWF	FARG_SD1602_control+0
$00D8	$2227			CALL	_SD1602_control
;sd1602_4bit_mode.h,54 :: 		SD1602_control(0x08); /* テキスト表示をオフにする */
$00D9	$3008			MOVLW	8
$00DA	$00A6			MOVWF	FARG_SD1602_control+0
$00DB	$2227			CALL	_SD1602_control
;sd1602_4bit_mode.h,55 :: 		SD1602_control(0x0C); /* テキスト表示をオンにする */
$00DC	$300C			MOVLW	12
$00DD	$00A6			MOVWF	FARG_SD1602_control+0
$00DE	$2227			CALL	_SD1602_control
;sd1602_4bit_mode.h,56 :: 		SD1602_control(0x06); /* カーソル移動を右方向に設定する */
$00DF	$3006			MOVLW	6
$00E0	$00A6			MOVWF	FARG_SD1602_control+0
$00E1	$2227			CALL	_SD1602_control
;sd1602_4bit_mode.h,57 :: 		}
$00E2	$0008			RETURN
$01F4	$	_SD1602_clear:
;sd1602_4bit_mode.h,35 :: 		void SD1602_clear(void)
;sd1602_4bit_mode.h,37 :: 		SD1602_write(0x01, 0); /* 制御コードの上位4bitを渡す */
$01F4	$3001			MOVLW	1
$01F5	$1303			BCF	STATUS, RP1
$01F6	$1283			BCF	STATUS, RP0
$01F7	$00A7			MOVWF	FARG_SD1602_write+0
$01F8	$01A8			CLRF	FARG_SD1602_write+1, 1
$01F9	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,38 :: 		SD1602_write(0x01 << 4, 0); /* 制御コードの下位4bitを渡す */
$01FA	$3010			MOVLW	16
$01FB	$00A7			MOVWF	FARG_SD1602_write+0
$01FC	$01A8			CLRF	FARG_SD1602_write+1, 1
$01FD	$21D7			CALL	_SD1602_write
;sd1602_4bit_mode.h,39 :: 		Delay_ms(2); /* 2ms（1.64ms以上）の時間待ち */
$01FE	$300D			MOVLW	13
$01FF	$00CB			MOVWF	STACK_11
$0200	$30FF			MOVLW	255
$0201	$00CA			MOVWF	STACK_10
$0202	$0BCB			DECFSZ	STACK_11, F
$0203	$2A05			GOTO	$+2
$0204	$2A08			GOTO	$+4
$0205	$0BCA			DECFSZ	STACK_10, F
$0206	$2A05			GOTO	$-1
$0207	$2A02			GOTO	$-5
$0208	$30F3			MOVLW	243
$0209	$00CA			MOVWF	STACK_10
$020A	$0BCA			DECFSZ	STACK_10, F
$020B	$2A0A			GOTO	$-1
$020C	$0000			NOP
;sd1602_4bit_mode.h,40 :: 		}
$020D	$0008			RETURN
$0252	$	_SD1602_print:
;sd1602_4bit_mode.h,59 :: 		void SD1602_print(char *s)
;sd1602_4bit_mode.h,61 :: 		while (*s != 0x00) /* ナル文字（0x00）があらわれるまで */
$0252	$	L_SD1602_print_2:
$0252	$1303			BCF	STATUS, RP1
$0253	$1283			BCF	STATUS, RP0
$0254	$0825			MOVF	FARG_SD1602_print+0, 0
$0255	$0084			MOVWF	FSR
$0256	$0800			MOVF	INDF, 0
$0257	$00C1			MOVWF	STACK_1
$0258	$0841			MOVF	STACK_1, 0
$0259	$3A00			XORLW	0
$025A	$1903			BTFSC	STATUS, Z
$025B	$2A63			GOTO	L_SD1602_print_3
;sd1602_4bit_mode.h,63 :: 		SD1602_display(*s); /* テキストデータを表示する */
$025C	$0825			MOVF	FARG_SD1602_print+0, 0
$025D	$0084			MOVWF	FSR
$025E	$0800			MOVF	INDF, 0
$025F	$00A6			MOVWF	FARG_SD1602_display+0
$0260	$220E			CALL	_SD1602_display
;sd1602_4bit_mode.h,64 :: 		s++;
$0261	$0AA5			INCF	FARG_SD1602_print+0, 1
;sd1602_4bit_mode.h,65 :: 		}
$0262	$2A52			GOTO	L_SD1602_print_2
$0263	$	L_SD1602_print_3:
;sd1602_4bit_mode.h,66 :: 		}
$0263	$0008			RETURN
$01B5	$	GlobalIniD_82_16F84A_SD1602_v_4_1:
$01B5	$3053			MOVLW	83
$01B6	$1303			BCF	STATUS, RP1
$01B7	$1283			BCF	STATUS, RP0
$01B8	$0091			MOVWF	_s+0
$01B9	$3063			MOVLW	99
$01BA	$0092			MOVWF	_s+1
$01BB	$3068			MOVLW	104
$01BC	$0093			MOVWF	_s+2
$01BD	$306D			MOVLW	109
$01BE	$0094			MOVWF	_s+3
$01BF	$3061			MOVLW	97
$01C0	$0095			MOVWF	_s+4
$01C1	$3072			MOVLW	114
$01C2	$0096			MOVWF	_s+5
$01C3	$3067			MOVLW	103
$01C4	$0097			MOVWF	_s+6
$01C5	$3065			MOVLW	101
$01C6	$0098			MOVWF	_s+7
$01C7	$306E			MOVLW	110
$01C8	$0099			MOVWF	_s+8
$01C9	$3064			MOVLW	100
$01CA	$009A			MOVWF	_s+9
$01CB	$306F			MOVLW	111
$01CC	$009B			MOVWF	_s+10
$01CD	$3072			MOVLW	114
$01CE	$009C			MOVWF	_s+11
$01CF	$3066			MOVLW	102
$01D0	$009D			MOVWF	_s+12
$01D1	$019E			CLRF	_s+13
$01D2	$3001			MOVLW	1
$01D3	$008F			MOVWF	_flag+0
$01D4	$3000			MOVLW	0
$01D5	$0090			MOVWF	_flag+1
;D_82_16F84A_SD1602_v_4_1.c,133 :: 		}
$01D6	$0008			RETURN
$00E3	$	_main:
;D_82_16F84A_SD1602_v_4_1.c,70 :: 		void main(void)
;D_82_16F84A_SD1602_v_4_1.c,77 :: 		TRISA     = 0x00;
$00E3	$21B5			CALL	GlobalIniD_82_16F84A_SD1602_v_4_1
$00E4	$1683			BSF	STATUS, RP0
$00E5	$0185			CLRF	TRISA, 1
;D_82_16F84A_SD1602_v_4_1.c,78 :: 		PORTA     = 0x00;
$00E6	$1283			BCF	STATUS, RP0
$00E7	$0185			CLRF	PORTA, 1
;D_82_16F84A_SD1602_v_4_1.c,81 :: 		TRISB     = 0x01;
$00E8	$3001			MOVLW	1
$00E9	$1683			BSF	STATUS, RP0
$00EA	$0086			MOVWF	TRISB
;D_82_16F84A_SD1602_v_4_1.c,84 :: 		PORTB     = 0x80;  // 1000 0000
$00EB	$3080			MOVLW	128
$00EC	$1283			BCF	STATUS, RP0
$00ED	$0086			MOVWF	PORTB
;D_82_16F84A_SD1602_v_4_1.c,86 :: 		OPTION_REG &= 0x7F;
$00EE	$307F			MOVLW	127
$00EF	$1683			BSF	STATUS, RP0
$00F0	$0501			ANDWF	OPTION_REG, 0
$00F1	$00C0			MOVWF	STACK_0
$00F2	$0840			MOVF	STACK_0, 0
$00F3	$0081			MOVWF	OPTION_REG
;D_82_16F84A_SD1602_v_4_1.c,87 :: 		OPTION_REG &= 0xBF;
$00F4	$30BF			MOVLW	191
$00F5	$0540			ANDWF	STACK_0, 0
$00F6	$0081			MOVWF	OPTION_REG
;D_82_16F84A_SD1602_v_4_1.c,89 :: 		INTCON         |= 0x10;
$00F7	$160B			BSF	INTCON, 4
;D_82_16F84A_SD1602_v_4_1.c,90 :: 		INTCON         |= 0x80;
$00F8	$178B			BSF	INTCON, 7
;D_82_16F84A_SD1602_v_4_1.c,93 :: 		SD1602_init();
$00F9	$2075			CALL	_SD1602_init
;D_82_16F84A_SD1602_v_4_1.c,95 :: 		SD1602_clear();
$00FA	$21F4			CALL	_SD1602_clear
;D_82_16F84A_SD1602_v_4_1.c,101 :: 		while(1)
$00FB	$	L_main_11:
;D_82_16F84A_SD1602_v_4_1.c,107 :: 		SD1602_control(0x80);
$00FB	$3080			MOVLW	128
$00FC	$00A6			MOVWF	FARG_SD1602_control+0
$00FD	$2227			CALL	_SD1602_control
;D_82_16F84A_SD1602_v_4_1.c,108 :: 		SD1602_print(s);
$00FE	$3011			MOVLW	_s
$00FF	$00A5			MOVWF	FARG_SD1602_print+0
$0100	$2252			CALL	_SD1602_print
;D_82_16F84A_SD1602_v_4_1.c,110 :: 		Delay_ms(1000);
$0101	$301A			MOVLW	26
$0102	$00CC			MOVWF	STACK_12
$0103	$30FF			MOVLW	255
$0104	$00CB			MOVWF	STACK_11
$0105	$30FF			MOVLW	255
$0106	$00CA			MOVWF	STACK_10
$0107	$0BCC			DECFSZ	STACK_12, F
$0108	$290A			GOTO	$+2
$0109	$2911			GOTO	$+8
$010A	$0BCB			DECFSZ	STACK_11, F
$010B	$290D			GOTO	$+2
$010C	$2910			GOTO	$+4
$010D	$0BCA			DECFSZ	STACK_10, F
$010E	$290D			GOTO	$-1
$010F	$290A			GOTO	$-5
$0110	$2907			GOTO	$-9
$0111	$307F			MOVLW	127
$0112	$00CB			MOVWF	STACK_11
$0113	$30FF			MOVLW	255
$0114	$00CA			MOVWF	STACK_10
$0115	$0BCB			DECFSZ	STACK_11, F
$0116	$2918			GOTO	$+2
$0117	$291B			GOTO	$+4
$0118	$0BCA			DECFSZ	STACK_10, F
$0119	$2918			GOTO	$-1
$011A	$2915			GOTO	$-5
$011B	$3058			MOVLW	88
$011C	$00CA			MOVWF	STACK_10
$011D	$0BCA			DECFSZ	STACK_10, F
$011E	$291D			GOTO	$-1
$011F	$0000			NOP
$0120	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,112 :: 		SD1602_clear();
$0121	$21F4			CALL	_SD1602_clear
;D_82_16F84A_SD1602_v_4_1.c,114 :: 		Delay_ms(500);
$0122	$300D			MOVLW	13
$0123	$00CC			MOVWF	STACK_12
$0124	$30FF			MOVLW	255
$0125	$00CB			MOVWF	STACK_11
$0126	$30FF			MOVLW	255
$0127	$00CA			MOVWF	STACK_10
$0128	$0BCC			DECFSZ	STACK_12, F
$0129	$292B			GOTO	$+2
$012A	$2932			GOTO	$+8
$012B	$0BCB			DECFSZ	STACK_11, F
$012C	$292E			GOTO	$+2
$012D	$2931			GOTO	$+4
$012E	$0BCA			DECFSZ	STACK_10, F
$012F	$292E			GOTO	$-1
$0130	$292B			GOTO	$-5
$0131	$2928			GOTO	$-9
$0132	$30BF			MOVLW	191
$0133	$00CB			MOVWF	STACK_11
$0134	$30FF			MOVLW	255
$0135	$00CA			MOVWF	STACK_10
$0136	$0BCB			DECFSZ	STACK_11, F
$0137	$2939			GOTO	$+2
$0138	$293C			GOTO	$+4
$0139	$0BCA			DECFSZ	STACK_10, F
$013A	$2939			GOTO	$-1
$013B	$2936			GOTO	$-5
$013C	$302B			MOVLW	43
$013D	$00CA			MOVWF	STACK_10
$013E	$0BCA			DECFSZ	STACK_10, F
$013F	$293E			GOTO	$-1
$0140	$0000			NOP
$0141	$0000			NOP
$0142	$0000			NOP
;D_82_16F84A_SD1602_v_4_1.c,131 :: 		}//while(1)
$0143	$28FB			GOTO	L_main_11
;D_82_16F84A_SD1602_v_4_1.c,133 :: 		}
$0144	$2944			GOTO	$
