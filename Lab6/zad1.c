#define SIZE 32
#include<stdio.h>

extern int time_asm();
extern void add_arrays(float *a, float *b, float *c);

void c_add_arrays(float *a, float *b, float *c){
    for (int i = 0; i < SIZE; i++)
    {
        c[i] = a[i] + b[i];
    }
    
}

void print(float *c){
    for(int i = 0; i < SIZE; ++i){
        printf("%f ", c[i]);
    }
    printf("\n\n");
}



int main()
{
    float a[SIZE] = {1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3, 1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3, 1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3,1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3};
    float b[SIZE] = {1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3, 1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3, 1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3,1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3};
    float c[SIZE] = {0};
    float d[SIZE] = {0};

    int t1 = time_asm();
    add_arrays(a,b,c);
    int t2 = time_asm();
    
    print(c);
    printf("ASM: %d \n", t2-t1);

    t1 = time_asm();
    c_add_arrays(a,b,d);
    t2 = time_asm();
    
    print(d);
    printf("C: %d \n", t2-t1);

    return 0;

    return 0;
}