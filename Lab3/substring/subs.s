.data
string: .ascii "xxaaaxxxaxaaa"
len = .-string

.text
.globl _start
_start:

movq $string, %r8
movq $len, %r9
movq $3, %r10

push %r8
push %r9
push %r10
call substring

movq %rax, %rdi
movq $60, %rax
syscall


substring:
push %rbp
movq %rsp, %rbp 	#poprzedni szczyt stosu w rbp
movq 32(%rbp), %r13 #adres stringa
movq 24(%rbp), %r14 #dlugosc stringa
movq 16(%rbp), %r15 #dlugosc podciagu

movq $-1, %rdx #licznik dlugosci stringa
loop:
    movq $0, %rcx   #licznik dlugosci ciagu x
    inc %rdx        #indeks petli
    cmp %rdx, %r14  #jesli dotarlismy do konca to skok
    je end
    movb (%r13, %rdx, 1), %al #zaladowanie znaku
    cmp $'x', %al
    jne loop
    movq %rdx, %r10          
        inner_loop:
            inc %rcx #powiekszenie licznika
            cmp %rcx, %r15      #czy jest juz zadane ilosc x?
            je successful_end
            inc %rdx
            movb (%r13, %rdx, 1), %al #zaladowanie znaku
            cmp $'x', %al
            je inner_loop 
            jne loop


end:
movq $222, %rax
movq %rbp, %rsp
pop %rbp
ret

successful_end:
movq %r10, %rax
movq %rbp, %rsp
pop %rbp
ret
