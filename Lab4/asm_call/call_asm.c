#include <stdio.h>
 
// Deklaracja funkcji które dołączone zostaną
// do programu dopiero na etapie linkowania kodu
extern void cesar(char * str, int len, int key);
 
// Deklaracja zmiennych
char txt[] = "zbcdZGG";
int len = 8;
int key = 30;
 
int main(void)
{
    // Wywołanie funkcji Asemblerowej
    cesar(txt, len, key);
 
    // Wyświetlenie wyniku
    printf("Wynik: %s\n", txt);
 
    return 0;
}