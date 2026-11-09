"cmp_double":
        sub     rsp, 24
        mov     rdx, rdi
        mov     rax, rsi
        test    rdi, rdi
        je      .L2
        test    dil, 7
        jne     .L2
.L3:
        movsd   xmm0, QWORD PTR [rdx]
        test    rax, rax
        je      .L4
        test    al, 7
        jne     .L4
.L5:
        movsd   xmm1, QWORD PTR [rax]
        xor     eax, eax
        comisd  xmm0, xmm1
        seta    al
        xor     edx, edx
        comisd  xmm1, xmm0
        seta    dl
        add     rsp, 24
        sub     eax, edx
        ret
.L2:
        mov     rsi, rdx
        mov     edi, OFFSET FLAT:.Lubsan_data19
        mov     QWORD PTR [rsp+8], rax
        mov     QWORD PTR [rsp], rdx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     rax, QWORD PTR [rsp+8]
        mov     rdx, QWORD PTR [rsp]
        jmp     .L3
.L4:
        mov     rsi, rax
        mov     edi, OFFSET FLAT:.Lubsan_data20
        mov     QWORD PTR [rsp], rax
        movsd   QWORD PTR [rsp+8], xmm0
        call    "__ubsan_handle_type_mismatch_v1"
        movsd   xmm0, QWORD PTR [rsp+8]
        mov     rax, QWORD PTR [rsp]
        jmp     .L5
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
        sub     rsp, 24
        mov     r8, rdi
        cmp     ecx, 63
        ja      .L29
.L28:
        mov     edx, 1
        add     rsp, 24
        sal     rdx, cl
        lea     rax, [rdx-1]
        or      rax, rdx
        and     rax, r8
        xor     rax, rdx
        sub     rax, rdx
        ret
"sign_extend.cold":
.L29:
        mov     QWORD PTR [rsp+8], rdi
        mov     edx, ecx
        mov     esi, 1
        mov     edi, OFFSET FLAT:.Lubsan_data0
        mov     DWORD PTR [rsp+4], ecx
        call    "__ubsan_handle_shift_out_of_bounds"
        mov     ecx, DWORD PTR [rsp+4]
        mov     r8, QWORD PTR [rsp+8]
        jmp     .L28
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
.LC2:
        .string "run %d: %.6f s, sum %llu\n"
.LC5:
        .string "median %.6f s, min %.6f, max %.6f, ns/element %.2f\n"
.LC6:
        .string "popcount32"
.LC7:
        .string "FAIL %-12s got %llu, want %llu\n"
.LC8:
        .string "parity32"
.LC9:
        .string "ctz32"
.LC10:
        .string "clz32"
.LC11:
        .string "is_pow2"
.LC12:
        .string "sign_extend"
.LC13:
        .string "FAIL %-12s got %lld, want %lld\n"
.LC16:
        .string "sat_add32"
.LC23:
        .string "FAIL next_pow2(%llu) = %llu\n"
.LC24:
        .string "FAILED: %d\n"
.LC25:
        .string "OK"
"main":
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 200
        cmp     edi, 1
        jle     .L33
        mov     rbx, rsi
        lea     rbp, [rsi+8]
        cmp     rsi, -8
        jnb     .L137
.L34:
        test    bpl, 7
        jne     .L138
.L35:
        mov     rbx, QWORD PTR [rbx+8]
        test    rbx, rbx
        je      .L139
.L36:
        cmp     BYTE PTR [rbx], 45
        je      .L140
.L33:
        mov     ebx, 200000
        mov     eax, 14
        mov     r13d, 1
        mov     ebp, -1013904223
        jmp     .L74
.L54:
        mov     r15d, eax
        add     r15d, 1
        jo      .L141
.L55:
        mov     DWORD PTR "fails"[rip], r15d
.L53:
        mov     edx, r13d
        mov     eax, r13d
        xor     ecx, ecx
        shr     edx, 16
        xor     eax, edx
        xor     al, ah
        setnp   cl
        xor     edx, r13d
        mov     eax, edx
        shr     eax, 8
        xor     edx, eax
        mov     eax, edx
        shr     eax, 4
        xor     edx, eax
        mov     eax, edx
        shr     eax, 2
        xor     edx, eax
        mov     eax, edx
        shr     eax
        xor     edx, eax
        and     edx, 1
        cmp     rcx, rdx
        je      .L57
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jle     .L142
.L58:
        mov     r15d, eax
        add     r15d, 1
        jo      .L143
.L59:
        mov     DWORD PTR "fails"[rip], r15d
.L57:
        test    r13d, r13d
        je      .L61
        mov     eax, ebp
        xor     ecx, ecx
        sub     eax, r14d
        rep bsf ecx, r13d
        and     eax, r13d
        sub     eax, 1
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
        and     edx, 252645135
        imul    edx, edx, 16843009
        shr     edx, 24
        cmp     rcx, rdx
        je      .L62
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jle     .L144
.L63:
        mov     r15d, eax
        add     r15d, 1
        jo      .L145
.L64:
        mov     DWORD PTR "fails"[rip], r15d
.L62:
        mov     eax, r12d
        bsr     ecx, r13d
        or      eax, r13d
        xor     ecx, 31
        mov     edx, eax
        shr     edx, 2
        or      eax, edx
        mov     edx, eax
        shr     edx, 4
        or      eax, edx
        mov     edx, eax
        shr     edx, 8
        or      eax, edx
        mov     edx, eax
        shr     edx, 16
        or      eax, edx
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
        mov     edx, 32
        and     eax, 252645135
        imul    eax, eax, 16843009
        shr     eax, 24
        sub     edx, eax
        cmp     rcx, rdx
        je      .L66
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jle     .L146
.L67:
        mov     r12d, eax
        add     r12d, 1
        jo      .L147
