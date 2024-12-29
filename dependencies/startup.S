.section .startup
.global _start
j _start  /* Jump to _start at the beginning of the program */

.section .text
_start:
    la a0, _sidata      # Load source address of .text in Flash
    la a1, _sdata       # Load start address of .text in RAM
    la a2, _edata       # Load end address of .data in RAM

copy_code:
    beq a0, a2, init_bss  # If all of .text is copied, move to BSS section
    lw t0, 0(a0)            # Load word from Flash (program memory)
    sw t0, 0(a1)            # Store it into RAM
    addi a0, a0, 4          # Increment source address in Flash
    addi a1, a1, 4          # Increment destination address in RAM
    j copy_code

init_bss:
    la a0, _sbss         # Load start address of .bss in RAM
    la a1, _ebss         # Load end address of .bss in RAM

zero_bss:
    beq a0, a1, main     # If done zeroing, go to main
    sw zero, 0(a0)       # Write zero to .bss
    addi a0, a0, 4       # Increment address
    j zero_bss
