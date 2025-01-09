.section .text
.global _start

_start:
    .org 0
    j _setup


_setup:
    # setup stack
    la sp, _stack_top
    j main