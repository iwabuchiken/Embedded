;http://homepage3.nifty.com/mitt/pic/pic5_01_1.html
; PIC16F84A

;{
GPR_1   EQU     0Ch         ; GPR�̂P�o�C�g�ڂ�GPR_1�ƌ������O��t����
GPR_2   EQU     0Dh         ; GPR�̂Q�o�C�g�ڂ�GPR_2�ƌ������O��t����
GPR_3   EQU     0Eh         ; GPR�̂R�o�C�g�ڂ�GPR_3�ƌ������O��t����

    ; �����@0.5S�҂T�u���[�`���@����   
T05S
        MOVLW   05h         ; ���[�v�񐔂T��
        MOVWF   GPR_3       ;  �Z�b�g
T05LP   CALL    T100mS      ; 100mS�҂�
        DECFSZ  GPR_3,F     ; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
        GOTO    T05LP
        RETURN              ; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@100mS�҂T�u���[�`���@����   
T100mS
        MOVLW   0F9h        ; F9h=249
        MOVWF   GPR_2       ;  �i���[�v�񐔂Ƃ���249���Z�b�g�j
T100LP  CALL    T04mS       ; 0.4mS�҂�
        DECFSZ  GPR_2,F     ; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
        GOTO    T100LP      ;
        RETURN              ; ���̃T�u���[�`���ďo�����ɖ߂�


    ; �����@0.4mS�҂T�u���[�`���@����   
T04mS
        MOVLW   0F9h        ; F9h=249
        MOVWF   GPR_1       ;  �i���[�v�񐔂Ƃ���249���Z�b�g�j
T04LP   NOP                 ; ���������P�T�C�N������
        DECFSZ  GPR_1,F     ; ���[�v�񐔁|�P���ĂO�ɂȂ����玟�̖��߂��X�L�b�v
        GOTO    T04LP
        RETURN              ; ���̃T�u���[�`���ďo�����ɖ߂�

        END                 ; �v���O�����̏I�����A�Z���u���Ɏw������
        
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
	
	C02mS	; 0.2mS�J�E���^
	C5mS	; 5mS�J�E���^
	C1S	; 1S�J�E���^
	
	ENDC

; ====================================== T1S
;T1S
; �����@1S�҂T�u���[�`���@����   
T1S
	MOVLW	d'200'
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
