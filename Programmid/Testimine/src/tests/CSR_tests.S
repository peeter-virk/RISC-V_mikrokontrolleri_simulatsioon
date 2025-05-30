        .section .text
    .globl test_csr_registers
    test_csr_registers:
        # Common registers:
        # a0: pointer to result buffer
        # t1: CSR address
        # t2: original value
        # t3: written value
        # t4: final value

        # Test001: mstatus (0x300) – partially writable
        li t1, 0x300
        csrr t2, mstatus
        li t3, 0xFFFFFFFF
        csrw mstatus, t3
        csrr t4, mstatus
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        csrw mstatus, t2
        addi a0, a0, 16

        # Test002: misa (0x301) – read-only
        li t1, 0x301
        csrr t2, misa
        li t3, 0xA5A5A5A5
        # csrw misa, t3      # skipped: read-only
        mv t4, t2            # final = original
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test003: mie (0x304) – read/write
        li t1, 0x304
        csrr t2, mie
        li t3, 0xAAAAAAAA
        csrw mie, t3
        csrr t4, mie
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        csrw mie, t2
        addi a0, a0, 16

# Test004: mtvec (0x305) – read/write
        li   t1, 0x305          
        csrr t2, mtvec          
        li   t3, 0x00001000    
        csrw mtvec, t3          
        csrr t4, mtvec          
        sw   t1, 0(a0)          
        sw   t2, 4(a0)  
        sw   t3, 8(a0)  
        sw   t4, 12(a0)     
        csrw mtvec, t2    
        addi a0, a0, 16    

        # Test005: mepc (0x341) – read/write
        li t1, 0x341
        csrr t2, mepc
        li t3, 0x00002000
        csrw mepc, t3
        csrr t4, mepc
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        csrw mepc, t2
        addi a0, a0, 16


        # Test006: mcause (0x342) – read/write
        li t1, 0x342
        csrr t2, mcause
        li t3, 0x0000000B
        csrw mcause, t3
        csrr t4, mcause
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        csrw mcause, t2
        addi a0, a0, 16

        # Test007: mip (0x344) – read-only
        li t1, 0x344
        csrr t2, mip
        li t3, 0x00000001
        # csrw mip, t3        # skipped
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test008: mcycle (0xB00) – read-only in RV32I
        li t1, 0xB00
        csrr t2, mcycle
        li t3, 0x12345678
        # csrw mcycle, t3     # skipped
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test009: mscratch (0x340) – read/write
        li t1, 0x340
        csrr t2, mscratch
        li t3, 0xCAFEBABE
        csrw mscratch, t3
        csrr t4, mscratch
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        csrw mscratch, t2    
        addi a0, a0, 16

        # Test010: mvendorid (0xF11) – read-only
        li t1, 0xF11
        csrr t2, mvendorid
        li t3, 0xFFFFFFFF
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test011: marchid (0xF12) – read-only
        li t1, 0xF12
        csrr t2, marchid
        li t3, 0xFFFFFFFF
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test012: mimpid (0xF13) – read-only
        li t1, 0xF13
        csrr t2, mimpid
        li t3, 0xFFFFFFFF
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        # Test013: mhartid (0xF14) – read-only
        li t1, 0xF14
        csrr t2, mhartid
        li t3, 0xFFFFFFFF
        mv t4, t2
        sw t1, 0(a0)
        sw t2, 4(a0)
        sw t3, 8(a0)
        sw t4, 12(a0)
        addi a0, a0, 16

        ret
