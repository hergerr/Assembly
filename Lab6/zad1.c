#include <stdio.h> 

int main()
{
    float a[4] = {1.1, 2.2, 3.3, 4.4};
    float b[4] = {4.4, 3.3, 2.2, 1.1};

    for(int i = 0; i < 4; ++i){
        printf("%f ", a[i]+b[i]);
    }

    return 0;
}