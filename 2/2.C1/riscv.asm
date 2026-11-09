f_and:
        andi    a0,a0,0xff
        ret
f_or:
        ori     a0,a0,1
        ret
f_shl:
        slli    a0,a0,3
        ret
f_sar:
        srai    a0,a0,3
        ret
f_xor:
        srli    a5,a0,16
        xor     a0,a5,a0
        ret
