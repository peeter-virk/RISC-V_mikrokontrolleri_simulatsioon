.section .text
.globl test_memory_instructions

test_memory_instructions:
    # Result buffer is pointed to by a0
    # Registers:
    # t1 = address
    # t2 = original read value
    # t3 = value to write
    # t4 = read-back value

    # TEST 001: Dataport as output
    # Set direction register to output (all bits = 1)
    li t1, 0x4  
    li t3, 0xFF     
    sw t3, 0(t1)

    # Write 0xAA to data register
    li t1, 0x0     
    li t3, 0xAA
    sw t3, 0(t1)

    # Read back the value
    lw t4, 0(t1)

    # Store to result buffer
    sw t4, 0(a0)
    addi a0, a0, 4 

    # TEST 002: Dataport as input
    # Set direction register to input (all bits = 0)
    li t1, 0x4
    li t3, 0x00
    sw t3, 0(t1)

    # Try to write to data register
    li t1, 0x0
    li t3, 0x55
    sw t3, 0(t1)

    # Read back the value (may not be 0x55)
    lw t4, 0(t1)

    # Store to result buffer
    sw t4, 0(a0)
    addi a0, a0, 4

 # TEST 003: Timer read/write test
    # Timer base address: 0x100
    # Registers:
    # 0x100 - Control
    # 0x104 - Counter
    # 0x108 - OCR0
    # 0x10C - OCR1

    # Write and read control register
    li t1, 0x100
    li t3, 0b00111001    # Enable, clkdiv=01, clksrc=10 (Dataport pin 7), upcount
    sw t3, 0(t1)
    lw t4, 0(t1)
    sw t4, 0(a0)
    addi a0, a0, 4

    # Write and read counter register
    li t1, 0x104
    li t3, 1234
    sw t3, 0(t1)
    lw t4, 0(t1)
    sw t4, 0(a0)
    addi a0, a0, 4

    # Write and read OCR0
    li t1, 0x108
    li t3, 4321
    sw t3, 0(t1)
    lw t4, 0(t1)
    sw t4, 0(a0)
    addi a0, a0, 4

    # Write and read OCR1
    li t1, 0x10C
    li t3, 9999
    sw t3, 0(t1)
    lw t4, 0(t1)
    sw t4, 0(a0)
    addi a0, a0, 4

 # TEST 004: Timer external clock via dataport pin 7
    # Set dataport to output
    li t1, 0x4
    li t3, 0xFF
    sw t3, 0(t1)

    # Set timer control: Enable | clkdiv=01 | clksrc=10 (pin 7) | upcount
    li t1, 0x100
    li t3, 0b00111001
    sw t3, 0(t1)

    # Reset timer counter to 0
    li t1, 0x104
    li t3, 0
    sw t3, 0(t1)

    # Generate 3 clock pulses on pin 7
    li t1, 0x0          # dataport data register
    li t2, 0x00         # base value

    # pulse 1: set bit 7 high
    li t3, 0x80
    sw t3, 0(t1)

    # pulse 1: set bit 7 low
    sw t2, 0(t1)

    # pulse 2
    sw t3, 0(t1)
    sw t2, 0(t1)

    # pulse 3
    sw t3, 0(t1)
    sw t2, 0(t1)

    # Read back timer counter
    li t1, 0x104
    lw t4, 0(t1)

    # Store to result buffer
    sw t4, 0(a0)
    addi a0, a0, 4

    ret
