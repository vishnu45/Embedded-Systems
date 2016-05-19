#INCLUDE P16F877A.inc
LIST P=16F877A
;***********************************************************************************************************************************************************
BSF STATUS,RP0
CLRF TRISB
CLRF TRISC
MOVLW 0X0F
MOVWF TRISD
BCF STATUS,RP0

;INITIALISING**********************************************
INITIALISING:
CLRF PORTB
CLRF PORTC
;***********************************************************************************************************************************************************


;START*****************************************************
START:
MOVLW 0X40
MOVWF PORTB
MOVLW 0X0F
MOVWF PORTC
CALL ENABLE

;LOOP1*****************************************************
LOOP1:
CLRF PORTD
BSF PORTD,4
BTFSC PORTD,3
GOTO OUT1
BTFSC PORTD,2
GOTO OUT2
BTFSC PORTD,1
GOTO OUT3
GOTO LOOP2

OUT1:
BSF PORTB,4
MOVLW 0X31				;-----'1'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT2:
BSF PORTB,4
MOVLW 0X32				;-----'2'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT3:
BSF PORTB,4
MOVLW 0X33				;-----'3'-----
MOVWF PORTC
CALL ENABLE
GOTO START

;LOOP2*****************************************************
LOOP2:
CLRF PORTD
BSF PORTD,5
BTFSC PORTD,3
GOTO OUT4
BTFSC PORTD,2
GOTO OUT5
BTFSC PORTD,1
GOTO OUT6
GOTO LOOP3

OUT4:
BSF PORTB,4
MOVLW 0X34				;-----'4'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT5:
BSF PORTB,4
MOVLW 0X35				;-----'5'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT6:
BSF PORTB,4
MOVLW 0X36				;-----'6'-----
MOVWF PORTC
CALL ENABLE
GOTO START

;LOOP3*****************************************************
LOOP3:
CLRF PORTD
BSF PORTD,6
BTFSC PORTD,3
GOTO OUT7
BTFSC PORTD,2
GOTO OUT8
BTFSC PORTD,1
GOTO OUT9
GOTO LOOP4

OUT7:
BSF PORTB,4
MOVLW 0X37				;-----'7'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT8:
BSF PORTB,4
MOVLW 0X38				;-----'8'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUT9:
BSF PORTB,4
MOVLW 0X39				;-----'9'-----
MOVWF PORTC
CALL ENABLE
GOTO START

;LOOP4*****************************************************
LOOP4:
CLRF PORTD
BSF PORTD,7
BTFSC PORTD,3
GOTO OUTA
BTFSC PORTD,2
GOTO OUTB
BTFSC PORTD,1
GOTO OUTC
GOTO LOOP1

OUTA:
BSF PORTB,4
MOVLW 0X41				;-----'A'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUTB:
BSF PORTB,4
MOVLW 0X30				;-----'0'-----
MOVWF PORTC
CALL ENABLE
GOTO START
OUTC:
BSF PORTB,4
MOVLW 0X43				;-----'C'-----
MOVWF PORTC
CALL ENABLE
GOTO START


;***********************************************************************************************************************************************************

ENABLE:
CALL DELAY
BCF PORTB,6
CALL DELAY
BSF PORTB,6
RETURN

;-------------------------------------------------------------------------------------------------------------------------------
DELAY:
MOVLW 0X7F
MOVWF 0X61
D2	MOVLW 0X7F
	MOVWF 0X60
D1	DECFSZ 0X60,1
	GOTO D1
	DECFSZ 0X61,1
	GOTO D2
	RETURN
;-------------------------------------------------------------------------------------------------------------------------------
END