ARCH   = pdk13
DEVICE = PMS150C

F_CPU = 1000000
TARGET_VDD_MV = 4000
TARGET_VDD = 4.0

PEEPFILE=$(ARCH)_peep.def
CC=sdcc
CFLAGS = -m$(ARCH) -D$(DEVICE) --opt-code-size --fverbose-asm
CFLAGS+= -DF_CPU=$(F_CPU) -DTARGET_VDD_MV=$(TARGET_VDD_MV)
CFLAGS+= -I. -I../bsp/include
CFLAGS+= --peep-asm --peep-return 
CFLAGS+= --peep-file ../$(PEEPFILE)

OBJDIR=build

#pip install pyexpander intelhex
PYSCRIPTS=$(PYTHONPATH)/Scripts/
expander=$(PYSCRIPTS)expander.py

SRC=bsp/BlinkLED/main.c 
SRC=bsp/FadeLED/main.c 
SRC=bsp/BlinkLED_WithIRQ/main.c 
SRC=bsp/FadeLED/main.c 
SRC=bsp/ReadButton_WriteLED/main.c 
SRC=bsp/ReadButton_WriteSerial/main.c 
SRC=bsp/Serial_HelloWorld/main.c 
SRC=tb/test.c

HEX=$(OBJDIR)/$(notdir $(basename $(SRC))).ihx
PHONY:info

info:$(HEX)
	py $(PYSCRIPTS)hexinfo.py $<

$(HEX):$(SRC) $(PEEPFILE) makefile
	@if not exist "$(OBJDIR)" mkdir $(OBJDIR)
	cd build && $(CC) $(CFLAGS) ../$<

$(PEEPFILE):$(PEEPFILE).pe
	$(expander) -f $< > $@
