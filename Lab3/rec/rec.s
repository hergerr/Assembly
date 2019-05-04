.data
STDOUT = 1
SYSWRITE = 1
SYSEXIT = 60
EXIT_SUCCESS = 0

.text
.globl _start
_start:


movq $10, %r12
call upper
movq %r8, %rdx

movq $SYSEXIT, %rax
movq %rdx, %rdi
syscall


upper:			#funkcja kontrolujaca czy pojawil sie juz znany wyraz
push %rbp
movq %rsp, %rbp		#prolog funkcji
sub $16, %rsp		#miejsce na zmienne lokalne
mov %r12, -8(%rbp)	#w r12 nr wyrazu
mov %r10, -16(%rbp)	#r10 trzyma wartosc poprzedniego wyrazu

cmp $2, %r12	#jesli jest 2gi wyraz to skok do znanych wartosci
jle results


rek:
sub $2, %r12	#odjecie 2 od numeru wyrazu
call upper		#wywoloanie funkcji kontrolujacej
movq %r8, %r10	#w r8 jest wynik

dec %r12		#pomniejszenie numeru wyrazi
call upper		#kontrola czy znany jest ten wyraz
imulq $2, %r8	#pomnozenie razy 2, wynik w r8

sub %r8, %r10	#odjecie n-2 i n-3 wyrazu
movq %r10, %r8	#zapisujemy to jako wynik
jmp exit


results:	#znane wartosci funkcji
cmp $0, %r12
je zero

cmp $1, %r12
je one

movq $3, %r8
jmp exit

zero:
movq $2, %r8
jmp exit

one:
movq $1, %r8

exit:
mov -8(%rbp), %r12
mov -16(%rbp), %r10
movq %rbp, %rsp
pop %rbp
ret
