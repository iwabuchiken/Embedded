;http://homepage3.nifty.com/mitt/pic/pic5_01_1.html
; PIC16F84A

;{
GPR_1   EQU     0Ch         ; GPRの１バイト目にGPR_1と言う名前を付ける
GPR_2   EQU     0Dh         ; GPRの２バイト目にGPR_2と言う名前を付ける
GPR_3   EQU     0Eh         ; GPRの３バイト目にGPR_3と言う名前を付ける

    ; ＜＜　0.5S待つサブルーチン　＞＞   
T05S
        MOVLW   05h         ; ループ回数５を
        MOVWF   GPR_3       ;  セット
T05LP   CALL    T100mS      ; 100mS待つ
        DECFSZ  GPR_3,F     ; ループ回数－１して０になったら次の命令をスキップ
        GOTO    T05LP
        RETURN              ; このサブルーチン呼出し元に戻る


    ; ＜＜　100mS待つサブルーチン　＞＞   
T100mS
        MOVLW   0F9h        ; F9h=249
        MOVWF   GPR_2       ;  （ループ回数として249をセット）
T100LP  CALL    T04mS       ; 0.4mS待つ
        DECFSZ  GPR_2,F     ; ループ回数－１して０になったら次の命令をスキップ
        GOTO    T100LP      ;
        RETURN              ; このサブルーチン呼出し元に戻る


    ; ＜＜　0.4mS待つサブルーチン　＞＞   
T04mS
        MOVLW   0F9h        ; F9h=249
        MOVWF   GPR_1       ;  （ループ回数として249をセット）
T04LP   NOP                 ; 何もせず１サイクル消費
        DECFSZ  GPR_1,F     ; ループ回数－１して０になったら次の命令をスキップ
        GOTO    T04LP
        RETURN              ; このサブルーチン呼出し元に戻る

        END                 ; プログラムの終了をアセンブラに指示する
        
;============================================
;}
;

;PIC16F84A
;{
	CBLOCK	020h
	
	CNT1	
	CNT2
	CNT3

	MEM1
	
	C02mS	; 0.2mSカウンタ
	C5mS	; 5mSカウンタ
	C1S	; 1Sカウンタ
	
	ENDC

; ====================================== T1S
;T1S
; ＜＜　1S待つサブルーチン　＞＞   
T1S
	MOVLW	d'200'
	MOVWF	C1S		; ループ回数として200をセット）
T1SLP	
	CALL	T5mS		; 5mS待つ
	DECFSZ	C1S,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T1SLP		;
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　5mS待つサブルーチン　＞＞   
T5mS
	MOVLW	d'25'
	MOVWF	C5mS		; ループ回数として25をセット）
T5mLP	
	CALL	T02mS		; 0.2mS待つ
	DECFSZ	C5mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T5mLP
	RETURN			; このサブルーチン呼出し元に戻る


    ; ＜＜　0.2mS待つサブルーチン　＞＞   
T02mS
	MOVLW	d'249'
	MOVWF	C02mS		; ループ回数として249をセット
T02mLP	
	NOP			; 何もせず１サイクル消費
	DECFSZ	C02mS,F		; ループ回数－１して０になったら次の命令をスキップ
	GOTO	T02mLP
	RETURN			; このサブルーチン呼出し元に戻る
;}
;	
