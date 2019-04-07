.data
STDIN=0
STDOUT=1
SYSREAD=0
SYSWRITE=1
SYSOPEN=2
SYSCLOSE=3
FREAD=0
FWRITE=01101 	#(01 zapis, 100 utworzenie pliku, 1000 nadpisanie)
SYSEXIT=60
EXIT_SUCCESS=0
CREATE_WRITE = 0666
file_in1: .ascii "1.txt\0"
file_in2: .ascii "2.txt\0"
file_out: .ascii "out.txt\0"

.bss
.comm in1, 1024 		#bufor przechowuje dane ascii z pliku 1
.comm in2, 1024 		#bufor przechowuje dane z pliku 2
.comm value1, 256  		#wartosc 1
.comm value2, 256  		#wartosc 2
.comm out, 1024 		#bufor przechowujacy wynik
.comm sum, 256 			#bufor sumy
.comm numberout, 256 	#bufor wyjscia



.text
.globl _start
_start:

movq $0, %rax
zero_buffers:
movq $0, value1(,%rax,1)	#zeruje value 1 i 2
movq $0, value2(,%rax,1)
inc %rax
cmp $256, %rax
jl zero_buffers


movq $0, %rax
zero_buffers2:
movq $0, sum(,%rax,1)	#zeruje sum
inc %rax
cmp $512, %rax
jl zero_buffers2

#wczytanie pierwszej liczby
movq $SYSOPEN, %rax
movq $file_in1, %rdi
movq $FREAD, %rsi
movq $0, %rdx
syscall
movq %rax, %r8  #kopia uchwytu do pliku

movq $SYSREAD, %rax
movq %r8, %rdi
movq $in1, %rsi
movq $1024, %rdx
syscall
mov %rax, %r9   #r9 liczba odczytanych danych

#zamkniecie pliku
movq $SYSCLOSE, %rax
movq %r8, %rdi
movq $0, %rsi
movq $0, %rdx
syscall


dec %r9 				#pomijam koniec lini
movq $-1, %r10  		#licznik od poczatku

save1:
dec %r9
inc %r10

						#zdekodownie 2 pierwszych bitow
movb in1(, %r9,1), %al  #wczytanie ascii
sub $'0',%al  			#dekodowanie
cmp $0, %r9  			#jezeli nie ma nic wiecej to idz do saveA
jle saveA

						#kolejne 2 bity
dec %r9
movb in1(,%r9,1), %bl  	#wczytanie ascii
sub $'0', %bl 			#odejmuje ascii
shl $2, %bl   			#przesuwam do przodu, uzupelniam najmlodsze 0 
add %bl, %al  			#dodaje do wyniku
cmp $0, %r9				#jezeli nie ma nic wiecej to idz do saveA
jle saveA

						#kolejne 2 bity
dec %r9
movb in1(,%r9,1), %bl  	#wczytanie ascii
sub $'0', %bl 			#odejmuje ascii
shl $4, %bl   			#przesuwam do przodu, uzupelniam najmlodsze 0
add %bl, %al  			#dodaje do wyniku
cmp $0, %r9				#jezeli nie ma nic wiecej to idz do saveA
jle saveA

						#kolejne 2 bity
dec %r9
movb in1(,%r9,1), %bl  	#wczytanie ascii
sub $'0', %bl 			#odejmuje ascii
shl $6, %bl   			#przesuwam do przodu, uzupelniam najmlodsze 0
add %bl, %al  			#dodaje do wyniku
cmp $0, %r9				#jezeli nie ma nic wiecej to idz do saveA
jle saveA

saveA:
movb %al, value1(,%r10,1)  #zapis do bufora tego co jest w zsumowane al
cmp $0, %r9		#jesli jest jeszcze cos do wczytania to wczytuj
jg save1



liczba2:				#wczytanie drugiej liczby
movq $SYSOPEN, %rax		#wszytko analogiczne do wczytywania pierwszej
movq $file_in2, %rdi
movq $FREAD, %rsi
movq $0, %rdx
syscall
movq %rax, %r8  

movq $SYSREAD, %rax
movq %r8, %rdi
movq $in1, %rsi
movq $1024, %rdx
syscall
mov %rax, %r9   

movq $SYSCLOSE, %rax
movq %r8, %rdi
movq $0, %rsi
movq $0, %rdx
syscall

dec %r9 #pomijam koniec lini
movq $-1, %r11  #licznik od poczatku

save2:
dec %r9
inc %r11

movb in1(, %r9,1), %al
sub $'0',%al  
cmp $0, %r9  
jle saveB

