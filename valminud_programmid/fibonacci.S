main:
    li      a1, 0           # Lae F(0) registrisse a1
    li      a2, 1           # Lae F(1) registrisse a2
    li      t0, 0x4000      # Lae mälu aadress 0x4000 registrisse t0

loop:
    sw      a1, 0(t0)       # Salvesta F(n-1) mälu aadressile registris t0
    add     t0, t0, 4       # Liiguta mälu aadress registris t0 järgmisele aadressile
    add     a3, a1, a2      # Arvuta F(n) = F(n-1) + F(n-2)
    add     a1, zero, a2    # Liiguta F(n-1) asukohale F(n-2)
    add     a2, zero, a3    # Liiguta F(n) asukohale F(n-1)
    jal     loop            # Hüppa loop-i aadressile




