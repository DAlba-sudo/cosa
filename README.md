<div style="text-align: center;">
    <img src="documentation/images/cosa-banner-light.png">
</div>

## What is cOSA?

cOSA is a hobby OS that I am making as I work through a course taught here at Georgia Tech's College of Computing! It designed as a really basic x86 operating system.

## Features

I am adding features as I have time and I learn more! Right now I am working on <em>[the bootloader](https://github.com/DAlba-sudo/cosa/blob/main/bootblock/boot.S)</em>. 

```asm
The bootloader
```

### Supported Boot Methods:

- [x] Legacy BIOS w/ Master Boot Record
- [ ] UEFI
- [ ] GRUB

### In-Progress Misc. Boot Features:
 
- [ ] Sets up initial GDT, LDT.
- [ ] Transition to 32bit Protected Mode
- [ ] Enter second-stage bootloader 

<br>

```
The Kernel
```
Ahhh the kernel! Believe it or not, I am actually not as interested in the kernel just yet. Don't get me wrong, I'm looking forward to that part - but something about the bootloader just calls to me. I'll fill this out once I get to the kernel part!!

> Thanks for reading!
> - Diego Alba
