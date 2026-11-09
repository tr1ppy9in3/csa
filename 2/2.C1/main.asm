"f_and":
        movzx   eax, dil
        ret
"f_or":
        mov     eax, edi
        or      eax, 1
        ret
"f_shl":
        lea     eax, [0+rdi*8]
        ret
"f_sar":
        mov     eax, edi
        sar     eax, 3
        ret
"f_xor":
        mov     eax, edi
        shr     eax, 16
        xor     eax, edi
        ret
