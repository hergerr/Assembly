.data

.text
.globl _start
_start:

movq $3, %rax

push %rax
call rec
pop %rax

movq %rax, %rdi
movq $60, %rax
syscall


rec:
push %rbp
movq %rsp, %rbp 	#poprzedni szczyt stosu w rbp
sub $16, %rsp
movq 16(%rbp), %rbx #zadany wyraz do policzenia
movq %rbx, -8(%rbp) #-8(%rbp)=n


#sprawdzenie warunkow koncowych
cmp $2, -8(%rbp)
je is2

cmp $1, -8(%rbp)
je is1

cmp $0, -8(%rbp)
je is0


decq -8(%rbp)
push -8(%rbp)
call rec 	#f(n -1)
pop %rax
movq %rax, -16(%rbp)

decq -8(%rbp)
push -8(%rbp)
call rec
pop %rbx	#f(n-2)
movq %rbx, -16(%rbp)


decq -8(%rbp)
push -8(%rbp)
call rec
pop %rcx	#f(n-3)
imulq $2, %rcx
subq %rcx, -16(%rbp)
movq -16(%rbp), %rcx 
movq %rcx, 16(%rbp)
jmp end

is0:
movq $2, 16(%rbp)
jmp end

is1:
movq $1, 16(%rbp)

is2:
movq $3, 16(%rbp)

end:
mov %rbp , %rsp
pop %rbp
ret
