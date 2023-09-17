#
# Location/File/Dir Variables
#
DIR_BUILD=build
DIR_BOOTBLOCK=$(DIR_BUILD)/bootblock

SRC_BOOTBLOCK=./bootblock
IMG_NAME=cosa

#
# GCC Set-Up
#
CC=gcc
CCFLAGS=-std=c11 -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer

#
# LD Set-Up
#
LD=ld
LDFLAGS=-melf_i386

#
# ObjCopy Set-Up
# 
OBJCP=objcopy

all: bootblock cosa
	echo "Starting the make proces..."

cosa: bootblock
	dd if=/dev/zero of=$(DIR_BUILD)/$(IMG_NAME).img count=10000
	dd if=$(DIR_BOOTBLOCK)/bootblock of=$(DIR_BUILD)/$(IMG_NAME).img conv=notrunc seek=0

bootblock: always
		$(CC) $(CCFLAGS) -fno-pic -nostdinc -I$(SRC_BOOTBLOCK)/. -c $(SRC_BOOTBLOCK)/boot.S 
		$(LD) $(LDFLAGS) -N -e start -Ttext=0x7c00 -o $(DIR_BOOTBLOCK)/bootblock.o boot.o
		$(OBJCP) -S -O binary -j .text $(DIR_BOOTBLOCK)/bootblock.o $(DIR_BOOTBLOCK)/bootblock
		-rm $(DIR_BOOTBLOCK)/*.o
		-rm *.o *.d

#
# QEMU
#
qemu: cosa
	qemu-system-i386 -nographic -drive file=$(DIR_BUILD)/$(IMG_NAME).img,index=0,media=disk,format=raw -smp 1 -m 512 -S -s

#
# Misc File Manipulation Methods
#
always:
	-mkdir build/
	-mkdir build/bootblock

clean:
	-rm -rf build/*
	-rm *.o *.d
