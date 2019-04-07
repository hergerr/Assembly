.section .data

.section .text

.globl _start
_start:

# rax - wynik mnozenia
# rdx - wartosc najwyzszych bitow do wyzerowania
# rcx - aktualny indeks
# rbx - akumulator
# rdi - liczba z ktorej chcemy policzyc pierwiastek

movq $144, %rdi
movq $0, %rdx
movq $0, %rcx
movq $2, %rax
movq $0, %rdx

loop:
	cmpq %rdi, %rbx 
	je end_loop
	jg end_loop_unpercize
	mulq %rcx #mnozenie indeksu razy 2
	incq %rax #zwiekszenie iloczynu o 1
	addq %rax, %rbx
	incq %rcx
	movq $2, %rax
	jmp loop


end_loop:
movq $1, %rax
movq %rcx, %rbx
int $0x80


end_loop_unpercize:
movq $1, %rax
movq %rcx, %rbx
decq %rbx
int $0x80 # zamienic na syscall
