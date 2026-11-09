"mul_ijk":
        sub     rsp, 32
        mov     QWORD PTR [rsp], rbx
        mov     ebx, DWORD PTR "n"[rip]
        test    ebx, ebx
        jle     .L1
        mov     QWORD PTR [rsp+8], rbp
        mov     eax, ebx
        mov     ebp, ebx
        mov     edi, OFFSET FLAT:"a"
        shr     ebp
        mov     QWORD PTR [rsp+24], r13
        lea     r13, [rax+rax*2]
        xor     r11d, r11d
        mov     r8, r13
        mov     QWORD PTR [rsp+16], r12
        mov     r12d, ebp
        mov     r10d, OFFSET FLAT:"c"
        sal     r8, 11
        sal     r13, 8
        add     ebp, ebp
        sal     r12, 4
.L3:
        cmp     ebx, 1
        je      .L11
.L9:
        lea     r9, [r12+r10]
        lea     rcx, "b"[r8]
        mov     rsi, r10
.L5:
        mov     rax, rcx
        mov     rdx, rdi
        pxor    xmm1, xmm1
        sub     rax, r8
.L4:
        movsd   xmm0, QWORD PTR [rdx]
        add     rax, 6144
        add     rdx, 8
        unpcklpd        xmm0, xmm0
        mulpd   xmm0, XMMWORD PTR [rax-6144]
        addpd   xmm1, xmm0
        cmp     rax, rcx
        jne     .L4
        movaps  XMMWORD PTR [rsi], xmm1
        add     rsi, 16
        lea     rcx, [rax+16]
        cmp     rsi, r9
        jne     .L5
        cmp     ebx, ebp
        je      .L6
        mov     esi, ebp
.L10:
        lea     rdx, [rsi+r13]
        lea     rax, "b"[0+rsi*8]
        pxor    xmm1, xmm1
        lea     rcx, "b"[0+rdx*8]
        mov     rdx, rdi
.L7:
        movsd   xmm0, QWORD PTR [rax]
        mulsd   xmm0, QWORD PTR [rdx]
        add     rax, 6144
        add     rdx, 8
        addsd   xmm1, xmm0
        cmp     rax, rcx
        jne     .L7
        mov     eax, r11d
        add     r11d, 1
        add     rdi, 6144
        add     r10, 6144
        lea     rax, [rax+rax*2]
        sal     rax, 8
        add     rax, rsi
        movsd   QWORD PTR "c"[0+rax*8], xmm1
        cmp     r11d, ebx
        jne     .L3
.L19:
        mov     rbp, QWORD PTR [rsp+8]
        mov     r12, QWORD PTR [rsp+16]
        mov     r13, QWORD PTR [rsp+24]
.L1:
        mov     rbx, QWORD PTR [rsp]
        add     rsp, 32
        ret
.L6:
        add     r11d, 1
        add     rdi, 6144
        add     r10, 6144
        cmp     ebx, r11d
        jne     .L9
        jmp     .L19
.L11:
        xor     esi, esi
        jmp     .L10
"mul_ikj":
        mov     r8d, DWORD PTR "n"[rip]
        test    r8d, r8d
        jle     .L34
        mov     r9d, r8d
        push    r14
        mov     edx, OFFSET FLAT:"c"
        xor     r10d, r10d
        shr     r9d
        push    r13
        mov     esi, r9d
        push    r12
        add     r9d, r9d
        push    rbp
        sal     rsi, 4
        xor     ebp, ebp
        push    rbx
        mov     ebx, r8d
.L23:
        mov     eax, ebp
        mov     ecx, OFFSET FLAT:"b"
        xor     edi, edi
        lea     r11, [rax+rax*2]
        sal     r11, 8
.L29:
        movsd   xmm2, QWORD PTR "a"[r10+rdi*8]
        mov     r14d, edi
        cmp     r8d, 1
        je      .L30
.L28:
        movapd  xmm1, xmm2
        xor     eax, eax
        unpcklpd        xmm1, xmm1
