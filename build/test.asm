;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.12 #12697 (MINGW32)
;--------------------------------------------------------
	.module test
	.optsdcc -mpdk13
	

; default segment ordering in RAM for linker
	.area DATA
	.area OSEG (OVR,DATA)

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl __misc
	.globl __gpcs
	.globl __gpcc
	.globl __bgtr
	.globl __tm2b
	.globl __tm2s
	.globl __tm2ct
	.globl __tm2c
	.globl __t16c
	.globl __t16m
	.globl __paph
	.globl __pac
	.globl __pa
	.globl __padier
	.globl __integs
	.globl __intrq
	.globl __inten
	.globl __eoscr
	.globl __ilrcr
	.globl __ihrcr
	.globl __clkmd
	.globl __sp
	.globl __flag
	.globl _cnt
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG (ABS)
	.org 0x0000
__flag	=	0x0000
__sp	=	0x0002
__clkmd	=	0x0003
__ihrcr	=	0x000b
__ilrcr	=	0x001f
__eoscr	=	0x000a
__inten	=	0x0004
__intrq	=	0x0005
__integs	=	0x000c
__padier	=	0x000d
__pa	=	0x0010
__pac	=	0x0011
__paph	=	0x0012
__t16m	=	0x0006
__t16c::
	.ds 2
__tm2c	=	0x001c
__tm2ct	=	0x001d
__tm2s	=	0x0017
__tm2b	=	0x0009
__bgtr	=	0x0019
__gpcc	=	0x001a
__gpcs	=	0x001e
__misc	=	0x001b
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_cnt::
	.ds 2
;--------------------------------------------------------
; overlayable items in ram 
;--------------------------------------------------------
	.area	OSEG (OVR,DATA)
_main_sloc0_1_0:
	.ds 2
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	.area	HEADER (ABS)
	.org	 0x0020
	reti
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
	.area	PREG (ABS)
	.org 0x00
p::
	.ds 2
	.area	HEADER (ABS)
	.org 0x0000
	nop
	clear	p+1
	mov	a, #s_OSEG
	add	a, #l_OSEG + 1
	and	a, #0xfe
	mov.io	sp, a
	call	__sdcc_external_startup
	goto	s_GSINIT
	.area GSINIT
__sdcc_init_data:
	mov	a, #s_DATA
	mov	p, a
	goto	00002$
00001$:
	mov	a, #0x00
	idxm	p, a
	inc	p
	mov	a, #s_DATA
00002$:
	add	a, #l_DATA
	ceqsn	a, p
	goto	00001$
	.area GSFINAL
	goto	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	goto	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	../tb/test.c: 14: void main() {
; genLabel
;	-----------------------------------------
;	 function main
;	-----------------------------------------
;	Register assignment is optimal.
_main:
; genLabel
00120$:
;	../tb/test.c: 16: if get(PA,0) {
; genAnd
; peephole ( t0sn PA0 check )
; peephole ( untwist conditional jumps t0sn -> t1sn )
	t1sn	__pa,#0
	goto	00102$
; peephole ( jmp +1 )
00160$:
; skipping generated iCode
;	../tb/test.c: 17: set0(PA,0);
; genAnd
	set0.io	__pa, #0
; genGoto
	goto	00104$
; genLabel
00102$:
;	../tb/test.c: 20: set1(PA,0);
; genOr
	set1.io	__pa, #0
;	../tb/test.c: 22: while ( get(PA,1) ) {}
; genLabel
00104$:
; genAnd
; peephole ( t0sn PA1 check )
	t0sn	__pa, #1
	goto	00104$
; skipping generated iCode
;	../tb/test.c: 23: while ( get(PA,2) ) cnt++;
; genLabel
00107$:
; genAnd
; peephole ( t0sn PA2 check )
; peephole ( untwist conditional jumps t0sn -> t1sn )
	t1sn	__pa,#2
	goto	00110$
; peephole ( jmp +1 )
00161$:
; skipping generated iCode
; genPlus
	inc	_cnt+0
	addc	_cnt+1
; genGoto
	goto	00107$
;	../tb/test.c: 24: do 
; genLabel
00110$:
;	../tb/test.c: 25: cnt++;
; genPlus
	inc	_cnt+0
	addc	_cnt+1
;	../tb/test.c: 26: while ( get(PA,3) );
; genAnd
; peephole ( t0sn PA3 check )
	t0sn	__pa, #3
	goto	00110$
; skipping generated iCode
;	../tb/test.c: 27: do 
; genLabel
00113$:
;	../tb/test.c: 28: cnt++;
; genPlus
	inc	_cnt+0
	addc	_cnt+1
;	../tb/test.c: 29: while ( !get(PA,3) );
; genAnd
; peephole ( t0sn PA3 check )
; peephole ( untwist conditional jumps t0sn -> t1sn )
	t1sn	__pa,#3
	goto	00113$
; peephole ( jmp +1 )
00162$:
; skipping generated iCode
;	../tb/test.c: 30: set(PA,4, (cnt>th) );
; genAssign
; genCmp
; peephole ( const sub16 )
	call	_th+0
	sub		a, _cnt+0
	call	_th+1
	subc	a, _cnt+1
	t1sn.io	f, c
	goto	00117$
; skipping generated iCode
; genOr
	set1.io	__pa, #4
; genGoto
	goto	00120$
; genLabel
00117$:
; genAnd
	set0.io	__pa, #4
; genGoto
	goto	00120$
; genLabel
; peephole j0 removed unused label 00122$.
;	../tb/test.c: 32: }
; genEndFunction
	ret
	.area CODE
	.area CONST
_th:
	ret #0x34
	ret #0x12	; 4660
	.area CABS (ABS)
