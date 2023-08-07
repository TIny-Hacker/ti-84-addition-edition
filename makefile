#-----------------------------------------------
#
# TI-84 Addition Edition Source Code - makefile
# By RoccoLox Programs and TIny_Hacker
# Copyright 2023
# License: GPL-3.0
# Last Built: August 4, 2023
#
#-----------------------------------------------

AVNAME = AdEdHook
PROGNAME = ADDSETUP
AVSRC = src/hook.asm
PROGSRC = src/main.asm

all:
	fasmg $(AVSRC) $(AVNAME).8xv
	fasmg $(PROGSRC) $(PROGNAME).8xp
