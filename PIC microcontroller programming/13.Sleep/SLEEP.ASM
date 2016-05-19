#INCLUDE P16F877A.INC
LIST P=16F877A

GOTO START
;----------------------------------------------------------
; INTERRUPT SERVICE ROUTINE
;----------------------------------------------------------
ORG 0X04
ISR:
BCF INTCON,GIE
BCF INTCON,RBIE
BCF INTCON,RBIF

INCF PORTD
CALL DELAY
CLRF PORTB

BSF INTCON,GIE
BSF INTCON,RBIE
RETFIE
;----------------------------------------------------------
; MAIN PROGRAM
;----------------------------------------------------------
START:
BSF STATUS,RP0
CLRF TRISD

BCF STATUS,RP0
CLRF PORTD
BSF INTCON,GIE
BSF INTCON,RBIE

LOOP:
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