.L25:
        movapd  xmm0, XMMWORD PTR [rcx+rax]
        mulpd   xmm0, xmm1
        addpd   xmm0, XMMWORD PTR [rdx+rax]
        movaps  XMMWORD PTR [rdx+rax], xmm0
        add     rax, 16
        cmp     rsi, rax
        jne     .L25
        cmp     r9d, r8d
        je      .L26
        mov     r13d, r9d
.L24:
        mov     eax, r14d
        lea     r12, [r11+r13]
        add     rdi, 1
        add     rcx, 6144
        lea     rax, [rax+rax*2]
        sal     rax, 8
        add     rax, r13
        mulsd   xmm2, QWORD PTR "b"[0+rax*8]
        addsd   xmm2, QWORD PTR "c"[0+r12*8]
        movsd   QWORD PTR "c"[0+r12*8], xmm2
        cmp     rdi, rbx
        jne     .L29
.L27:
        add     ebp, 1
        add     rdx, 6144
        add     r10, 6144
        cmp     ebp, r8d
        jne     .L23
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        ret
.L26:
        add     rdi, 1
        cmp     rdi, rbx
        je      .L27
        movsd   xmm2, QWORD PTR "a"[r10+rdi*8]
        add     rcx, 6144
        mov     r14d, edi
        jmp     .L28
.L30:
        xor     r13d, r13d
        jmp     .L24
.L34:
        ret
"mul_jik":
        mov     eax, DWORD PTR "n"[rip]
        test    eax, eax
        jle     .L37
        lea     r9, [rax+rax*2]
        mov     r8d, OFFSET FLAT:"b"
        mov     r10d, OFFSET FLAT:"c"
        sal     r9, 11
        lea     r11, "c"[0+rax*8]
        lea     rcx, [r9+r8]
        add     r9, OFFSET FLAT:"a"
.L39:
        mov     esi, OFFSET FLAT:"a"
        mov     rdi, r10
.L42:
        mov     rax, r8
        mov     rdx, rsi
        pxor    xmm1, xmm1
.L40:
        movsd   xmm0, QWORD PTR [rdx]
        mulsd   xmm0, QWORD PTR [rax]
        add     rax, 6144
        add     rdx, 8
        addsd   xmm1, xmm0
        cmp     rax, rcx
        jne     .L40
        add     rsi, 6144
        movsd   QWORD PTR [rdi], xmm1
        add     rdi, 6144
        cmp     rsi, r9
        jne     .L42
        add     r10, 8
        add     r8, 8
        add     rcx, 8
        cmp     r10, r11
        jne     .L39
.L37:
        ret
"mul_jki":
        mov     eax, DWORD PTR "n"[rip]
        test    eax, eax
        jle     .L44
        lea     rsi, [rax+rax*2]
        lea     r8, [0+rax*8]
        xor     edx, edx
        sal     rsi, 11
.L46:
        lea     rdi, "b"[rdx]
        xor     ecx, ecx
.L48:
        movsd   xmm1, QWORD PTR [rdi]
        xor     eax, eax
.L47:
        movsd   xmm0, QWORD PTR "a"[rcx+rax]
        mulsd   xmm0, xmm1
        addsd   xmm0, QWORD PTR "c"[rax+rdx]
        movsd   QWORD PTR "c"[rdx+rax], xmm0
        add     rax, 6144
        cmp     rsi, rax
        jne     .L47
        add     rcx, 8
        add     rdi, 6144
        cmp     rcx, r8
        jne     .L48
        add     rdx, 8
        cmp     rdx, r8
        jne     .L46
.L44:
        ret
"mul_kij":
        mov     r9d, DWORD PTR "n"[rip]
        test    r9d, r9d
        jle     .L64
        mov     r10d, r9d
        push    r12
        mov     ecx, OFFSET FLAT:"b"
        shr     r10d
        push    rbp
        mov     ebp, OFFSET FLAT:"a"
        mov     esi, r10d
        push    rbx
        add     r10d, r10d
        xor     ebx, ebx
        sal     rsi, 4
.L53:
        mov     eax, ebx
        mov     edx, OFFSET FLAT:"c"
        mov     r8, rbp
        xor     edi, edi
        lea     r11, [rax+rax*2]
        sal     r11, 8
.L59:
        movsd   xmm2, QWORD PTR [r8]
        cmp     r9d, 1
        je      .L60
