#include <stdio.h> 

extern void add_arrays(float *a, float *b, float *c);

int main()
{
    float a[8] = {1.1, 2.2, 3.3, 4.4, 3.3, 3.3, 1.3, 1.3};
    float b[8] = {4.4, 3.3, 2.2, 1.1, 3.3, 3.3, 1.3, 1.3};
    float c[8] = {0};

    add_arrays(a,b,c);

    for(int i = 0; i < 8; ++i){
        printf("%f ", c[i]);
    }
    printf("\n");

    return 0;
}