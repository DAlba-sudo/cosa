#!/bin/sh

GDBFLAGS=""
dummy=""

while getopts "g" flag; do
    case $flag in
        g) # handle the gdb debugger activation command
            GDBFLAGS="-S -s" 
            echo "Starting $GDBFLAGS"
            ;;
    esac
done

qemu-system-i386 -nographic -drive file=build/cosa.img,index=0,media=disk,format=raw -smp 1 -m 512 $gdbflags
