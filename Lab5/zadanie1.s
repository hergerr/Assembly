.global taylor_arctg # eksport symbolu z C

.data
	# stałe które będą ładowane na stos
	TWO: .double 2.0
	THREE: .double 3.0
	MINUS_ONE: .double -1.0	
	
	# zmienne
	result: .double 0.0
	x: .double 0.0
	n: .double 0.0
	sign: .double 0.0
	i: .long 0

.text	
# double taylor_arctg(double x)
taylor_arctg:
	pushl %ebp
	movl %esp, %ebp
	
	# x = parametr_funkcji
	fldl 8(%ebp)	# pierwszy parametr ładowany do zmiennej x
	fstpl x
	
	# result = x, dlatego pierwszy pierwszy znak wyrazu to -
	fldl x
	fstpl result
	
	# n = 3.0
	fldl THREE
	fstpl n
	
	# sign = -1.0
	fldl MINUS_ONE
	fstpl sign

	# i = 0	
	mov $0, %ecx
.taylor_arctg_loop:
	# i++
	inc %ecx
	
	# st(0) = x**n
	pushl %ecx		# pow korzysta z ecx
	pushl n + 4
	pushl n
	pushl x + 4
	pushl x			# dzielenie kazdej zmiennej na czesci 32b
	call power
	addl $16, %esp
	popl %ecx		# przywrócenie ecx
	
	# st(0) *= sign, ustawienie znaku n-tego wyrazu
	fmull sign	
	
	# st(0) /= n, podzielenie przez n
	fdivl n		
	
	# st(0) + result, razem z 64 to instrukcja +=
	faddl result	
	
	# result = st(0)
	fstpl result	
	
	# n += 2.0
	fldl n
	fldl TWO
	faddp %st(0), %st(1)
	fstpl n	# ściągnięcie st(0) do n (operandu w pamięci)
	
	# sign = -sign
	fldl sign
	fchs	# change sign st(0)
	fstpl sign
	
	# if (i < 100) goto .taylor_arctg_loop
	cmpl $100, %ecx
	jl .taylor_arctg_loop
	
	# return result;
	fldl result	# rezultat na szcycie stosu
	leave	# przywrócenie ramki stosu
	ret

# double power(double x, double n)
power:
	pushl %ebp
	mov %esp, %ebp
	
	# i = (int)n
	fldl 16(%ebp)	# drugi parametr
	fistpl i		# przypisania z konwersją na int (tutaj tryb zaokrąglania nieistony, n jest naturalne)
	
	# ecx = i
	movl (i), %ecx	# skopiowanie wartości z i do ecx
	
	# st(0) = x
	fldl 8(%ebp)	# załadowanie x na szczyt fpu st(0)
.power_loop:
	# ecx--
	dec %ecx
	
	# st(0) *= x
	fmull 8(%ebp)

	# if (ecx != 1) goto .power_loop
	cmpl $1, %ecx
	jne .power_loop

	leave
	ret