.L58:
        movapd  xmm1, xmm2
        xor     eax, eax
        unpcklpd        xmm1, xmm1
.L55:
        movapd  xmm0, XMMWORD PTR [rcx+rax]
        mulpd   xmm0, xmm1
        addpd   xmm0, XMMWORD PTR [rdx+rax]
        movaps  XMMWORD PTR [rdx+rax], xmm0
        add     rax, 16
        cmp     rsi, rax
        jne     .L55
        cmp     r10d, r9d
        je      .L56
        mov     r12d, r10d
.L54:
        mov     eax, edi
        add     edi, 1
        add     r8, 6144
        add     rdx, 6144
        lea     rax, [rax+rax*2]
        sal     rax, 8
        add     rax, r12
        add     r12, r11
        mulsd   xmm2, QWORD PTR "b"[0+r12*8]
        addsd   xmm2, QWORD PTR "c"[0+rax*8]
        movsd   QWORD PTR "c"[0+rax*8], xmm2
        cmp     edi, r9d
        jne     .L59
.L57:
        add     ebx, 1
        add     rcx, 6144
        add     rbp, 8
        cmp     ebx, r9d
        jne     .L53
        pop     rbx
        pop     rbp
        pop     r12
        ret
.L56:
        add     edi, 1
        cmp     edi, r10d
        je      .L57
        add     r8, 6144
        add     rdx, 6144
        movsd   xmm2, QWORD PTR [r8]
        jmp     .L58
.L60:
        xor     r12d, r12d
        jmp     .L54
.L64:
        ret
"mul_kji":
        mov     r11d, DWORD PTR "n"[rip]
        test    r11d, r11d
        jle     .L87
        push    rbp
        mov     eax, r11d
        mov     r9d, OFFSET FLAT:"b"
        xor     ecx, ecx
        push    rbx
        mov     ebx, r11d
        lea     rsi, [rax+rax*2]
        xor     r10d, r10d
        shr     ebx
        sal     rsi, 11
        mov     ebp, ebx
        add     ebx, ebx
        sal     rbp, 4
.L69:
        cmp     r11d, 1
        je      .L78
.L76:
        mov     edx, OFFSET FLAT:"c"
        lea     r8, [rbp+0+r9]
        mov     rdi, r9
.L74:
        movapd  xmm1, XMMWORD PTR [rdi]
        xor     eax, eax
.L73:
        movsd   xmm0, QWORD PTR "a"[rcx+rax]
        unpcklpd        xmm0, xmm0
        mulpd   xmm0, xmm1
        addpd   xmm0, XMMWORD PTR [rdx+rax]
        movaps  XMMWORD PTR [rdx+rax], xmm0
        add     rax, 6144
        cmp     rax, rsi
        jne     .L73
        add     rdi, 16
        add     rdx, 16
        cmp     rdi, r8
        jne     .L74
        cmp     ebx, r11d
        je      .L70
        mov     edx, ebx
.L77:
        mov     eax, r10d
        lea     rax, [rax+rax*2]
        sal     rax, 8
        add     rax, rdx
        movsd   xmm1, QWORD PTR "b"[0+rax*8]
        xor     eax, eax
.L71:
        movsd   xmm0, QWORD PTR "a"[rcx+rax]
        mulsd   xmm0, xmm1
        addsd   xmm0, QWORD PTR "c"[rax+rdx*8]
        movsd   QWORD PTR "c"[rax+rdx*8], xmm0
        add     rax, 6144
        cmp     rax, rsi
        jne     .L71
        add     r10d, 1
        add     rcx, 8
        add     r9, 6144
        cmp     r10d, r11d
        jne     .L69
        pop     rbx
        pop     rbp
        ret
.L70:
        add     r10d, 1
        add     rcx, 8
        add     r9, 6144
        cmp     ebx, r10d
        jne     .L76
        pop     rbx
        pop     rbp
        ret
.L78:
        xor     edx, edx
        jmp     .L77
.L87:
        ret
.LC1:
        .string "../data/matmul.csv"
.LC2:
        .string "w"
