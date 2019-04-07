.data
STDIN = 0
STDOUT = 1
SYSWRITE = 1
SYSREAD = 0
SYSEXIT = 60
EXIT_SUCCESS = 0
BUFLEN = 512

.bss
.comm textin, 512
.comm textout, 512

.text
.globl _start
_start:
movq $SYSREAD, %rax
movq $STDIN, %rdi
movq $textin, %rsi
movq $BUFLEN, %rdx
syscall

movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $textin, %rsi
movq $BUFLEN, %rdx

syscall
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
