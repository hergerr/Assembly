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

	movq %rax, %r8 	# ilosc wpisanych znakow
	dec %r8 		#odjecie znaku nowej liii
	movq $0, %r9 	#indeks petli
	loop:
		movb textin(, %r9, 1), %cl	 #wczytaj znak do %cl
		cmp $'0', %cl
		jl fail
		cmp $'9', %cl
		jg fail
		sub $'0', %cl 				#oblicz wartosc cyfry (x-48)
		movb %cl, textin(, %r9, 1) 	#wpisujemy do bufora
		inc %r9 					#zwieksz indeks petli
		cmp %r8, %r9 				#czy juz koniec petli
		jl loop

	movq $0, %rax # w tym rejestrze bedzie wartosc liczby
	movq $0, %r9 #indeks petli
	movq $10, %r10 #mnozymy przez podstawe systemu
	number_value:
		mul %r10
		movb textin(, %r9, 1), %cl
		movzbq %cl, %r15 #przenies bajt do rejestru 4B i uzpel zerami
		add %r15, %rax
		inc %r9 		#zwiekszenie indeksu
		cmp %r8, %r9 	#porownaj z dlugoscia liczby
	jl number_value

	movq $9, %r10 				#podstawa nowego systemu

	conversion:
		movq $0, %rdx 			#zerowanie najstarszych bitow
		div %r10				#dzielenie
		add $'0', %rdx			#konwersja reszty na tekst
		push %rdx				#dodanie reszty na stos
		cmp $0, %rax			#sprawdzenie czy jest koniec petli
	jne conversion	

	movq $0, %r9				#indeks
	
	to_text:
		pop textout(, %r9, 1)	#zapisywanie danych ze stosu w wyjsciu
		inc %r9					#inkrementacja indeksu
		cmp %r8, %r9			#sprawdzenie konca petli
	jle to_text

	movb $'\n', textout(, %r9, 1)
	movq $SYSWRITE, %rax
	movq $STDOUT, %rdi
	movq $textout, %rsi
	movq $BUFLEN, %rdx
	syscall
	
	fail:	
		movq $SYSEXIT, %rax
		movq $1, %rdi
		syscall