.LC3:
        .base64 "0J3QtSDRg9C00LDQu9C+0YHRjCDQvtGC0LrRgNGL0YLRjCDQv9Cw0L/QutGDIGRhdGEKAA=="
.LC4:
        .base64 "0KDQtdC30YPQu9GM0YLQsNGC0Ysg0LHRg9C00YPRgiDQt9Cw0L/QuNGB0LDQvdGLINCyOiAlcwoA"
.LC5:
        .string "ijk"
.LC6:
        .string "ikj"
.LC7:
        .string "jik"
.LC8:
        .string "jki"
.LC9:
        .string "kij"
.LC10:
        .string "kji"
.LC11:
        .string "n,method,run,seconds,gflops,control\n"
.LC13:
        .base64 "DSBuID0gJTNkIHwg0LzQtdGC0L7QtDogJS0zcyB8INC30LDQv9GD0YHQuiAlZC8lZCAuLi4gICAA"
.LC16:
        .string "%d,%s,%d,%.6f,%.3f,%.9f\n"
.LC17:
        .base64 "CtCT0L7RgtC+0LLQviEA"
"main":
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 168
        cmp     edi, 1
        jle     .L91
        mov     rbx, QWORD PTR [rsi+8]
        mov     esi, OFFSET FLAT:.LC2
        mov     rdi, rbx
        call    "fopen"
        mov     QWORD PTR [rsp+16], rax
.L92:
        cmp     QWORD PTR [rsp+16], 0
        je      .L110
        mov     rsi, rbx
        mov     edi, OFFSET FLAT:.LC4
        xor     eax, eax
        call    "printf"
.L94:
        mov     rcx, QWORD PTR [rsp+16]
        mov     edx, 36
        movabs  rax, 2199023255936
        mov     esi, 1
        mov     edi, OFFSET FLAT:.LC11
        mov     QWORD PTR [rsp+40], rax
        lea     r15, [rsp+48]
        mov     ebx, 128
        mov     DWORD PTR [rsp+36], 256
        mov     QWORD PTR [rsp+64], OFFSET FLAT:.LC5
        mov     QWORD PTR [rsp+72], OFFSET FLAT:"mul_ijk"
        mov     QWORD PTR [rsp+80], OFFSET FLAT:.LC6
        mov     QWORD PTR [rsp+88], OFFSET FLAT:"mul_ikj"
        mov     QWORD PTR [rsp+96], OFFSET FLAT:.LC7
        mov     QWORD PTR [rsp+104], OFFSET FLAT:"mul_jik"
        mov     QWORD PTR [rsp+112], OFFSET FLAT:.LC8
        mov     QWORD PTR [rsp+120], OFFSET FLAT:"mul_jki"
        mov     QWORD PTR [rsp+128], OFFSET FLAT:.LC9
        mov     QWORD PTR [rsp+136], OFFSET FLAT:"mul_kij"
        mov     QWORD PTR [rsp+144], OFFSET FLAT:.LC10
        mov     QWORD PTR [rsp+152], OFFSET FLAT:"mul_kji"
        call    "fwrite"
        lea     rax, [rsp+32]
        mov     QWORD PTR [rsp+24], rax
.L105:
        mov     DWORD PTR "n"[rip], ebx
        test    ebx, ebx
        jle     .L95
        mov     r12d, ebx
        xor     ebp, ebp
        lea     rax, [r12+r12*2]
        sal     r12, 3
        sal     rax, 11
        mov     r13, rax
.L96:
        xor     r14d, r14d
.L97:
        call    "rand"
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, eax
        divsd   xmm0, QWORD PTR .LC12[rip]
        movsd   QWORD PTR "a"[rbp+r14], xmm0
        call    "rand"
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, eax
        divsd   xmm0, QWORD PTR .LC12[rip]
        movsd   QWORD PTR "b"[rbp+r14], xmm0
        add     r14, 8
        cmp     r14, r12
        jne     .L97
        add     rbp, 6144
        cmp     rbp, r13
        jne     .L96
.L95:
        lea     r14, [rsp+64]
.L98:
        mov     r12d, 1
