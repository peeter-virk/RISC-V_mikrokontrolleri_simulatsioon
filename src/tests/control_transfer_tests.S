.section .text
.globl test_control_transfer
test_control_transfer:
    # a0 - address to store results

    # TEST001: ECALL → expecting mcause = 11 (ECALL from M-mode)
    li t0, 1
    la t1, test001_done
    csrw mepc, t1
    ecall
test001_done:
    la t3, 0x2000            # ← Fix: Load address into a register
    lw t2, 0(t3)             # ← Valid load
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST002: EBREAK → expecting mcause = 3
    li t0, 1
    la t1, test002_done
    csrw mepc, t1
    ebreak
test002_done:
    la t3, 0x2000
    lw t2, 0(t3)
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST003: MRET → write known flag at return location
    li t2, 0xA3
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST004: JAL → jump to procedure
    jal ra, jump_target
after_jal:
    sw t2, 0(a0)     # t2 set in jump_target
    addi a0, a0, 4

    # TEST005: BEQ taken
    li t3, 0x11
    li t4, 0x11
    beq t3, t4, branch_taken
branch_fail1:
    li t2, 0xBAD
    j after_branch_taken
branch_taken:
    li t2, 0x55
after_branch_taken:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST006: BNE not taken
    li t3, 0x22
    li t4, 0x22
    bne t3, t4, branch_fail2
    li t2, 0x66
    j after_branch_not_taken
branch_fail2:
    li t2, 0xBAD
after_branch_not_taken:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST007: BLT taken
    li t3, -5
    li t4, 3
    blt t3, t4, blt_taken
blt_fail:
    li t2, 0xBAD
    j after_blt
blt_taken:
    li t2, 0x71
after_blt:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST008: BLT not taken
    li t3, 10
    li t4, 5
    blt t3, t4, blt_fail2
    li t2, 0x72
    j after_blt2
blt_fail2:
    li t2, 0xBAD
after_blt2:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST009: BGE taken
    li t3, 7
    li t4, 3
    bge t3, t4, bge_taken
bge_fail:
    li t2, 0xBAD
    j after_bge
bge_taken:
    li t2, 0x81
after_bge:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST010: BGE not taken
    li t3, -10
    li t4, 0
    bge t3, t4, bge_fail2
    li t2, 0x82
    j after_bge2
bge_fail2:
    li t2, 0xBAD
after_bge2:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST011: BLTU taken
    li t3, 1
    li t4, 2
    bltu t3, t4, bltu_taken
bltu_fail:
    li t2, 0xBAD
    j after_bltu
bltu_taken:
    li t2, 0x91
after_bltu:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST012: BLTU not taken
    li t3, 0xFFFFFFFE
    li t4, 1
    bltu t3, t4, bltu_fail2
    li t2, 0x92
    j after_bltu2
bltu_fail2:
    li t2, 0xBAD
after_bltu2:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST013: BGEU taken
    li t3, 0xFFFFFFFF
    li t4, 0xFFFFFFFE
    bgeu t3, t4, bgeu_taken
bgeu_fail:
    li t2, 0xBAD
    j after_bgeu
bgeu_taken:
    li t2, 0xA1
after_bgeu:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST014: BGEU not taken
    li t3, 0
    li t4, 1
    bgeu t3, t4, bgeu_fail2
    li t2, 0xA2
    j after_bgeu2
bgeu_fail2:
    li t2, 0xBAD
after_bgeu2:
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST015: Timer interrupt → trap & mret return
    li t0, 0x1234
    la t1, _ISR
    csrw mtvec, t1

    li t2, 0x0
    li t4, 0x1
    csrw 0x100, t2       # Timer control
    csrw 0x104, t2       # Timer counter
    csrw 0x108, t2       # CR0 = 0 → interrupt
    csrw 0x108, t4       # CR0 = 1 to avoid looping

    csrr t5, mie
    ori t5, t5, 0x2
    csrw mie, t5

    csrr t6, mstatus
    ori t6, t6, 0x8
    csrw mstatus, t6

    sw t0, 0(a0)
    addi a0, a0, 4

    li t2, 0x0           
    csrw 0x100, t2       # Clear timer control
    li t3, ~0x2
    and t5, t5, t3
    csrw mie, t5
    li t3, ~0x8
    and t6, t6, t3
    csrw mstatus, t6

    ret


jump_target:
    li t2, 0x44
    j after_jal

.section .text._ISR
.global _ISR
.type _ISR, @function
_ISR:
    csrr t0, mcause
    la   t1, 0x2000
    sw   t0, 0(t1)

    la   t2, after_trap_return
    csrw mepc, t2
    mret

after_trap_return:
    ret