.L68:
        mov     DWORD PTR "fails"[rip], r12d
.L66:
        mov     eax, r13d
        add     r14d, 1013904222
        xor     ecx, ecx
        lea     rdx, [rax-1]
        test    r14d, r13d
        sete    cl
        test    rdx, rax
        sete    dl
        movzx   edx, dl
        cmp     rcx, rdx
        je      .L61
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jle     .L148
.L70:
        mov     r12d, eax
        add     r12d, 1
        jo      .L149
.L71:
        mov     DWORD PTR "fails"[rip], r12d
.L61:
        sub     ebx, 1
        je      .L125
        imul    eax, r13d, 1664525
        lea     edi, [rax+1013904223]
        call    "__popcountdi2"
.L74:
        imul    r14d, r13d, 1664525
        mov     ecx, eax
        lea     r13d, [r14+1013904223]
        mov     r12d, r13d
        mov     edx, r13d
        shr     r12d
        mov     eax, r12d
        and     eax, 1431655765
        sub     edx, eax
        mov     eax, edx
        shr     edx, 2
        and     edx, 858993459
        and     eax, 858993459
        add     eax, edx
        mov     edx, eax
        shr     edx, 4
        add     edx, eax
        and     edx, 252645135
        imul    edx, edx, 16843009
        shr     edx, 24
        cmp     rcx, rdx
        je      .L53
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jg      .L54
        mov     esi, OFFSET FLAT:.LC6
        mov     edi, OFFSET FLAT:.LC7
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L54
.L148:
        mov     esi, OFFSET FLAT:.LC11
        mov     edi, OFFSET FLAT:.LC7
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L70
.L142:
        mov     esi, OFFSET FLAT:.LC8
        mov     edi, OFFSET FLAT:.LC7
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L58
.L146:
        mov     esi, OFFSET FLAT:.LC10
        mov     edi, OFFSET FLAT:.LC7
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L67
.L144:
        mov     esi, OFFSET FLAT:.LC9
        mov     edi, OFFSET FLAT:.LC7
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L63
.L125:
        movabs  r15, 1085102592571150095
        mov     ebp, 63
        movabs  r12, -9223372036854775808
        movabs  r14, -1085102592571150096
        jmp     .L73
.L76:
        mov     eax, ecx
        add     eax, 1
        jo      .L150
.L77:
        mov     DWORD PTR "fails"[rip], eax
.L75:
        and     rbx, r14
        mov     ecx, ebp
        mov     rax, r14
        mov     rdx, rbx
        sal     rax, cl
        xor     rdx, r13
        sar     rax, cl
        sub     rdx, r13
        mov     rcx, rax
        cmp     rdx, rax
        je      .L79
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jle     .L151
.L80:
        mov     ebx, eax
        add     ebx, 1
        jo      .L152
.L81:
        mov     DWORD PTR "fails"[rip], ebx
.L79:
        sub     ebp, 1
        jb      .L153
.L73:
        mov     ecx, ebp
        mov     r13, r12
        mov     rax, r15
        shr     r13, cl
        sal     rax, cl
        lea     rbx, [r13-1]
        sar     rax, cl
        or      rbx, r13
        mov     rdx, rbx
        and     rdx, r15
        xor     rdx, r13
        sub     rdx, r13
        cmp     rdx, rax
        je      .L75
        mov     ecx, DWORD PTR "fails"[rip]
        cmp     ecx, 9
        jg      .L76
        mov     rcx, rax
        mov     esi, OFFSET FLAT:.LC12
        mov     edi, OFFSET FLAT:.LC13
        xor     eax, eax
        call    "printf"
        mov     ecx, DWORD PTR "fails"[rip]
        jmp     .L76
.L151:
        mov     esi, OFFSET FLAT:.LC12
        mov     edi, OFFSET FLAT:.LC13
        xor     eax, eax
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        jmp     .L80
.L153:
        lea     r12, [rsp+64]
        movdqa  xmm0, XMMWORD PTR .LC14[rip]
        xor     edx, edx
        movabs  rax, 53021371269121
        mov     QWORD PTR [rsp+80], rax
        mov     eax, 4
        sub     rax, r12
        mov     DWORD PTR [rsp+88], -12345
        mov     QWORD PTR [rsp+40], rax
        mov     QWORD PTR [rsp], r12
        movaps  XMMWORD PTR [rsp+64], xmm0
.L83:
        mov     rax, QWORD PTR [rsp]
        mov     rdi, QWORD PTR [rsp+40]
        xor     r13d, r13d
        mov     r9d, edx
        mov     QWORD PTR [rsp+32], rdx
        mov     r15d, 4
        lea     r8, [r12+rdx*4]
        lea     r10, [rax+rdi]
        jmp     .L100
.L97:
        mov     ebx, eax
        add     ebx, 1
        jo      .L154
.L98:
        mov     DWORD PTR "fails"[rip], ebx
.L96:
        add     r13, 1
        add     r15, 4
        cmp     r13, 7
        je      .L155
.L100:
        mov     eax, r13d
        mov     esi, r13d
        cmp     r13d, 6
        ja      .L156
.L84:
        lea     r14, [0+r13*4]
        lea     r11, [r12+r14]
        cmp     r15, 28
        ja      .L157
.L85:
        mov     rdx, r12
        add     rdx, r14
        jc      .L158
.L86:
        mov     ebx, DWORD PTR [r12+r13*4]
        cmp     r9, 7
        jnb     .L159
.L87:
        cmp     r10, 28
        ja      .L160
.L88:
        cmp     r8, r12
        jb      .L161
.L89:
        mov     rdi, QWORD PTR [rsp]
        movsxd  rdx, ebx
        mov     esi, eax
        movsxd  rcx, DWORD PTR [rdi]
        mov     rbp, rcx
        add     rcx, rdx
        mov     rdx, -2147483648
        cmp     rcx, rdx
        cmovl   rcx, rdx
        mov     edx, 2147483647
        cmp     rcx, rdx
        cmovg   rcx, rdx
        cmp     eax, 6
        ja      .L162
