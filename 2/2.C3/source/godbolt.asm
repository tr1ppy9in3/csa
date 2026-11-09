"bswap32":
        mov     eax, edi
        bswap   eax
        ret
"is_pow2":
        lea     rax, [rdi-1]
        test    rax, rdi
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
        mov     eax, edi
        shr     eax
        and     eax, 1431655765
        sub     edi, eax
        mov     edx, edi
        shr     edi, 2
        and     edx, 858993459
        and     edi, 858993459
        add     edx, edi
        mov     eax, edx
        shr     eax, 4
        add     eax, edx
        and     eax, 252645135
        imul    eax, eax, 16843009
        shr     eax, 24
        ret
"ctz32":
        mov     eax, edi
        neg     eax
        and     eax, edi
        sub     eax, 1
        mov     edx, eax
        shr     edx
        and     edx, 1431655765
        sub     eax, edx
        mov     edx, eax
        shr     eax, 2
        and     eax, 858993459
        and     edx, 858993459
        add     edx, eax
        mov     eax, edx
        shr     eax, 4
        add     eax, edx
        and     eax, 252645135
        imul    eax, eax, 16843009
        shr     eax, 24
        ret
"clz32":
        mov     eax, edi
        shr     eax
        or      eax, edi
        mov     edx, eax
        shr     edx, 2
        or      edx, eax
        mov     eax, edx
        shr     eax, 4
        or      eax, edx
        mov     edx, eax
        shr     edx, 8
        or      edx, eax
        mov     eax, edx
        shr     eax, 16
        or      eax, edx
        mov     edx, eax
        shr     edx
        and     edx, 1431655765
        sub     eax, edx
        mov     edx, eax
        shr     eax, 2
        and     edx, 858993459
        and     eax, 858993459
        add     eax, edx
        mov     edx, eax
        shr     edx, 4
        add     edx, eax
        mov     eax, 32
        and     edx, 252645135
        imul    edx, edx, 16843009
        shr     edx, 24
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
        lea     ecx, [rsi-1]
        mov     edx, 1
        sal     rdx, cl
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
