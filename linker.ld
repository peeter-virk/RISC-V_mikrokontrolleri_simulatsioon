ENTRY(_start)

MEMORY
{
    FLASH (x) : ORIGIN = 0x0000, LENGTH = 64K  /* Flash memory for code and constants */
    RAM   (rw) : ORIGIN = 0x4000, LENGTH = 16K /* RAM for data, stack, and variables */
}

SECTIONS
{
    . = 0x0;
    .init :
    {
        *(.init)
    }
    .text :
    {       
        *(.text)            
        *(.rodata)               
    } > FLASH 
    
    .data :
    {
        _sdata = .;         
        *(.data)            
        *(.rodata*)        
        _edata = .;
    } > RAM
    .bss :
    {
        _sbss = .;
        *(.bss)
        _ebss = .; 
    } > RAM

    /* Stack pointer */
    .stack (NOLOAD) :
    {
        _stack_top = ORIGIN(RAM) + LENGTH(RAM) - 4;
    } > RAM

    /* End of memory */
    PROVIDE(_end = _ebss);
}
