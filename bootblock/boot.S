#include "macros.h"

.code16
.globl start
start:
	cli

	// set the registers to zero
	xorw %ax, %ax
	movw %ax, %bx
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %di
	movw %ax, %si

	// attempt to force a warp-around to check 
	// for the A20 line state.
	// make a write to the magic number location
	// which is at physical address: 510 offset from 0x7c00!	

pre_registers_a20:
	// we prepare the index and segement registers
	// for the a20 check.
	// es: 0x0000 		di: 510
	// fs: 0xFFFF			si: ???
	// sets fs to 0xffff
	not %bx
	movw %bx, %fs
	
	// sets the indices 
	movw $0x7b00, %di
	movw $0x7b16, %si
	
	jmp write_pre_a20_check

write_pre_a20_check:
	// writes to the es:di mem location the magic value
	movw $A20_MAGIC, %es:(%di)
	
	// we want to clear the cx register 
	// just to be sure.
	movw %ax, %cx	

	jmp check_a20

check_a20:
	// we begin by checking the magic value
	// which *should* be at location 0x7b00
	// when the a20 line is dead.
	movw %fs:(%si), %cx
	movw $A20_MAGIC, %bx
	cmp %bx, %cx
	jne post_a20_on

post_a20_off:
		jmp main
	
post_a20_on:
	// we are going to write to the location at
	// fs:si to prove that a20 is actually on!
	movw $A20_MAGIC_PROOF, %fs:(%si)	

main:
	jmp main	

// sets the padding for the magic MBR
.space 510-(.-start)
.word 0xaa55
