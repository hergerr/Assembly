.data
.text
.global add_arrays
.global time_asm
.type add_arrays, @function
.type time_asm, @function

add_arrays:
    push %rbp
    mov %rsp, %rbp
    mov $0, %rax
        loop:
            # W rejestrze RDI znajdzie się wskaźnik na tablice a.
            # W rejestrze RSI znajdzie się wskaznik na tablice b.
           	# W rejestrze RDX znajdzie sie wskaznik na tablice c

            movups (%rdi, %rax, 8), %xmm0
            movups (%rsi, %rax, 8), %xmm1
            addps %xmm1, %xmm0
            movups %xmm0, (%rdx,%rax, 8)
            inc %rax
            cmp $16, %rax
        jne loop
    leave
    ret

time_asm:
push %rbp
mov %rsp, %rbp
    mov $0, %rax
    mov $0, %rdx
    rdtsc       # licznik  w rdx:rax, rdx nie zdąży sie wypełnic
leave
ret
