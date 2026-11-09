"d7":
        movsxd  rax, edi
        imul    rax, rax, -1840700269
        shr     rax, 32
        add     eax, edi
        sar     edi, 31
        sar     eax, 2
        sub     eax, edi
        ret
"m7":
        movsxd  rax, edi
        mov     edx, edi
        imul    rax, rax, -1840700269
        sar     edx, 31
        shr     rax, 32
        add     eax, edi
        sar     eax, 2
        sub     eax, edx
        lea     edx, [0+rax*8]
        sub     edx, eax
        mov     eax, edi
        sub     eax, edx
        ret
