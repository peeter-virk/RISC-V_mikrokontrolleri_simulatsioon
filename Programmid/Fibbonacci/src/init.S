.extern _ISR
.extern _RESET


.global _start
.global _RESET




# ISR vector table
.section .init
_start:
    .org 0
    j _RESET
    .org 0x4
    j _ISR

.section .text
_RESET:
    la sp, _stack_top
    csrs mstatus, zero
    call main
    call _end

_end:
    csrs mstatus, zero
    j _stopped

_stopped:
    j _stopped
