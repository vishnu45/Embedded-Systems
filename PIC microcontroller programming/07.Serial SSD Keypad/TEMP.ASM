#include <p16f877a.inc>
list p=16f877a
ORG 0X00
GOTO START
org 0x20
;ohm gam ganapataye namah
;**************************************************************************************
START:
BSF STATUS,RP0
MOVLW 0XF0
MOVWF TRISB
MOVWF TRISD
MOVWF TRISA
BCF OPTION_REG,7  	;PORTB PULLUPS ENABLED
MOVLW 0X06
MOVWF ADCON1
BCF STATUS,RP0
MOVLW 0X00
MOVWF 0X50
MOVWF PORTA
MOVWF PORTD

;**************************************************************************************

get_it
		;old_key=0x40
		;new_key=0x41
		;count=0x42
		;data_count=0X50
MOVLW 0X00        
MOVWF 0X40      ;old_key=0
MOVWF 0X41      ;new_key=0

;**************************************************************************************

get_it_subloop
MOVLW 0X00
MOVWF 0X42      ;count=0

;**************************************************************************************

get_it_subloop2
CALL scan_it
MOVF 0X22,0
MOVWF 0X41      ;MOVING KEY_VALUE TO NEW_KEY
SUBWF 0X40,0     ;W<--OLD_KEY-NEW_KEY
BTFSS STATUS,2
GOTO assign_new_to_old
INCF 0X42,1
call delay
BTFSS STATUS,2
GOTO get_it_subloop2
GOTO after_scan_it

;**************************************************************************************

assign_new_to_old
MOVF 0X41,0
MOVWF 0X40
GOTO get_it_subloop

;**************************************************************************************

;starting of scan_it
scan_it
MOVLW 0X01 
MOVWF 0X20       ;0X20 IS THE KEY_COUNT VARIABLE
MOVLW 0XF7
MOVWF 0X21       ;0X21 IS THE PATTERN TO BE GIVEN TO PORTB
    sub_loop
	MOVF 0X21,0
	MOVWF PORTB  ;OUTPUT 'PATTERN' TO PORTB
	MOVF 0X20,0 ;W=KEY_COUNT
	BTFSS PORTB,7
	GOTO scan_it_finish
    ADDLW 0X03
	BTFSS PORTB,6
    	GOTO scan_it_finish
    ADDLW 0X03
	BTFSS PORTB,5
	GOTO scan_it_finish
    ADDLW 0X03
	BTFSS PORTB,4
	GOTO scan_it_finish
    MOVLW 0XFF          ;THESE STEPS
    MOVWF 0X30     
    INCF 0X30,1         ;USED TO SET CARRY FOR THE RIGHT SHIFT
    MOVLW 0XFF          ;MOVING A MARKER TO W TO SHOW NO KEY PRESSED ON THE COLUMN
	INCF 0X20,1         ;INCREMENT KEY_COUNT
    RRF 0X21,1          ;SHIFT PATTERN RIGHT
    BTFSC 0X21,0        ;CHECKING IF PATTERN(0) IS CLEAR
    GOTO sub_loop       ;CHECK NXT COLUMN IF PATTERN(0) IS STILL 1
scan_it_finish
MOVWF 0X22   ;0X22 WILL HAVE THE KEYVALUE,FF-->NO READ ; 
RETURN
;finishing of scan_it

;***************************************************************************************

after_scan_it
MOVF 0X40,0 ;W<--OLD_KEY
MOVWF 0X30
INCF 0X30,1 ;CHECKING IF THE CONTINUOUSLY OCCURED VALUE WAS FF(ie. no READ)
BTFSC STATUS,2
GOTO get_it
INCF 0X50,1 ;INCREMENTING DATA COUNT
CALL output_setter
GOTO get_it

;***************************************************************************************

delay
MOVLW 0X09
MOVWF 0X61
D2
MOVLW 0X21
MOVWF 0X60
D1
DECFSZ 0X60,1
GOTO D1
DECFSZ 0X61,1
GOTO D2
RETURN

;***************************************************************************************

output_setter
MOVF 0X50,0
MOVWF 0X30
DECF 0X30
BTFSC STATUS,2
GOTO condition_1



;****************************************************************************************

condition_1
MOVF 0X40,0
MOVWF PORTD

CALL USARTX

;PORTC LAST NIBBLE FOR FIRST SSD
BSF PORTA,3;PORTA3--->FIRST SSD ENABLE
RETURN



USARTX:

BSF STATUS,RP0

MOVLW 0XFF
MOVWF SPBRG

MOVLW 0X24
MOVWF TXSTA

BCF STATUS,RP0

BSF RCSTA,SPEN

MOVF 0X40,0
MOVWF TXREG

RETURN



end

;************************************************************************************************

;CALL_IT AND SCAN_IT ARE AS USUAL...
;THERE'S A DATA COUNT VARIABLE 0X50 WHICH COUNTS 1,2,3,4,1,2,3,4..
;WHENEVER VALID DATA(IE. DATA NOT EQUAL TO FF IS RECEIVED)
;COUNT=1---> FOR THE FIRST TIME
;OUTPUT SETTER WILL PUT THE DATA TO LOWER NIBBLE OF PORTC
;SINCE COUNT=1 FOR THE FIRST TIME, THE HIGHER NIBBLE WILL REMAIN 
;AS 0(ALREADY CONFIGURED IN THE BEGINNING OF PROGRAM
;NOW PORTA3 BIT IS SET
;THIS IS BECAUSE I AM USING THAT TO ENABLE SSD1
;SO DATA FROM LOWER NIBBLE OF PORTC TOGETHER WITH PORTA3 CAN
;CONTROL SSD-1 THROUGH 7447 IC-1

;COUNT=2--->FOR THE FIRST TIME
;NIBBLES OF PORTC ARE SWAPPED, IE. 0 WILL BECOME THE LOWER NIBBLE NOW
;NOW SIMPLY ADD ,NEWLY GOT DATA VALUE
;SWAP AGAIN
;PORTA2 BIT IS SET
;SO HIGHER NIBBLE OF PORTC AND PORTA2 CAN CTRL SSD-2
;THROUGH 7447 IC-2

;SIMILARLY FOR COUNT-3,4 FOR THE FIRST TIME
;IN COUNT-4, THE COUNT IS CLEARED IN THE OUTPUT_SETTER
;FOR MAKING THE DISPLAY FOLLOW A CYCLIC PATTERN
;AFTER COUNTE-4,COUNT-1 WILL APPEAR FOR THE SECOND TIME FOR THE NEXT
;VALID DATA
;NOW THE NIBBLES ARE ALREADY LOADED
;SO THE LOWER NIBBLE IS CAREFULLY CLEARED AND THE NEW DATA IS INSERTED
;AND SO ON.......













    
    
      
    
    
	
	
	