.L90:
        cmp     r15, 28
        ja      .L163
.L91:
        add     r14, r12
        jc      .L164
.L92:
        cmp     r9, 7
        jnb     .L165
.L93:
        cmp     r10, 28
        ja      .L166
.L94:
        cmp     r8, r12
        jb      .L167
.L95:
        lea     eax, [rbx+rbp]
        xor     ebx, ebp
        mov     esi, ebp
        shr     ebp, 31
        not     ebx
        xor     esi, eax
        add     ebp, 2147483647
        mov     edx, ebx
        xor     ebp, eax
        and     edx, esi
        sar     edx, 31
        and     edx, ebp
        xor     edx, eax
        movsxd  rdx, edx
        cmp     rdx, rcx
        je      .L96
        mov     eax, DWORD PTR "fails"[rip]
        cmp     eax, 9
        jg      .L97
        mov     esi, OFFSET FLAT:.LC16
        mov     edi, OFFSET FLAT:.LC13
        xor     eax, eax
        mov     QWORD PTR [rsp+24], r9
        mov     QWORD PTR [rsp+16], r10
        mov     QWORD PTR [rsp+8], r8
        call    "printf"
        mov     eax, DWORD PTR "fails"[rip]
        mov     r9, QWORD PTR [rsp+24]
        mov     r10, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        jmp     .L97
.L155:
        mov     rdx, QWORD PTR [rsp+32]
        add     QWORD PTR [rsp], 4
        add     rdx, 1
        cmp     rdx, 7
        jne     .L83
        movdqa  xmm0, XMMWORD PTR .LC17[rip]
        mov     r12d, 8
        xor     ebp, ebp
        lea     rbx, [rsp+96]
        movaps  XMMWORD PTR [rsp+96], xmm0
        movdqa  xmm0, XMMWORD PTR .LC18[rip]
        movaps  XMMWORD PTR [rsp+112], xmm0
        movdqa  xmm0, XMMWORD PTR .LC19[rip]
        movaps  XMMWORD PTR [rsp+128], xmm0
        movdqa  xmm0, XMMWORD PTR .LC20[rip]
        movaps  XMMWORD PTR [rsp+144], xmm0
        movdqa  xmm0, XMMWORD PTR .LC21[rip]
        movaps  XMMWORD PTR [rsp+160], xmm0
        movdqa  xmm0, XMMWORD PTR .LC22[rip]
        movaps  XMMWORD PTR [rsp+176], xmm0
.L121:
        mov     r15d, ebp
        mov     esi, ebp
        cmp     ebp, 11
        ja      .L168
.L102:
        lea     r13, [0+rbp*8]
        lea     rcx, [rbx+r13]
        cmp     r12, 96
        ja      .L169
.L103:
        mov     rdx, rbx
        add     rdx, r13
        jc      .L170
.L104:
        mov     r14, QWORD PTR [rbx+rbp*8]
        mov     r9d, r15d
        cmp     r14, 1
        mov     rax, r14
        adc     rax, -1
        mov     rdx, rax
        shr     rdx
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 2
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 4
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 8
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 16
        or      rax, rdx
        mov     rdx, rax
        shr     rdx, 32
        or      rax, rdx
        lea     r8, [rax+1]
        cmp     r15d, 11
        ja      .L171
.L105:
        cmp     r12, 96
        ja      .L172
.L106:
        mov     rdx, rbx
        add     rdx, r13
        jc      .L173
.L107:
        cmp     r8, r14
        jb      .L108
        test    rax, r8
        jne     .L108
        cmp     r9, 12
        jnb     .L174
.L109:
        cmp     r12, 96
        ja      .L175
.L110:
        mov     rdx, rbx
        add     rdx, r13
        jc      .L176
.L111:
        cmp     r14, 1
        jbe     .L112
        mov     r15, r8
        shr     r15
        cmp     r9, 12
        jnb     .L177
.L113:
        cmp     r12, 96
        ja      .L178
.L114:
        mov     rdx, rbx
        add     rdx, r13
        jc      .L179
.L115:
        cmp     r15, r14
        jb      .L112
.L108:
        cmp     r9, 12
        jnb     .L180
.L116:
        cmp     r12, 96
        ja      .L181
.L117:
        add     r13, rbx
        jc      .L182
.L118:
        xor     eax, eax
        mov     rdx, r8
        mov     rsi, r14
        mov     edi, OFFSET FLAT:.LC23
        call    "printf"
        mov     r13d, DWORD PTR "fails"[rip]
        add     r13d, 1
        jo      .L183
.L119:
        mov     DWORD PTR "fails"[rip], r13d
.L112:
        add     rbp, 1
        add     r12, 8
        cmp     rbp, 12
        jne     .L121
        mov     ebx, DWORD PTR "fails"[rip]
        test    ebx, ebx
        jne     .L184
        mov     edi, OFFSET FLAT:.LC25
        call    "puts"
.L32:
        add     rsp, 200
        mov     eax, ebx
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        ret
.L184:
        mov     esi, ebx
        mov     edi, OFFSET FLAT:.LC24
        xor     eax, eax
        mov     ebx, 1
        call    "printf"
        jmp     .L32
.L140:
        xor     r12d, r12d
        xor     ebp, ebp
        mov     ebx, -1831433054
        jmp     .L40
.L123:
        mov     r12, r13
.L40:
        mov     eax, ebx
        mov     esi, ebp
        sal     eax, 13
        xor     eax, ebx
        mov     edx, eax
        shr     edx, 17
        xor     eax, edx
        mov     ebx, eax
        sal     ebx, 5
        xor     ebx, eax
        cmp     ebp, 4194303
        ja      .L185
