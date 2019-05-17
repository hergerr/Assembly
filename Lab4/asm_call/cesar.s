.data
 
.text
# Zadeklarowane tutaj funkcje będą możliwe do wykorzystania
# w języku C po zlinkowaniu plików wynikowych kompilacji obu kodów
.global cesar
.type cesar, @function
 

# Deklaracja w C: szyfr_cezara(&txt, len, key);
cesar:
    # Odłożenie rejestru bazowego na stos i skopiwanie obecnej
    # wartości wskaźnika stosu do rejestru bazowego
    push %rbp
    mov %rsp, %rbp
 
    # W rejestrze RDI znajdzie się wskaźnik na pierwszą komórkę stringa.
    # W rejestrze RSI znajdzie się długość tego stringa.
	# W rejestrze RDX znajdzie sie klucz do szyfru

    # indeks
    mov $0, %rax
	
	# liczenie modulo klucza, wynik nadal w RDX
	movq $26, %r11
	idivq %r11

	loop:
		mov (%rdi, %rax, 1), %bl
		cmp 'z', %bl
		jg skip_char
		cmp 'a', %bl
		jl skip_char

		# dodanie klucza z rdx do znaku w rbx
		add %dl, %bl 
		# nowy znak juz gotowy
	
		# cmp 'z', %bl
		# jle skip_char
		
		# idivq $122  
		
		skip_char:
    	mov %bl, (%rdi, %rax, 1)

	inc %rax
	cmp %rax, %rsi
	je loop


    mov %rbp, %rsp
    pop %rbp
ret