dec %r9
movb in1(,%r9,1), %bl  
sub $'0', %bl 
shl $2, %bl   
add %bl, %al  
cmp $0, %r9
jle saveB

dec %r9
movb in1(,%r9,1), %bl
sub $'0', %bl 
shl $4, %bl   
add %bl, %al  
cmp $0, %r9
jle saveB

dec %r9
movb in1(,%r9,1), %bl  
sub $'0', %bl 
shl $6, %bl   
add %bl, %al  
cmp $0, %r9
jle saveB

saveB:
movb %al, value2(,%r11,1)  
cmp $0, %r9
jg save2

					#pierwsze dodawanie bez uwzglednienia korekty
movq $0, %rdi			#zerowanie indexu
movq $0, %r9			#licznik dotarcia do konca bufora sumy
movq value1(,%rdi,8) , %rax	#wrzucenie wartosci z bufora do rejestrow
movq value2(,%rdi,8) , %rbx
add %rbx, %rax			#dodanie rejestrow
pushf					#zapamietanie przeniesienia
	add_carry :
	movq %rax, sum(,%rdi, 8)	#zapisasnie sumy w buforze
	inc %rdi					#zwiekszenie indeksu
	addq $8, %r9
	movq value1(,%rdi,8) , %rax	#zapis kolejnego bajtu z bufora
	movq value2(,%rdi,8) , %rbx	
	popf			#zwolnienie ze stosu flagi przeniesienia
	adc %rbx, %rax	#dodanie z przeniesieniem
	pushf			#zapamietanie przeniesienia
	cmp $256, %r9	#sprawdzenie czy to koniec bufora sumy
	jne add_carry
popf
adc $0, %rax	#dodanie flagi przeniesienia
cmp $0, %rax	#jesli ostatnie dodawanie dalo 0 to konczymy		
je no_carry
movb $1 , sum( , %rdi , 8) #jesli byla jakas korekta to dodajemy ja
inc %rdi

no_carry:

				#konwersja na osemkowy
imul $8, %rdi 	#tyle bajtow zapisalismy
movq $0, %r14   #licznik, by czytac bajty z bufora result
movq $0, %r15 	#licznik, by pisac kolejne cyfry osemkowe
convert:

	cmp $0, %rdi 	#czy sczytane wszystkie bajty
	jle end 		#koniec konwersji
					#trzy kolejne bajty
	movq $0, %rbx
	movq $0, %rcx
	movq $0, %rdx
	movb sum(, %r14, 1), %bl
	inc %r14
	dec %rdi #liczba pozostalych bajtow do wczytania
	movb sum(, %r14, 1), %cl
	shl $8, %rcx #przesuniecie o 8
	inc %r14
	dec %rdi
	movb sum(, %r14, 1), %dl
	shlq $16, %rdx #przesuniecie o 16
	inc %r14
	dec %rdi
	or %rbx, %rcx #zlaczenie wartosci w jednym rejestrze
	or %rcx, %rdx #w rdx pakiet 3B=24b do konwersji

	movq $0, %r11 #petla musi sie obrocic 24/3 = 8 razy (8 cyfr osemkowych)
	convert_three_bytes:
		movb %dl, %cl #kopia fragmentu rejestru dl
		andb $0x7, %cl #wyluskanie najmlodszych 3 bitow (wartosc cyfry osemkowa)
		addb $'0', %cl #wartosc ASCII
		push %rcx #wrzuc na stos, poniewaz musimy odwrocic kolejnosc
		shrq $3, %rdx #przesuwamy kolejne 3 bity
		inc %r11
		inc %r15
		cmp $8, %r11
	jl convert_three_bytes

jmp convert

end:
	movq $0, %r13
	movq %r15, %r14

	#przywracamy wlasciwa kolejnosc, sciagajac kolejno ze stosu
	loop:
		pop %rcx
		movb %cl, numberout(, %r13, 1)
		inc %r13
		dec %r14
		cmp $0, %r14
	jg loop

movq $SYSOPEN, %rax
movq $file_out, %rdi
movq $FWRITE, %rsi
movq $0644, %rdx
syscall
movq %rax, %r8  #uchwyt pliku

movq $SYSWRITE, %rax
movq  %r8, %rdi
movq $sum, %rsi
movq %r10, %rdx
syscall

#zamkniecie pliku
movq $SYSCLOSE, %rax
movq %r8, %rdi
movq $0, %rsi
movq $0, %rdx
syscall

koniec:
movq $SYSEXIT, %rax
movq $EXIT_SUCCESS, %rdi
syscall