.L37:
        lea     r13, [r12+4]
        lea     r14, "a.0"[r12]
        cmp     r13, 16777216
        ja      .L186
.L38:
        cmp     r14, OFFSET FLAT:"a.0"
        jb      .L187
.L39:
        add     ebp, 1
        mov     DWORD PTR "a.0"[r12], ebx
        cmp     ebp, 4194304
        jne     .L123
        xor     ebx, ebx
        lea     r12, [rsp+64]
        lea     rbp, [rsp+96]
.L51:
        mov     rsi, r12
        mov     edi, 1
        mov     DWORD PTR [rsp+8], ebx
        mov     r13d, ebx
        call    "clock_gettime"
        pxor    xmm0, xmm0
        pxor    xmm1, xmm1
        xor     eax, eax
        cvtsi2sd        xmm0, QWORD PTR [rsp+72]
        cvtsi2sd        xmm1, QWORD PTR [rsp+64]
        xor     r14d, r14d
        xor     r15d, r15d
        mulsd   xmm0, QWORD PTR .LC1[rip]
        addsd   xmm0, xmm1
        movsd   QWORD PTR [rsp], xmm0
        jmp     .L44
.L124:
        mov     rax, r8
.L44:
        mov     esi, r15d
        cmp     r15d, 4194303
        ja      .L188
.L41:
        lea     r8, [rax+4]
        lea     rdx, "a.0"[rax]
        cmp     r8, 16777216
        ja      .L189
.L42:
        cmp     rdx, OFFSET FLAT:"a.0"
        jb      .L190
.L43:
        mov     eax, DWORD PTR "a.0"[rax]
        add     r15d, 1
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
        add     r14, rax
        cmp     r15d, 4194304
        jne     .L124
        mov     rsi, r12
        mov     edi, 1
        call    "clock_gettime"
        pxor    xmm0, xmm0
        mov     eax, r13d
        pxor    xmm1, xmm1
        cvtsi2sd        xmm0, QWORD PTR [rsp+72]
        mulsd   xmm0, QWORD PTR .LC1[rip]
        cvtsi2sd        xmm1, QWORD PTR [rsp+64]
        mov     QWORD PTR [rsp+16], rax
        addsd   xmm0, xmm1
        cmp     r13d, 4
        ja      .L191
.L45:
        lea     r15, [0+rbx*8]
        subsd   xmm0, QWORD PTR [rsp]
        lea     r8, [r15+8]
        lea     r9, [rbp+0+r15]
        cmp     r8, 40
        ja      .L192
.L46:
        mov     rdx, rbp
        add     rdx, r15
        jc      .L193
.L47:
        movsd   QWORD PTR [rbp+0+rbx*8], xmm0
        cmp     QWORD PTR [rsp+16], 5
        jnb     .L194
.L48:
        cmp     r8, 40
        ja      .L195
.L49:
        mov     rax, r15
        add     rax, rbp
        jc      .L196
.L50:
        mov     esi, DWORD PTR [rsp+8]
        mov     rdx, r14
        mov     edi, OFFSET FLAT:.LC2
        add     rbx, 1
        mov     eax, 1
        add     esi, 1
        call    "printf"
        cmp     rbx, 5
        jne     .L51
        mov     ecx, OFFSET FLAT:"cmp_double"
        mov     edx, 8
        mov     rdi, rbp
        xor     ebx, ebx
        mov     esi, 5
        call    "qsort"
        movsd   xmm0, QWORD PTR [rsp+112]
        movsd   xmm1, QWORD PTR [rsp+96]
        mov     edi, OFFSET FLAT:.LC5
        movsd   xmm3, QWORD PTR .LC3[rip]
        mov     eax, 4
        movsd   xmm2, QWORD PTR [rsp+128]
        mulsd   xmm3, xmm0
        mulsd   xmm3, QWORD PTR .LC4[rip]
        call    "printf"
        jmp     .L32
.L149:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data73
        call    "__ubsan_handle_add_overflow"
        jmp     .L71
.L143:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data70
        call    "__ubsan_handle_add_overflow"
        jmp     .L59
.L141:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data69
        call    "__ubsan_handle_add_overflow"
        jmp     .L55
.L190:
        mov     esi, OFFSET FLAT:"a.0"
        mov     edi, OFFSET FLAT:.Lubsan_data35
        mov     QWORD PTR [rsp+24], rax
        mov     QWORD PTR [rsp+16], r8
        call    "__ubsan_handle_pointer_overflow"
        mov     rax, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        jmp     .L43
.L189:
        mov     rsi, rdx
        add     rsi, r8
        jc      .L42
        mov     rsi, rdx
        mov     edi, OFFSET FLAT:.Lubsan_data34
        mov     QWORD PTR [rsp+32], rax
        mov     QWORD PTR [rsp+24], r8
        mov     QWORD PTR [rsp+16], rdx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     rax, QWORD PTR [rsp+32]
        mov     r8, QWORD PTR [rsp+24]
        mov     rdx, QWORD PTR [rsp+16]
        jmp     .L42
.L188:
        mov     edi, OFFSET FLAT:.Lubsan_data33
        mov     QWORD PTR [rsp+16], rax
        call    "__ubsan_handle_out_of_bounds"
        mov     rax, QWORD PTR [rsp+16]
        jmp     .L41
.L152:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data75
        call    "__ubsan_handle_add_overflow"
        jmp     .L81
.L147:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data72
        call    "__ubsan_handle_add_overflow"
        jmp     .L68
