.global write_x87_control_register

.data
EXIT = 60
EXIT_SUCCESS = 0

value1:
.float 1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8
value2:
.float 1.1, 2.2, 3.3, 4.4, 1.1, 2.2, 3.3, 4.4
.bss
.comm arr, 512

.text
.globl _start
_start:
mov $0, %rax
loop:
    movups value1(, %rax, 8), %xmm0
    movups value2(, %rax, 8), %xmm1
    addps %xmm1, %xmm0
    movups %xmm0, arr(,%rax, 8)
    inc %rax
    cmp $4, %rax
jne loop

movq $EXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall

