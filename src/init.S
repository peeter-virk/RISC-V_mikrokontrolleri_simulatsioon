.extern _DEFAULT_ISR
.extern _VJKA_ISR
.extern _TIMER0_OCR0_MATCH_ISR
.extern _TIMER0_OCR1_MATCH_ISR
.extern _TIMER0_OVERFLOW_ISR
.extern _RESET

.section .text
.global _start
.global _RESET



# ISR vector table
_start:
    .org 0
    j _RESET
    .org 0x4
    j _VJKA_ISR
    .org 0x8
    j _DEFAULT_ISR
    .org 0xc
    j _DEFAULT_ISR
    .org 0x10
    j _DEFAULT_ISR
    .org 0x14
    j _DEFAULT_ISR
    .org 0x18
    j _DEFAULT_ISR
    .org 0x1c
    j _DEFAULT_ISR
    .org 0x20
    j _DEFAULT_ISR
    .org 0x24
    j _DEFAULT_ISR

# timer 0 interrupts
    .org 0x28
    j _TIMER0_OCR0_MATCH_ISR
    .org 0x2c
    j _TIMER0_OCR1_MATCH_ISR
    .org 0x30
    j _TIMER0_OVERFLOW_ISR

_RESET:
    la sp, _stack_top
    j main
