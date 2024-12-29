ENTRY(_start)  /* Define the entry point */

MEMORY
{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 64K
    RAM   (rwx): ORIGIN = 0x20000000, LENGTH = 4K
}
SECTIONS
{
    /* Place all executable code (.text) at the start of memory */
    .text :
    {
        _start = .;         /* Mark the start of code */
        *(.text)            /* Include all .text sections */
        *(.rodata)          /* Include all read-only data */
        _sidata = .;
    } > FLASH               /* Place in FLASH memory */

    /* Place all initialized data (.data) in RAM */
    .data :
    {
        _sdata = .;         /* Start of .data */
        *(.data)            /* Include all .data sections */
        _edata = .;         /* End of .data */
    } > RAM AT > FLASH      /* Copy from FLASH to RAM */

    /* Place uninitialized data (.bss) in RAM */
    .bss :
    {
        _sbss = .;          /* Start of .bss */
        *(.bss)             /* Include all .bss sections */
        _ebss = .;          /* End of .bss */
    } > RAM

    /* Define stack pointer */
    .stack (NOLOAD) :
    {
        _stack_top = ORIGIN(RAM) + LENGTH(RAM); /* Stack grows downward */
    } > RAM
}

/* Provide symbols for C startup code */
PROVIDE(_end = _ebss);
