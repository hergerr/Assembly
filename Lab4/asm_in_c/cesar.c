#include <stdio.h>
 
// Deklaracja zmiennej przechowującej ciąg znaków do konwersji
char str[] = "ALAmaKOTAnieMApsa";
// Stała przechowująca długość tego ciągu
int len = 8;
int key = 30;
 
int main(void)
{
    asm(
    // W rejestrze RDI znajdzie się wskaźnik na pierwszą komórkę stringa.
	// W rejestrze RDX znajdzie sie klucz do szyfru
    "mov %0, %%rdi \n"
    "mov key, %%rdx \n"

    // // indeks
	"mov %%rdx, %%rax \n"
	"mov $0, %%rdx \n"
	
	// // liczenie modulo klucza, wynik nadal w RDX
	"mov $26, %%r11 \n"
	"idiv %%r11 \n" 

    "mov $0, %%rax \n"


	"loop: \n"
		"mov (%%rdi, %%rax, 1), %%bl \n"
		"cmp $'z', %%bl \n"
		"jg skip_char \n"
		"cmp $'a', %%bl \n"
		"jl skip_char \n"

		// dodanie klucza z rdx do znaku w rbx
		"add %%dl, %%bl \n" 
		// nowy znak juz gotowy

		// sprawdzenie czy nie wyszlismy poza zakres malych liter
		"cmp $122, %%bl \n"
		"jle skip_char \n"
		"sub $26, %%rbx \n"

		"skip_char: \n"
    	"mov %%bl, (%%rdi, %%rax, 1) \n"

	"inc %%rax \n"

	// rozwiazanie bez licznika :)
	"cmp $999, %%rax \n"
	"jne loop \n"

	:

	// Lista parametrów wejściowych - są one dostępne jako aliasy na rejestry - %0, %1, %2
    :"r"(&str)
 
	// Rejestry których będziemy używać w kodzie Asemblerowym.
    :"%rax", "%rbx", "%rdi", "%rsi", "%rdx", "%r11" 
    );
 
    printf("Wynik: %s\n", str);
    return 0;
}