.section .text
.global main
main:
    # Define the base address of the timer in a register
    li t0, 0x1014           # Load timer base address into t0

    # Set OCR0 to 10
    li t1, 10               # Load value 10 into t1
    sw t1, 0x08(t0)         # Store 10 into OCR0 (base address + 0x08)

    # Configure the control register
    li t1, 0x20000041       # Bitfield:
                            # - Enable timer (bit 0 = 1)
                            # - Clock source = MCU clock (bits 3-4 = 00)
                            # - Reset on OCR match (bit 6 = 1)
                            # - Exception on OCR0 match (bit 29 = 1)
    sw t1, 0x00(t0)         # Store the control register configuration

    # Infinite loop to keep program running
loop:
    j loop
