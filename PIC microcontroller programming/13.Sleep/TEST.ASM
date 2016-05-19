#INCLUDE P16F877A.INC
LIST P=16F877A

GOTO START
;----------------------------------------------------------
; INTERRUPT SERVICE ROUTINE
;----------------------------------------------------------

;----------------------------------------------------------
; MAIN PROGRAM
;----------------------------------------------------------
START:
BSF STATUS,RP0
CLRF TRISD
MOVLW 0XFF
MOVWF TRISB
BCF STATUS,RP0
CLRF PORTD



MOVLW 0X0A
MOVWF PORTD

LOOP:
;BTFSS PORTB,0
GOTO LOOP

;----------------------------------------------------------
; DELAY
;----------------------------------------------------------
DELAY:
MOVLW 0X04
MOVWF 0X63
D3:
MOVLW 0X04
MOVWF 0X62
D2:
MOVLW 0X7F
MOVWF 0X61
D1:
DECFSZ 0X61,1
GOTO D1
DECFSZ 0X62,1
GOTO D2
DECFSZ 0X63,1
GOTO D2
RETURN

;----------------------------------------------------------
END