.L103:
        mov     r13, QWORD PTR [r14]
        mov     esi, ebx
        mov     r8d, 5
        mov     ecx, r12d
        mov     edi, OFFSET FLAT:.LC13
        xor     eax, eax
        mov     rdx, r13
        call    "printf"
        mov     rdi, QWORD PTR "stdout"[rip]
        call    "fflush"
        mov     ebx, DWORD PTR "n"[rip]
        test    ebx, ebx
        jle     .L99
        lea     rbp, [rbx+rbx*2]
        mov     ecx, OFFSET FLAT:"c"
        sal     rbx, 3
        sal     rbp, 11
        add     rbp, rcx
.L100:
        mov     rdi, rcx
        mov     rdx, rbx
        xor     esi, esi
        call    "memset"
        lea     rcx, [rax+6144]
        cmp     rbp, rcx
        jne     .L100
.L99:
        mov     rsi, r15
        mov     edi, 1
        call    "clock_gettime"
        pxor    xmm0, xmm0
        cvtsi2sd        xmm0, QWORD PTR [rsp+56]
        pxor    xmm1, xmm1
        mulsd   xmm0, QWORD PTR .LC14[rip]
        cvtsi2sd        xmm1, QWORD PTR [rsp+48]
        addsd   xmm0, xmm1
        movsd   QWORD PTR [rsp+8], xmm0
        call    [QWORD PTR [r14+8]]
        mov     rsi, r15
        mov     edi, 1
        call    "clock_gettime"
        pxor    xmm0, xmm0
        pxor    xmm2, xmm2
        mov     r8d, r12d
        pxor    xmm1, xmm1
        mov     rdi, QWORD PTR [rsp+16]
        mov     rcx, r13
        add     r12d, 1
        mov     edx, DWORD PTR "n"[rip]
        mov     esi, OFFSET FLAT:.LC16
        mov     eax, 3
        cvtsi2sd        xmm0, QWORD PTR [rsp+56]
        mulsd   xmm0, QWORD PTR .LC14[rip]
        cvtsi2sd        xmm1, QWORD PTR [rsp+48]
        cvtsi2sd        xmm2, edx
        addsd   xmm0, xmm1
        movapd  xmm1, xmm2
        subsd   xmm0, QWORD PTR [rsp+8]
        addsd   xmm1, xmm2
        mulsd   xmm1, xmm2
        mulsd   xmm1, xmm2
        movsd   xmm2, QWORD PTR "c"[rip+43064]
        divsd   xmm1, xmm0
        divsd   xmm1, QWORD PTR .LC15[rip]
        call    "fprintf"
        cmp     r12d, 6
        je      .L111
        mov     ebx, DWORD PTR "n"[rip]
        jmp     .L103
.L111:
        add     r14, 16
        lea     rax, [rsp+160]
        cmp     rax, r14
        je      .L102
        mov     ebx, DWORD PTR "n"[rip]
        jmp     .L98
.L102:
        add     QWORD PTR [rsp+24], 4
        mov     rax, QWORD PTR [rsp+24]
        cmp     rax, r15
        je      .L104
        mov     ebx, DWORD PTR [rax]
        jmp     .L105
.L104:
        mov     edi, OFFSET FLAT:.LC17
        call    "puts"
        mov     rax, QWORD PTR [rsp+16]
        cmp     QWORD PTR "stdout"[rip], rax
        je      .L106
        mov     rdi, rax
        call    "fclose"
.L106:
        add     rsp, 168
        xor     eax, eax
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        ret
.L91:
        mov     esi, OFFSET FLAT:.LC2
        mov     edi, OFFSET FLAT:.LC1
        mov     ebx, OFFSET FLAT:.LC1
        call    "fopen"
        mov     QWORD PTR [rsp+16], rax
        jmp     .L92
.L110:
        mov     edx, 51
        mov     esi, 1
        mov     edi, OFFSET FLAT:.LC3
        mov     rcx, QWORD PTR "stderr"[rip]
        call    "fwrite"
        mov     rax, QWORD PTR "stdout"[rip]
        mov     QWORD PTR [rsp+16], rax
        jmp     .L94
.LC12:
        .long   -4194304
        .long   1105199103
.LC14:
        .long   -400107883
        .long   1041313291
.LC15:
        .long   0
        .long   1104006501