.L165:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data51
        mov     QWORD PTR [rsp+48], r10
        mov     QWORD PTR [rsp+24], r8
        mov     QWORD PTR [rsp+16], rcx
        mov     QWORD PTR [rsp+8], r9
        call    "__ubsan_handle_out_of_bounds"
        mov     r10, QWORD PTR [rsp+48]
        mov     r8, QWORD PTR [rsp+24]
        mov     rcx, QWORD PTR [rsp+16]
        mov     r9, QWORD PTR [rsp+8]
        jmp     .L93
.L145:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data71
        call    "__ubsan_handle_add_overflow"
        jmp     .L64
.L150:
        movsxd  rsi, ecx
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data74
        mov     DWORD PTR [rsp], eax
        call    "__ubsan_handle_add_overflow"
        mov     eax, DWORD PTR [rsp]
        jmp     .L77
.L156:
        mov     edi, OFFSET FLAT:.Lubsan_data42
        mov     QWORD PTR [rsp+48], r9
        mov     QWORD PTR [rsp+24], r10
        mov     QWORD PTR [rsp+16], r8
        mov     DWORD PTR [rsp+8], r13d
        call    "__ubsan_handle_out_of_bounds"
        mov     r9, QWORD PTR [rsp+48]
        mov     r10, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     eax, DWORD PTR [rsp+8]
        jmp     .L84
.L161:
        mov     rdx, r8
        mov     rsi, r12
        mov     edi, OFFSET FLAT:.Lubsan_data47
        mov     QWORD PTR [rsp+56], r9
        mov     QWORD PTR [rsp+48], r10
        mov     DWORD PTR [rsp+24], eax
        mov     QWORD PTR [rsp+16], r11
        mov     QWORD PTR [rsp+8], r8
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+56]
        mov     r10, QWORD PTR [rsp+48]
        mov     eax, DWORD PTR [rsp+24]
        mov     r11, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        jmp     .L89
.L160:
        mov     rsi, QWORD PTR [rsp]
        add     rsi, r10
        jc      .L88
        mov     rsi, QWORD PTR [rsp]
        mov     edi, OFFSET FLAT:.Lubsan_data46
        mov     QWORD PTR [rsp+56], r9
        mov     QWORD PTR [rsp+48], r10
        mov     QWORD PTR [rsp+24], r8
        mov     DWORD PTR [rsp+16], eax
        mov     QWORD PTR [rsp+8], r11
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+56]
        mov     r10, QWORD PTR [rsp+48]
        mov     r8, QWORD PTR [rsp+24]
        mov     eax, DWORD PTR [rsp+16]
        mov     r11, QWORD PTR [rsp+8]
        jmp     .L88
.L159:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data45
        mov     QWORD PTR [rsp+56], r10
        mov     QWORD PTR [rsp+48], r8
        mov     DWORD PTR [rsp+24], eax
        mov     QWORD PTR [rsp+16], r11
        mov     QWORD PTR [rsp+8], r9
        call    "__ubsan_handle_out_of_bounds"
        mov     r10, QWORD PTR [rsp+56]
        mov     r8, QWORD PTR [rsp+48]
        mov     eax, DWORD PTR [rsp+24]
        mov     r11, QWORD PTR [rsp+16]
        mov     r9, QWORD PTR [rsp+8]
        jmp     .L87
.L158:
        mov     rsi, r12
        mov     edi, OFFSET FLAT:.Lubsan_data44
        mov     QWORD PTR [rsp+56], r9
        mov     QWORD PTR [rsp+48], r10
        mov     QWORD PTR [rsp+24], r8
        mov     DWORD PTR [rsp+16], eax
        mov     QWORD PTR [rsp+8], r11
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+56]
        mov     r10, QWORD PTR [rsp+48]
        mov     r8, QWORD PTR [rsp+24]
        mov     eax, DWORD PTR [rsp+16]
        mov     r11, QWORD PTR [rsp+8]
        jmp     .L86
.L157:
        mov     rsi, r11
        add     rsi, r15
        jc      .L85
        mov     rsi, r11
        mov     edi, OFFSET FLAT:.Lubsan_data43
        mov     QWORD PTR [rsp+56], r9
        mov     QWORD PTR [rsp+48], r10
        mov     QWORD PTR [rsp+24], r8
        mov     DWORD PTR [rsp+16], eax
        mov     QWORD PTR [rsp+8], r11
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+56]
        mov     r10, QWORD PTR [rsp+48]
        mov     r8, QWORD PTR [rsp+24]
        mov     eax, DWORD PTR [rsp+16]
        mov     r11, QWORD PTR [rsp+8]
        jmp     .L85
.L154:
        movsxd  rsi, eax
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data76
        mov     QWORD PTR [rsp+24], r9
        mov     QWORD PTR [rsp+16], r10
        mov     QWORD PTR [rsp+8], r8
        call    "__ubsan_handle_add_overflow"
        mov     r9, QWORD PTR [rsp+24]
        mov     r10, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        jmp     .L98
.L167:
        mov     rdx, r8
        mov     rsi, r12
        mov     edi, OFFSET FLAT:.Lubsan_data53
        mov     QWORD PTR [rsp+48], r9
        mov     QWORD PTR [rsp+24], r10
        mov     QWORD PTR [rsp+16], rcx
        mov     QWORD PTR [rsp+8], r8
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+48]
        mov     r10, QWORD PTR [rsp+24]
        mov     rcx, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        jmp     .L95
.L166:
        mov     rax, QWORD PTR [rsp]
        add     rax, r10
        jc      .L94
        mov     rsi, QWORD PTR [rsp]
        mov     edi, OFFSET FLAT:.Lubsan_data52
        mov     QWORD PTR [rsp+48], r9
        mov     QWORD PTR [rsp+24], r10
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+48]
        mov     r10, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        jmp     .L94
.L164:
        mov     rdx, r14
        mov     rsi, r12
        mov     edi, OFFSET FLAT:.Lubsan_data50
        mov     QWORD PTR [rsp+48], r9
        mov     QWORD PTR [rsp+24], r10
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rcx
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+48]
        mov     r10, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        jmp     .L92
.L163:
        mov     rax, r11
        add     rax, r15
        jc      .L91
        mov     rsi, r11
        mov     edi, OFFSET FLAT:.Lubsan_data49
        mov     QWORD PTR [rsp+48], r9
        mov     QWORD PTR [rsp+24], r10
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+48]
        mov     r10, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        jmp     .L91
.L162:
        mov     edi, OFFSET FLAT:.Lubsan_data48
        mov     QWORD PTR [rsp+56], r9
        mov     QWORD PTR [rsp+48], r10
        mov     QWORD PTR [rsp+24], r8
        mov     QWORD PTR [rsp+16], rcx
        mov     QWORD PTR [rsp+8], r11
        call    "__ubsan_handle_out_of_bounds"
        mov     r9, QWORD PTR [rsp+56]
        mov     r10, QWORD PTR [rsp+48]
        mov     r8, QWORD PTR [rsp+24]
        mov     rcx, QWORD PTR [rsp+16]
        mov     r11, QWORD PTR [rsp+8]
        jmp     .L90
.L170:
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.Lubsan_data56
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_pointer_overflow"
        mov     rcx, QWORD PTR [rsp]
        jmp     .L104
.L168:
        mov     edi, OFFSET FLAT:.Lubsan_data54
        call    "__ubsan_handle_out_of_bounds"
        jmp     .L102
.L173:
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.Lubsan_data59
        mov     QWORD PTR [rsp+24], r9
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rax
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     rax, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L107
.L172:
        mov     rsi, rcx
        add     rsi, r12
        jc      .L106
        mov     rsi, rcx
        mov     edi, OFFSET FLAT:.Lubsan_data58
        mov     QWORD PTR [rsp+24], r9
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rax
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+24]
        mov     r8, QWORD PTR [rsp+16]
        mov     rax, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L106
.L171:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data57
        mov     QWORD PTR [rsp+24], r8
        mov     QWORD PTR [rsp+16], rax
        mov     QWORD PTR [rsp+8], rcx
        mov     QWORD PTR [rsp], r9
        call    "__ubsan_handle_out_of_bounds"
        mov     r8, QWORD PTR [rsp+24]
        mov     rax, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        mov     r9, QWORD PTR [rsp]
        jmp     .L105
.L169:
        mov     rax, rcx
        add     rax, r12
        jc      .L103
        mov     rsi, rcx
        mov     edi, OFFSET FLAT:.Lubsan_data55
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     rcx, QWORD PTR [rsp]
        jmp     .L103
.L196:
        mov     rdx, rax
        mov     rsi, rbp
        mov     edi, OFFSET FLAT:.Lubsan_data41
        movsd   QWORD PTR [rsp], xmm0
        call    "__ubsan_handle_pointer_overflow"
        movsd   xmm0, QWORD PTR [rsp]
        jmp     .L50
.L195:
        add     r8, r9
        jc      .L49
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data40
        movsd   QWORD PTR [rsp], xmm0
        call    "__ubsan_handle_type_mismatch_v1"
        movsd   xmm0, QWORD PTR [rsp]
        jmp     .L49
.L194:
        movsxd  rsi, r13d
        mov     edi, OFFSET FLAT:.Lubsan_data39
        mov     QWORD PTR [rsp+24], r8
        mov     QWORD PTR [rsp+16], r9
        movsd   QWORD PTR [rsp], xmm0
        call    "__ubsan_handle_out_of_bounds"
        mov     r8, QWORD PTR [rsp+24]
        mov     r9, QWORD PTR [rsp+16]
        movsd   xmm0, QWORD PTR [rsp]
        jmp     .L48
.L193:
        mov     rsi, rbp
        mov     edi, OFFSET FLAT:.Lubsan_data38
        mov     QWORD PTR [rsp+32], r8
        mov     QWORD PTR [rsp+24], r9
        movsd   QWORD PTR [rsp], xmm0
        call    "__ubsan_handle_pointer_overflow"
        mov     r8, QWORD PTR [rsp+32]
        mov     r9, QWORD PTR [rsp+24]
        movsd   xmm0, QWORD PTR [rsp]
        jmp     .L47
.L192:
        mov     rax, r9
        add     rax, r8
        jc      .L46
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data37
        mov     QWORD PTR [rsp+32], r8
        mov     QWORD PTR [rsp], r9
        movsd   QWORD PTR [rsp+24], xmm0
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r8, QWORD PTR [rsp+32]
        movsd   xmm0, QWORD PTR [rsp+24]
        mov     r9, QWORD PTR [rsp]
        jmp     .L46
.L191:
        movsxd  rsi, r13d
        mov     edi, OFFSET FLAT:.Lubsan_data36
        movsd   QWORD PTR [rsp+24], xmm0
        call    "__ubsan_handle_out_of_bounds"
        movsd   xmm0, QWORD PTR [rsp+24]
        jmp     .L45
.L187:
        mov     rdx, r14
        mov     esi, OFFSET FLAT:"a.0"
        mov     edi, OFFSET FLAT:.Lubsan_data32
        call    "__ubsan_handle_pointer_overflow"
        jmp     .L39
.L176:
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.Lubsan_data62
        mov     QWORD PTR [rsp+16], r9
        mov     QWORD PTR [rsp+8], r8
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L111
.L180:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data66
        mov     QWORD PTR [rsp+8], r8
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_out_of_bounds"
        mov     r8, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L116
.L179:
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.Lubsan_data65
        mov     QWORD PTR [rsp+16], r9
        mov     QWORD PTR [rsp+8], r8
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_pointer_overflow"
        mov     r9, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L115
