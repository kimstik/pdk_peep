ARCH   = pdk13
DEVICE = PMS150C

PEEPFILE=$(ARCH)_peep.def
CC=sdcc
CFLAGS = -m$(ARCH) -D$(DEVICE) --opt-code-size --fverbose-asm
CFLAGS+= -I. -I../bsp/include
CFLAGS+= --peep-asm --peep-return --peep-file ../$(PEEPFILE)

OBJDIR=build

#pip install pyexpander intelhex
expander=$(PYSCRIPTS)expander.py

PHONY:info

info:$(OBJDIR)/test.ihx
	py $(PYSCRIPTS)hexinfo.py $<

$(OBJDIR)/test.ihx:tb/test.c $(PEEPFILE)
	@if not exist "$(OBJDIR)" mkdir $(OBJDIR)
	cd build && $(CC) $(CFLAGS) ../$<

$(PEEPFILE):$(PEEPFILE).pe
	$(expander) -f $< > $@
