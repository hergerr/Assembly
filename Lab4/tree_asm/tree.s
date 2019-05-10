.data
SYSREAD = 0
SYSWRITE = 1
SYSEXIT = 60
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
WIDTH = 5

buf: .ascii "abcdefghijasdidasjiodjqwiojwo"
buf_len = .-buf

buf2: .ascii "\n"
buf_len2 = .-buf2

buf3: .ascii "x"
buf_len3 = .-buf3


.text
.globl _start

_start:
movq $0, %r8
movq $0, %rbx	#licznik
movq $WIDTH, %r12 #zadana szerokosc
movq $1, %r13 #zmienna temp z pythona
movq $0, %r14 #index i
movq $0, %r15 #index j

outer_loop:
	cmp %r12, %r14
	je second_part
	inc %r14		

		inner_loop:
		cmp %r13, %r15
		je outer_loop_end

		movb buf(,%rbx,1), %al
		movb %al, buf3(,%r8,1)
		movq $buf3, %r10	#adres buf3
		push %r10		
		call print
		inc %rbx
		inc %r15
		jmp inner_loop
	
	outer_loop_end:
	call print_line
	movq $0, %r15
	inc %r13
	jmp outer_loop



second_part:

movq $WIDTH, %r13		#zmienna temp z pythona
dec %r13
movq $WIDTH, %r12
dec %r12
movq $0, %r14 #index i
movq $0, %r15 #index j

outer_loop2:
	cmp %r12, %r14
	je third_part
	inc %r14		

		inner_loop2:
		cmp %r13, %r15
		je outer_loop_end2

		movb buf(,%rbx,1), %al
		movb %al, buf3(,%r8,1)
		movq $buf3, %r10	#adres buf3
		push %r10
		call print
		inc %rbx		
		inc %r15
		jmp inner_loop2
	
	outer_loop_end2:
	call print_line
	movq $0, %r15
	dec %r13
	jmp outer_loop2


third_part:
movq $0, %rdi
movq $60, %rax
syscall

print:
push %rbp
movq %rsp, %rbp 	#poprzedni szczyt
movq 16(%rbp), %rcx	#adres bufora

movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq %rcx, %rsi
movq $buf_len, %rdx
syscall

mov %rbp , %rsp
pop %rbp
ret


print_line:
push %rbp
movq %rsp, %rbp 	#poprzedni szczyt

movq $SYSWRITE, %rax
movq $STDOUT, %rdi
movq $buf2, %rsi
movq $buf_len2, %rdx
syscall

mov %rbp , %rsp
pop %rbp
ret
