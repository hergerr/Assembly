#include <stdio.h>
 
// Deklaracja funkcji które dołączone zostaną
// do programu dopiero na etapie linkowania kodu
extern void cesar(char * str, int len, int key);
 
// Deklaracja zmiennych
char txt[] = "aBcDefGG";
int len = 8;
int key = 4;
 
int main(void)
{
    // Wywołanie funkcji Asemblerowej
    cesar(txt, len, key);
 
    // Wyświetlenie wyniku
    printf("Wynik: %s\n", txt);
 
    return 0;
}