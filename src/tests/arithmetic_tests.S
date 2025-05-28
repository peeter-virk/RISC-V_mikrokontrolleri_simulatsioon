    .section .text
.globl test_arithmetic_instructions
test_arithmetic_instructions:
    # a0 is the first argument: address to store the result

    # start of RV32I R type commands

    # TEST001: ADD 3 + 5       EXPECTING: 0x8
    li t0, 0x00000005
    li t1, 0x00000003
    add t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST002: ADD 0xFFFFFFFF + 0xFFFFFFFF  EXPECTING: 0xFFFFFFFE
    li t0, 0xFFFFFFFF
    li t1, 0xFFFFFFFF
    add t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST003: ADD 0 + 0       EXPECTING: 0x0
    li t0, 0x00000000
    li t1, 0x00000000
    add t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST004: SUB 5 - 3       EXPECTING: 0x2
    li t0, 0x00000005
    li t1, 0x00000003
    sub t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST005: SUB 0xFFFFFFFF - 0xFFFFFFFF  EXPECTING: 0x0
    li t0, 0xFFFFFFFF
    li t1, 0xFFFFFFFF
    sub t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST006: SUB 1 - 2       EXPECTING: 0xFFFFFFFF
    li t0, 0x00000001
    li t1, 0x00000002
    sub t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST007: AND 0xF0F0F0F0, 0xFF00FF00  EXPECTING: 0xF000F000
    li t0, 0xF0F0F0F0
    li t1, 0xFF00FF00
    and t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST008: AND 0xDEADBEEF, 0xDADADADA  EXPECTING: 0xD8ADADAA
    li t0, 0xDEADBEEF
    li t1, 0xDADADADA
    and t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST009: OR 0xF0F0F0F0, 0xFF00FF00  EXPECTING: 0xFFF0FFF0
    li t0, 0xF0F0F0F0
    li t1, 0xFF00FF00
    or t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST010: OR 0xDEADBEEF, 0xDADADADA  EXPECTING: 0xDEADFFEF
    li t0, 0xDEADBEEF
    li t1, 0xDADADADA
    or t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST011: XOR 0xF0F0F0F0, 0xFF00FF00  EXPECTING: 0x0FF00FF0
    li t0, 0xF0F0F0F0
    li t1, 0xFF00FF00
    xor t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST012: XOR 0xDEADBEEF, 0xDADADADA  EXPECTING: 0x75D7D7BD
    li t0, 0xDEADBEEF
    li t1, 0xDADADADA
    xor t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST013: XOR 0xDEADBEEF, 0xDEADBEEF  EXPECTING: 0x0
    li t0, 0xDEADBEEF
    li t1, 0xDEADBEEF
    xor t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST014: SSL 0x000FF000, 1     EXPECTING: 0x001FE000
    li t0, 0x000FF000
    li t1, 0x00000001
    sll t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST015: SLL 0x00000001, 31     EXPECTING: 0x80000000
    li t0, 0x00000001
    li t1, 0x0000001F
    sll t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST016: SRL 0x80000000, 31     EXPECTING: 0x00000001
    li t0, 0x80000000
    li t1, 0x0000001F
    srl t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST017: SRL 0x000FF000, 1      EXPECTING: 0x0007F800
    li t0, 0x000FF000
    li t1, 0x00000001
    srl t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST018: SRA 0xFFFFFFFF, 4       EXPECTING: 0xFFFFFFFF
    li t0, 0xFFFFFFFF
    li t1, 0x4
    sra t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST019: SRA 0x80000000, 31      EXPECTING: 0xFFFFFFFF
    li t0, 0x80000000
    li t1, 0x1F
    sra t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST020: SLT 5 < 10              EXPECTING: 0x1
    li t0, 5
    li t1, 10
    slt t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST021: SLT 10 < 5              EXPECTING: 0x0
    li t0, 10
    li t1, 5
    slt t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST022: SLTU 0xFFFFFFFF < 0     EXPECTING: 0x0
    li t0, 0xFFFFFFFF
    li t1, 0
    sltu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST023: SLTU 0 < 0xFFFFFFFF     EXPECTING: 0x1
    li t0, 0
    li t1, 0xFFFFFFFF
    sltu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # start of RV32I I type commands

    # TEST024: ADDI 0x5 + 0x7           EXPECTING: 0xC
    li t0, 0x5
    addi t2, t0, 0x7
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST025: SLTI 5 < 10              EXPECTING: 0x1
    li t0, 5
    slti t2, t0, 10
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST026: SLTIU 0 < 200            EXPECTING: 0x1
    li t0, 0
    sltiu t2, t0, 200
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST027: XOR 0xAAAA5555 ^ 0xFFFF0000    EXPECTING: 0x55555555
    li t0, 0xAAAA5555
    li t1, 0xFFFF0000
    xor t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST028: OR 0x00000001 | 0x0000FF00  EXPECTING: 0x0000FF01
    li t0, 0x1
    li t1, 0xFF00
    or t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST029: ANDI 0x12345678 & 0x00FF      EXPECTING: 0x78
    li t0, 0x12345678
    andi t2, t0, 0xFF
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST030: SLLI 0x1 << 10          EXPECTING: 0x400
    li t0, 0x1
    slli t2, t0, 10
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST031: SRLI 0x80000000 >> 31   EXPECTING: 0x1
    li t0, 0x80000000
    srli t2, t0, 31
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST032: SRAI 0xFFFFFFFF >> 1    EXPECTING: 0xFFFFFFFF
    li t0, 0xFFFFFFFF
    srai t2, t0, 1
    sw t2, 0(a0)
    addi a0, a0, 4


    # start of RV32I U type commands  

    # TEST033: LUI 0x12345             EXPECTING: 0x12345000
    lui t2, 0x12345
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST034: AUIPC + offset (0)      EXPECTING: address of instruction
    auipc t2, 0
    sw t2, 0(a0)
    addi a0, a0, 4

        # TEST035: AUIPC + offset (4096)      EXPECTING: address of instruction 4096 + 16 greater than the previous
    auipc t2, 4096
    sw t2, 0(a0)
    addi a0, a0, 4

    # --- RV32M R-TYPE COMMANDS ---

    # TEST036: MUL 5 * 5                 EXPECTING: 25
    li t0, 5
    li t1, 5
    mul t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST037: MUL 0 * 0                 EXPECTING: 0
    li t0, 0
    li t1, 0
    mul t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST038: MUL 100000 * 100000       EXPECTING: 10000000000 (lower 32 bits: 1410065408)
    li t0, 100000
    li t1, 100000
    mul t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST039: MULH 100000 * 100000      EXPECTING: upper 32 bits: 2
    li t0, 100000
    li t1, 100000
    mulh t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST040: MULHSU 100000 * -100000   EXPECTING: -3 (upper 32 bits of signed * unsigned)
    li t0, 100000
    li t1, -100000
    mulhsu t2, t1, t0      # signed * unsigned
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST041: MULHU 0xFFFFFFFF * 0xFFFFFFFF    EXPECTING: 0xFFFFFFFE
    li t0, -1              # 0xFFFFFFFF
    li t1, -1
    mulhu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST042: MULHU 0xFFFFFFFF * 0xFFFFFFFE    EXPECTING: 0xFFFFFFFD
    li t0, -1              # 0xFFFFFFFF
    li t1, -2              # 0xFFFFFFFE
    mulhu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST043: DIV 4 / 2                EXPECTING: 2
    li t0, 4
    li t1, 2
    div t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST044: DIV 4 / 0                EXPECTING: -1 (as per spec)
    li t0, 4
    li t1, 0
    div t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST045: DIV 0 / 0                EXPECTING: -1 (undefined, but spec returns -1)
    li t0, 0
    li t1, 0
    div t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST046: DIVU 4 / 2               EXPECTING: 2
    li t0, 4
    li t1, 2
    divu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST047: DIVU 4 / 0               EXPECTING: 0xFFFFFFFF
    li t0, 4
    li t1, 0
    divu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST048: REM 10 % 3              EXPECTING: 1
    li t0, 10
    li t1, 3
    rem t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST049: REM -10 % 3             EXPECTING: -1
    li t0, -10
    li t1, 3
    rem t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST050: REM 10 % -3             EXPECTING: 1
    li t0, 10
    li t1, -3
    rem t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST051: REM -10 % -3            EXPECTING: -1
    li t0, -10
    li t1, -3
    rem t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST052: REMU 10 % 3             EXPECTING: 1
    li t0, 10
    li t1, 3
    remu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST053: REMU -10 % 3            EXPECTING: 2 (since -10 becomes 0xFFFFFFF6, % 3 = 2)
    li t0, -10
    li t1, 3
    remu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST054: REMU 10 % -3            EXPECTING: 10 (since -3 is large unsigned)
    li t0, 10
    li t1, -3
    remu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4

    # TEST055: REMU -10 % -3           EXPECTING: 3 (0xFFFFFFF6 % 0xFFFFFFFD = 3)
    li t0, -10
    li t1, -3
    remu t2, t0, t1
    sw t2, 0(a0)
    addi a0, a0, 4


    ret
