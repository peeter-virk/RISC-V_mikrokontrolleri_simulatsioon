ENTRY(_start)  /* Define the entry point */

MEMORY
{
    FLASH (x) : ORIGIN = 0x0000, LENGTH = 64K  /* Flash memory for code and constants */
    RAM   (rw) : ORIGIN = 0x4000, LENGTH = 16K   /* RAM for data, stack, and variables */
}

SECTIONS
{
    /* Place all executable code (.text) at the start of memory */
    .text :
    {
        _start = .;         /* Mark the start of code */
        *(.text)            /* Include all .text sections */
        *(.rodata)          /* Include all read-only data */
        _sidata = .;        /* Mark the end of .text section (start of .data in Flash) */
    } > FLASH               /* Place code and constants in FLASH memory */

    /* Place all initialized data (.data) in RAM and copy it from FLASH */
    .data :
    {
        _sdata = .;         /* Start of .data section in RAM */
        *(.data)            /* Include all .data sections */
        *(.rodata*)
        _edata = .;         /* End of .data section in RAM */
    } > RAM      /* Copy initialized data from FLASH to RAM */

    /* Place uninitialized data (.bss) in RAM */
    .bss :
    {
        _sbss = .;          /* Start of .bss section in RAM */
        *(.bss)             /* Include all .bss sections */
        _ebss = .;          /* End of .bss section in RAM */
    } > RAM

    /* Define stack pointer */
    .stack (NOLOAD) :
    {
        _stack_top = ORIGIN(RAM) + LENGTH(RAM) - 4; /* Stack grows downward from top of RAM */
    } > RAM

    /* Define the end of memory */
    PROVIDE(_end = _ebss);
}
