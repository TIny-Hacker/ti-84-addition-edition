AVNAME = AdEdHook
PROGNAME = ADDSETUP
AVSRC = src/hook.asm
PROGSRC = src/main.asm

all:
	fasmg $(AVSRC) $(AVNAME).8xv
	fasmg $(PROGSRC) $(PROGNAME).8xp
