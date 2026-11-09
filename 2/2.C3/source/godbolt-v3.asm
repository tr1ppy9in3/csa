"bswap32":
        mov     eax, edi
        bswap   eax
        ret
"is_pow2":
        blsr    rax, rdi
        sete    dl
        xor     eax, eax
        test    rdi, rdi
        setne   al
        and     eax, edx
        ret
"parity32":
        mov     eax, edi
        shr     eax, 16
        xor     eax, edi
        mov     edx, eax
        shr     edx, 8
        xor     edx, eax
        mov     eax, edx
        shr     eax, 4
        xor     eax, edx
        mov     edx, eax
        shr     edx, 2
        xor     edx, eax
        mov     eax, edx
        shr     eax
        xor     eax, edx
        and     eax, 1
        ret
"popcount32":
        xor     eax, eax
        popcnt  eax, edi
        ret
"ctz32":
        blsi    eax, edi
        sub     eax, 1
        popcnt  eax, eax
        ret
"clz32":
        mov     edx, edi
        shr     edx
        or      edx, edi
        mov     eax, edx
        shr     eax, 2
        or      eax, edx
        mov     edx, eax
        shr     edx, 4
        or      edx, eax
        mov     eax, edx
        shr     eax, 8
        or      eax, edx
        mov     edx, eax
        shr     edx, 16
        or      edx, eax
        mov     eax, 32
        popcnt  edx, edx
        sub     eax, edx
        ret
"next_pow2":
        cmp     rdi, 1
        adc     rdi, -1
        mov     rdx, rdi
        shr     rdx
        or      rdx, rdi
        mov     rax, rdx
        shr     rax, 2
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 4
        or      rdx, rax
        mov     rax, rdx
        shr     rax, 8
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 16
        or      rdx, rax
        mov     rax, rdx
        shr     rax, 32
        or      rax, rdx
        add     rax, 1
        ret
"sign_extend":
        sub     esi, 1
        mov     edx, 1
        shlx    rdx, rdx, rsi
        lea     rax, [rdx-1]
        or      rax, rdx
        and     rax, rdi
        xor     rax, rdx
        sub     rax, rdx
        ret
"sat_add32":
        lea     eax, [rsi+rdi]
        mov     edx, edi
        xor     esi, edi
        shr     edi, 31
        xor     edx, eax
        not     esi
        add     edi, 2147483647
        and     esi, edx
        xor     edi, eax
        sar     esi, 31
        and     esi, edi
        xor     eax, esi
        ret
