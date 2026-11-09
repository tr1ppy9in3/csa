"is_pow2_branchy":
        test    rdi, rdi
        jne     .L9
        jmp     .L5
.L4:
        test    dil, 1
        jne     .L5
        shr     rdi
.L9:
        cmp     rdi, 1
        jne     .L4
        mov     eax, 1
        ret
.L5:
        xor     eax, eax
        ret
"sat_add32_branchy":
        movsxd  rdi, edi
        movsxd  rsi, esi
        mov     eax, 2147483647
        add     rdi, rsi
        cmp     rdi, 2147483647
        jg      .L11
        cmp     rdi, -2147483648
        mov     eax, -2147483648
        cmovge  eax, edi
.L11:
        ret
