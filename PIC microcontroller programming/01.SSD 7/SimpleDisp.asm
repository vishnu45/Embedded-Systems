#INCLUDE P16F877A.inc
LIST P=16F877A
;***********************************************************************************************************************************************************
BSF STATUS,RP0
;BSF OPTION_REG,7		;ENABLING PORTB PULLUPS
MOVLW 0X00
MOVWF TRISC
MOVLW 0X0F
MOVWF TRISB
BCF STATUS,RP0

;INITIALISING**********************************************
INITIALISING:
MOVLW 0X00
MOVWF PORTC
;***********************************************************************************************************************************************************


;START*****************************************************
START:

;LOOP1*****************************************************
LOOP1:
CALL DELAY
CLRF PORTB
BSF PORTB,4
BTFSC PORTB,3
GOTO OUT1
BTFSC PORTB,2
GOTO OUT2
BTFSC PORTB,1
GOTO OUT3
GOTO LOOP2

OUT1:
MOVLW 0X01
MOVWF PORTC
GOTO START
OUT2:
MOVLW 0X02
MOVWF PORTC
GOTO START
OUT3:
MOVLW 0X03
MOVWF PORTC
GOTO START

;LOOP2*****************************************************
LOOP2:
CALL DELAY
CLRF PORTB
BSF PORTB,5
BTFSC PORTB,3
GOTO OUT4
BTFSC PORTB,2
GOTO OUT5
BTFSC PORTB,1
GOTO OUT6
GOTO LOOP3

OUT4:
MOVLW 0X04
MOVWF PORTC
GOTO START
OUT5:
MOVLW 0X05
MOVWF PORTC
GOTO START
OUT6:
MOVLW 0X06
MOVWF PORTC
GOTO START

;LOOP3*****************************************************
LOOP3:
CALL DELAY
CLRF PORTB
BSF PORTB,6
BTFSC PORTB,3
GOTO OUT7
BTFSC PORTB,2
GOTO OUT8
BTFSC PORTB,1
GOTO OUT9
GOTO LOOP4

OUT7:
MOVLW 0X07
MOVWF PORTC
GOTO START
OUT8:
MOVLW 0X08
MOVWF PORTC
GOTO START
OUT9:
MOVLW 0X09
MOVWF PORTC
GOTO START

;LOOP4*****************************************************
LOOP4:
CALL DELAY
CLRF PORTB
BSF PORTB,7
BTFSC PORTB,3
GOTO OUTA
BTFSC PORTB,2
GOTO OUTB
BTFSC PORTB,1
GOTO OUTC
GOTO LOOP1

OUTA:
MOVLW 0X0A
MOVWF PORTC
GOTO START
OUTB:
MOVLW 0X00
MOVWF PORTC
GOTO START
OUTC:
MOVLW 0X0C
MOVWF PORTC
GOTO START


;***********************************************************************************************************************************************************
DELAY:
MOVLW 0X60
MOVWF 0X61
D2	MOVLW 0X60
	MOVWF 0X60
D1	DECFSZ 0X60,1
	GOTO D1
	DECFSZ 0X61,1
	GOTO D2
	RETURN
;----------------------------------------------
END