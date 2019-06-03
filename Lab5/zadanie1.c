#include <stdio.h>

extern double taylor_arctg(double x);  

int main(int argc, char **argv)
{
	double x;
	
	do
	{
		printf("Podaj x z zakresu [-1.0, 1.0]: ");
		scanf("%lf", &x);
	}
	while (!(x >= -1.0 && x <= 1.0));
	
	printf("arctg(%lf) = %lf\n", x, taylor_arctg(x));	
	
	return 0;
}

