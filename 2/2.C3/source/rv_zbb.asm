bswap32:
        rev8    a0,a0
        srai    a0,a0,32
        ret
is_pow2:
        addi    a5,a0,-1
        and     a5,a5,a0
        seqz    a5,a5
        snez    a0,a0
        and     a0,a5,a0
        ret
parity32:
        srliw   a5,a0,16
        xor     a0,a5,a0
        srliw   a5,a0,8
        xor     a5,a5,a0
        srliw   a0,a5,4
        xor     a0,a0,a5
        srliw   a5,a0,2
        xor     a5,a5,a0
        srliw   a0,a5,1
        xor     a0,a0,a5
        andi    a0,a0,1
        ret
popcount32:
        cpopw   a0,a0
        ret
ctz32:
        negw    a5,a0
        and     a0,a5,a0
        addiw   a0,a0,-1
        cpopw   a0,a0
        ret
clz32:
        srliw   a5,a0,1
        or      a0,a5,a0
        srliw   a5,a0,2
        or      a5,a5,a0
        srliw   a0,a5,4
        or      a0,a0,a5
        srliw   a4,a0,8
        or      a4,a4,a0
        srliw   a5,a4,16
        or      a5,a5,a4
        cpopw   a5,a5
        li      a0,32
        subw    a0,a0,a5
        ret
next_pow2:
        snez    a5,a0
        sub     a0,a0,a5
        srli    a5,a0,1
        or      a5,a5,a0
        srli    a4,a5,2
        or      a4,a4,a5
        srli    a5,a4,4
        or      a5,a5,a4
        srli    a4,a5,8
        or      a4,a4,a5
        srli    a5,a4,16
        or      a5,a5,a4
        srli    a0,a5,32
        or      a0,a0,a5
        addi    a0,a0,1
        ret
sign_extend:
        addiw   a1,a1,-1
        li      a4,1
        sll     a4,a4,a1
        addi    a5,a4,-1
        or      a5,a5,a4
        and     a5,a5,a0
        xor     a0,a5,a4
        sub     a0,a0,a4
        ret
sat_add32:
        addw    a4,a1,a0
        li      a5,-2147483648
        xor     a3,a0,a4
        xnor    a1,a0,a1
        addiw   a5,a5,-1
        srliw   a0,a0,31
        and     a1,a1,a3
        addw    a5,a5,a0
        xor     a5,a4,a5
        sraiw   a1,a1,31
        and     a1,a1,a5
        xor     a0,a4,a1
        ret
