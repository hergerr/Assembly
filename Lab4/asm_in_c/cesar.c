#include <stdio.h>
 
// Deklaracja zmiennej przechowującej ciąg znaków do konwersji
char str[] = "AbCdEfGh";
// Stała przechowująca długość tego ciągu
const int len = 8;
const int key = 1;
 
int main(void)
{
    //
    // Wstawka Asemblerowa
    //
    asm(
    "mov $0, %%rbx \n" // licznik petli 

    "loop: \n" // Etykieta powrotu do pętli
 
    "mov (%0, %%rbx, 1), %%al \n" // Skopiowanie n-tej komórki stringa
    // do rejestru Al. %0 to alias rejestru w którym kompilator C umieści
    // pierwszy parametr wejściowy (wskaźnik na pierwszą komórkę stringa).
 
    "cmp %%al, 'Z' \n"    //Ominiecie wszystkich wielkich liter
    "jle save \n" 
    "add key, %%al \n"


    "save: \n"
    "mov %%al, (%0, %%rbx, 1) \n" // Zapisanie zmienionej wartości do stringa
 
    "inc %%rbx \n"      // Zwiększenie licznika pętli
    "cmp len, %%rbx \n" // Porównanie licznika pętli ze stałą "len"
    "jl loop \n" // Powrót na początek pętli aż do wykonania operacji
 
    : // Brak parametow wyjsciowych
 
    :"r"(&str) // Lista parametrów wejściowych
 
    :"%rax", "%rbx" // Rejestry których będziemy używać w kodzie Asemblerowym.
    );
 
    // Wyświetlenie wyniku
    printf("Wynik: %s\n", str);
    return 0;
}
