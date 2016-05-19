#INCLUDE P16F877A.INC
LIST P=16F877A
;-------------------------------------------------------------------------------------------------------------------------------
BSF STATUS,RP0
CLRF TRISB
CLRF TRISC
BCF STATUS,RP0
;-------------------------------------------------------------------------------------------------------------------------------
BSF PORTB,7
CLRF PORTB
CLRF PORTC

START:
MOVLW 0X40
MOVWF PORTB
MOVLW 0X0F
MOVWF PORTC
CALL ENABLE
;-----------------------DISPLAY 'CURSOR'-----------

CALL DELAY1
LOOP:

GOTO LOOP


;-------------------------------------------------------------------------------------------------------------------------------
ENABLE:
CALL DELAY
BCF PORTB,6
CALL DELAY
BSF PORTB,6
RETURN

;-------------------------------------------------------------------------------------------------------------------------------
DELAY:
	MOVLW 0X09
	MOVWF 0X61
D2:	MOVLW 0X21
	MOVWF 0X60
D1:	DECFSZ 0X60,1
	GOTO D1
	DECFSZ 0X61,1
	GOTO D2
	RETURN

DELAY1:
MOVLW 0X40
MOVWF 0X63
D31:
MOVLW 0XFF
MOVWF 0X62
D21:
MOVLW 0XFF
MOVWF 0X61
D11:
DECFSZ 0X61,1
GOTO D11
DECFSZ 0X62,1
GOTO D21
DECFSZ 0X63,1
GOTO D21
RETURN
;-------------------------------------------------------------------------------------------------------------------------------
END