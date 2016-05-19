#INCLUDE P16F877A.INC
LIST P=16F877A
ORG 0X00
GOTO START
ORG 0X20
START:

;----------------------------------------------------------
; INTIALISATIONS
;----------------------------------------------------------
BSF STATUS,RP0
CLRF TRISB
BCF STATUS,RP0
CLRF PORTB

;----------------------------------------------------------
; MAIN PROGRAM
;----------------------------------------------------------
LOOP1:
MOVLW 0X00
MOVWF 0X50

LOOP2:
CALL DELAY
MOVF 0X50,0
MOVWF PORTB
INCF 0X50,1
SUBLW 0X09
BTFSC STATUS,Z
GOTO LOOP1
GOTO LOOP2

;----------------------------------------------------------
; EXTRA FUNCTIONS
;----------------------------------------------------------
DELAY:
MOVLW 0X04
MOVWF 0X63
D3:
MOVLW 0XFF
MOVWF 0X62
D2:
MOVLW 0XFF
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
;----------------------------------------------------------
END