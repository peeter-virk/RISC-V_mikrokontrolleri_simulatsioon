.section .text
.global _start

/*
t0 = array address
t1 = array size
t2 = position
t3 = loop top
t4, t5 = active comparisons

*/

_start:
    # Initialize stack pointer to the last address of memory
    la sp, _stack_top          # Set stack pointer to last address
    
    # Define array and its size
    la t0, array            # Load address of array into t0
    li t1, 5                # Array size = 5

    mv t2, t0

    mv t3, t0
    mv t4, t1

loop:

    # End of program
end:
    j end                   # Loop indefinitely

# Data section (for array and stack)
.section .data
array:
    .word 30, 10, 50, 20, 40  # Example array to sort
