MEMORY
{
    ram : ORIGIN = 0x4000, LENGTH = 0x1000 /* Define your data memory region */
    program_memory : ORIGIN = 0x0, LENGTH = 0x10000 /* Define your program memory region */
}

SECTIONS
{
    . = 0x4000;
    .text :
    {
        *(.text)    /* Place the .text section here */
    } > program_memory       /* Place the .text section in the 'program_memory' memory region */

    .data :
    {
        *(.data)    /* Place the .data section here */
    } > ram       /* Place the .data section in the 'ram' memory region */
}
