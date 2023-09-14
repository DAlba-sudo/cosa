.code16
.globl start
start:
	// set the registers to zero
	xorw %ax, %ax
	movw %ax, %es
	movw %ax, %cs
	movw %ax, %ds
	movw %ax, %fs

	// we now test the a20 line
	// 1. set the segment registers for memory access
	movw $510, %di	

	// move into memory the magic value
	movw %es:(%di), %ax

	// 
// sets the padding for the magic MBR
.space 510-(.-start)
.word 0xaa55
