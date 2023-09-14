.code16
.globl start
start:
	cli
	
	// set the registers to zero
	xorw %ax, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %ss

	// set the x at the video buffer
	mov $0xb800, %ax
	mov %ax, %es

	movw $0x44, %es:0x0
	
	loop:
		jmp loop
	hlt

.space 510-(.-start)
.word 0xaa55