.L178:
        mov     rax, rcx
        add     rax, r12
        jc      .L114
        mov     rsi, rcx
        mov     edi, OFFSET FLAT:.Lubsan_data64
        mov     QWORD PTR [rsp+16], r9
        mov     QWORD PTR [rsp+8], r8
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L114
.L177:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data63
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rcx
        mov     QWORD PTR [rsp], r9
        call    "__ubsan_handle_out_of_bounds"
        mov     r8, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        mov     r9, QWORD PTR [rsp]
        jmp     .L113
.L182:
        mov     rdx, r13
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.Lubsan_data68
        mov     QWORD PTR [rsp], r8
        call    "__ubsan_handle_pointer_overflow"
        mov     r8, QWORD PTR [rsp]
        jmp     .L118
.L181:
        mov     rax, rcx
        add     rax, r12
        jc      .L117
        mov     rsi, rcx
        mov     edi, OFFSET FLAT:.Lubsan_data67
        mov     QWORD PTR [rsp], r8
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r8, QWORD PTR [rsp]
        jmp     .L117
.L186:
        mov     rax, r14
        add     rax, r13
        jc      .L38
        mov     rsi, r14
        mov     edi, OFFSET FLAT:.Lubsan_data31
        call    "__ubsan_handle_type_mismatch_v1"
        jmp     .L38
.L185:
        mov     edi, OFFSET FLAT:.Lubsan_data30
        call    "__ubsan_handle_out_of_bounds"
        jmp     .L37
.L137:
        mov     rdx, rbp
        mov     edi, OFFSET FLAT:.Lubsan_data27
        call    "__ubsan_handle_pointer_overflow"
        jmp     .L34
.L175:
        mov     rax, rcx
        add     rax, r12
        jc      .L110
        mov     rsi, rcx
        mov     edi, OFFSET FLAT:.Lubsan_data61
        mov     QWORD PTR [rsp+16], r9
        mov     QWORD PTR [rsp+8], r8
        mov     QWORD PTR [rsp], rcx
        call    "__ubsan_handle_type_mismatch_v1"
        mov     r9, QWORD PTR [rsp+16]
        mov     r8, QWORD PTR [rsp+8]
        mov     rcx, QWORD PTR [rsp]
        jmp     .L110
.L174:
        mov     rsi, r9
        mov     edi, OFFSET FLAT:.Lubsan_data60
        mov     QWORD PTR [rsp+16], r8
        mov     QWORD PTR [rsp+8], rcx
        mov     QWORD PTR [rsp], r9
        call    "__ubsan_handle_out_of_bounds"
        mov     r8, QWORD PTR [rsp+16]
        mov     rcx, QWORD PTR [rsp+8]
        mov     r9, QWORD PTR [rsp]
        jmp     .L109
.L183:
        movsxd  rsi, DWORD PTR "fails"[rip]
        mov     edx, 1
        mov     edi, OFFSET FLAT:.Lubsan_data77
        call    "__ubsan_handle_add_overflow"
        jmp     .L119
.L139:
        xor     esi, esi
        mov     edi, OFFSET FLAT:.Lubsan_data29
        call    "__ubsan_handle_type_mismatch_v1"
        jmp     .L36
.L138:
        mov     rsi, rbp
        mov     edi, OFFSET FLAT:.Lubsan_data28
        call    "__ubsan_handle_type_mismatch_v1"
        jmp     .L35
.LC26:
        .string "/app/example.c"
.Lubsan_data77:
        .quad   .LC26
        .long   207
        .long   18
        .quad   .Lubsan_type8
.Lubsan_data76:
        .quad   .LC26
        .long   91
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data75:
        .quad   .LC26
        .long   91
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data74:
        .quad   .LC26
        .long   91
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data73:
        .quad   .LC26
        .long   83
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data72:
        .quad   .LC26
        .long   83
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data71:
        .quad   .LC26
        .long   83
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data70:
        .quad   .LC26
        .long   83
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data69:
        .quad   .LC26
        .long   83
        .long   14
        .quad   .Lubsan_type8
.Lubsan_data68:
        .quad   .LC26
        .long   206
        .long   42
.Lubsan_data67:
        .quad   .LC26
        .long   206
        .long   42
        .quad   .Lubsan_type14
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data66:
        .quad   .LC26
        .long   206
        .long   42
        .quad   .Lubsan_type13
        .quad   .Lubsan_type1
.Lubsan_data65:
        .quad   .LC26
        .long   203
        .long   43
.Lubsan_data64:
        .quad   .LC26
        .long   203
        .long   43
        .quad   .Lubsan_type14
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data63:
        .quad   .LC26
        .long   203
        .long   43
        .quad   .Lubsan_type13
        .quad   .Lubsan_type1
.Lubsan_data62:
        .quad   .LC26
        .long   203
        .long   21
.Lubsan_data61:
        .quad   .LC26
        .long   203
        .long   21
        .quad   .Lubsan_type14
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data60:
        .quad   .LC26
        .long   203
        .long   21
        .quad   .Lubsan_type13
        .quad   .Lubsan_type1
.Lubsan_data59:
        .quad   .LC26
        .long   202
        .long   25
.Lubsan_data58:
        .quad   .LC26
        .long   202
        .long   25
        .quad   .Lubsan_type14
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data57:
        .quad   .LC26
        .long   202
        .long   25
        .quad   .Lubsan_type13
        .quad   .Lubsan_type1
.Lubsan_data56:
        .quad   .LC26
        .long   201
        .long   22
.Lubsan_data55:
        .quad   .LC26
        .long   201
        .long   22
        .quad   .Lubsan_type14
        .byte   0
        .byte   0
        .zero   6
.Lubsan_type14:
        .value  -1
        .value  0
        .string "'uint64_t'"
.Lubsan_data54:
        .quad   .LC26
        .long   201
        .long   34
        .quad   .Lubsan_type13
        .quad   .Lubsan_type1
