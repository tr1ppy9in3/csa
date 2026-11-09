"d7":
        mov     eax, edi
        cdq
        idiv    esi
        ret
"m7":
        mov     eax, edi
        cdq
        idiv    esi
        mov     eax, edx
        ret
