.section .text
.globl _start
_start:
    # Test ADD
    li x5, 10         # Laeb väärtuse 10 registrisse x5
    li x6, 5          # Laeb väärtuse 5 registrisse x6
    add x7, x5, x6    # Liitmistehe x7 = x5 + x6
    li x4, 0x4000     # Laeb mäluaadressi registrisse x4
    sw x7, 0(x4)      # Salvesta tulemuse mällu (15)

    # Test SUB
    sub x7, x5, x6    # Liitmistehe x7 = x5 - x6
    li x4, 0x4004     # Laeb mäluaadressi registrisse x4
    sw x7, 0(x4)      # Salvesta tulemuse mällu (5)

    # Test AND
    li x6, 7          # Laeb väärtuse 7 registrisse x6
    and x7, x5, x6    # Teosta loogiline korrutis (AND) x7 = x5 & x6
    li x4, 0x4008     # laeb mäluaadressi registrisse x4
    sw x7, 0(x4)      # Salvesta tulemus mällu (2)

    # Test OR
    or x7, x5, x6    # Teosta loogiline liitmistehe (OR) x7 = x5 | x6
    li x4, 0x400c     # laeb mäluaadressi registrisse x4
    sw x7, 0(x4)     # Salvesta tulemus mällu (15)

    # Test XOR
    xor x7, x5, x6    # Teosta Välistav disjunktsioon (XOR) x7 = x5 ^ x6
    li x4, 0x4010     # laeb mäluaadressi registrisse x4
    sw x7, 0(x4)     # Salvesta tulemus mällu (13)


    # Programmi lõpp
    ebreak


