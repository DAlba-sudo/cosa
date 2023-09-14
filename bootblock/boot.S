.code16
.globl start
start:
	// set the registers to zero
	xorw %ax, %ax

// sets the padding for the magic MBR
.space 510-(.-start)
.word 0xaa55
