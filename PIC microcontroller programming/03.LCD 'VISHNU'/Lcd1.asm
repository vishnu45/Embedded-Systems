#INCLUDE P16F877A.INC
LIST P=16F877A
;-------------------------------------------------------------------------------------------------------------------------------
BSF STATUS,RP0
CLRF TRISB
CLRF TRISC
BCF STATUS,RP0
;-------------------------------------------------------------------------------------------------------------------------------
CLRF PORTB
CLRF PORTC

START:
MOVLW 0X40
MOVWF PORTB
MOVLW 0X0F
MOVWF PORTC
CALL ENABLE
;-----------------------DISPLAY 'VISHNU'-----------

BSF PORTB,4
MOVLW 0X56				;-----'V'-----
MOVWF PORTC
CALL ENABLE

BSF PORTB,4
MOVLW 0X49				;-----'I'-----
MOVWF PORTC
CALL ENABLE

BSF PORTB,4
MOVLW 0X53				;-----'S'-----
MOVWF PORTC
CALL ENABLE

BSF PORTB,4
MOVLW 0X48				;-----'H'-----
MOVWF PORTC
CALL ENABLE

BSF PORTB,4
MOVLW 0X4E				;-----'N'-----
MOVWF PORTC
CALL ENABLE

BSF PORTB,4
MOVLW 0X55				;-----'U'-----
MOVWF PORTC
CALL ENABLE

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
D2	MOVLW 0X21
	MOVWF 0X60
D1	DECFSZ 0X60,1
	GOTO D1
	DECFSZ 0X61,1
	GOTO D2
	RETURN
;-------------------------------------------------------------------------------------------------------------------------------
END