.Lubsan_type13:
        .value  0
        .value  12
        .string "'uint64_t [12]'"
.Lubsan_data53:
        .quad   .LC26
        .long   192
        .long   34
.Lubsan_data52:
        .quad   .LC26
        .long   192
        .long   34
        .quad   .Lubsan_type12
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data51:
        .quad   .LC26
        .long   192
        .long   48
        .quad   .Lubsan_type11
        .quad   .Lubsan_type1
.Lubsan_data50:
        .quad   .LC26
        .long   192
        .long   34
.Lubsan_data49:
        .quad   .LC26
        .long   192
        .long   34
        .quad   .Lubsan_type12
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data48:
        .quad   .LC26
        .long   192
        .long   57
        .quad   .Lubsan_type11
        .quad   .Lubsan_type1
.Lubsan_data47:
        .quad   .LC26
        .long   193
        .long   21
.Lubsan_data46:
        .quad   .LC26
        .long   193
        .long   21
        .quad   .Lubsan_type12
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data45:
        .quad   .LC26
        .long   193
        .long   37
        .quad   .Lubsan_type11
        .quad   .Lubsan_type1
.Lubsan_data44:
        .quad   .LC26
        .long   193
        .long   21
.Lubsan_data43:
        .quad   .LC26
        .long   193
        .long   21
        .quad   .Lubsan_type12
        .byte   0
        .byte   0
        .zero   6
.Lubsan_type12:
        .value  -1
        .value  0
        .string "'int32_t'"
.Lubsan_data42:
        .quad   .LC26
        .long   193
        .long   46
        .quad   .Lubsan_type11
        .quad   .Lubsan_type1
.Lubsan_type11:
        .value  0
        .value  11
        .string "'int32_t [7]'"
.Lubsan_data41:
        .quad   .LC26
        .long   137
        .long   9
.Lubsan_data40:
        .quad   .LC26
        .long   137
        .long   9
        .quad   .Lubsan_type10
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data39:
        .quad   .LC26
        .long   137
        .long   54
        .quad   .Lubsan_type9
        .quad   .Lubsan_type8
.Lubsan_data38:
        .quad   .LC26
        .long   136
        .long   14
.Lubsan_data37:
        .quad   .LC26
        .long   136
        .long   14
        .quad   .Lubsan_type10
        .byte   0
        .byte   1
        .zero   6
.Lubsan_type10:
        .value  -1
        .value  0
        .string "'double'"
.Lubsan_data36:
        .quad   .LC26
        .long   136
        .long   10
        .quad   .Lubsan_type9
        .quad   .Lubsan_type8
.Lubsan_type9:
        .value  1
        .value  64
        .string "'double [5]'"
.Lubsan_type8:
        .value  0
        .value  11
        .string "'int'"
.Lubsan_data35:
        .quad   .LC26
        .long   135
        .long   20
.Lubsan_data34:
        .quad   .LC26
        .long   135
        .long   20
        .quad   .Lubsan_type7
        .byte   0
        .byte   0
        .zero   6
.Lubsan_data33:
        .quad   .LC26
        .long   135
        .long   32
        .quad   .Lubsan_type6
        .quad   .Lubsan_type1
.Lubsan_data32:
        .quad   .LC26
        .long   127
        .long   14
.Lubsan_data31:
        .quad   .LC26
        .long   127
        .long   14
        .quad   .Lubsan_type7
        .byte   0
        .byte   1
        .zero   6
.Lubsan_type7:
        .value  -1
        .value  0
        .string "'uint32_t'"
.Lubsan_data30:
        .quad   .LC26
        .long   127
        .long   10
        .quad   .Lubsan_type6
        .quad   .Lubsan_type1
.Lubsan_type6:
        .value  0
        .value  10
        .string "'uint32_t [4194304]'"
.Lubsan_data29:
        .quad   .LC26
        .long   146
        .long   28
        .quad   .Lubsan_type5
        .byte   0
        .byte   0
        .zero   6
.Lubsan_type5:
        .value  -1
        .value  0
        .string "'char'"
.Lubsan_data28:
        .quad   .LC26
        .long   146
        .long   25
        .quad   .Lubsan_type4
        .byte   3
        .byte   0
        .zero   6
.Lubsan_type4:
        .value  -1
        .value  0
        .string "'char *'"
.Lubsan_data27:
        .quad   .LC26
        .long   146
        .long   25
.Lubsan_data20:
        .quad   .LC26
        .long   115
        .long   12
        .quad   .Lubsan_type3
        .byte   3
        .byte   0
        .zero   6
.Lubsan_data19:
        .quad   .LC26
        .long   114
        .long   12
        .quad   .Lubsan_type3
        .byte   3
        .byte   0
        .zero   6
.Lubsan_type3:
        .value  -1
        .value  0
        .string "'const double'"
.Lubsan_data0:
        .quad   .LC26
        .long   60
        .long   30
        .quad   .Lubsan_type0
        .quad   .Lubsan_type1
.Lubsan_type1:
        .value  0
        .value  10
        .string "'unsigned int'"
.Lubsan_type0:
        .value  0
        .value  12
        .string "'long unsigned int'"
.LC1:
        .long   -400107883
        .long   1041313291
.LC3:
        .long   0
        .long   1104006501
.LC4:
        .long   0
        .long   1049624576
.LC14:
        .long   2147483647
        .long   -2147483648
        .long   -1
        .long   0
.LC17:
        .quad   0
        .quad   1
.LC18:
        .quad   2
        .quad   3
.LC19:
        .quad   7
        .quad   8
.LC20:
        .quad   9
        .quad   2147483647
.LC21:
        .quad   2147483648
        .quad   4611686018427387903
.LC22:
        .quad   4611686018427387904
        .quad   -9223372036854775808
