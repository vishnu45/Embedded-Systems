# MPLAB IDE generated this makefile for use with GNU make.
# Project: TRANS1.mcp
# Date: Tue Dec 22 21:23:59 2009

AS = MPASMWIN.exe
CC = mcc18.exe
LD = mplink.exe
AR = mplib.exe
RM = rm

TRANS1.cof : TRANS1.o
	$(LD) /p16F877A "TRANS1.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"TRANS1.cof" /M"TRANS1.map" /W /x

TRANS1.o : TRANS1.ASM C:/Program\ Files/Microchip/MPASM\ Suite/P16F877A.INC
	$(AS) /q /p16F877A "TRANS1.ASM" /l"TRANS1.lst" /e"TRANS1.err" /d__DEBUG=1

clean : 
	$(RM) "TRANS1.o" "TRANS1.hex" "TRANS1.err" "TRANS1.lst" "TRANS1.cof"

