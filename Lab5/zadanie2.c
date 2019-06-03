#include <stdio.h>

#define INVALID_OPERATION_EXCEPTION_BIT 0x01	//1
#define DENORMAL_OPERAND_EXCEPTION_BIT 0x02		//2
#define ZERO_DIVIDE_EXCEPTION_BIT 0x04			//4
#define OVERFLOW_EXCEPTION_BIT 0x08				//8
#define UNDERFLOW_EXCEPTION_BIT 0x10			//16
#define PRECISION_EXCEPTION_BIT 0x20			//32

extern void write_x87_control_register(unsigned short n);	//zapisywanie do rejestru kontrolnego
extern void read_x87_control_register(unsigned short *n);	//odczytywanie z rejesty kontrolnego
extern unsigned short read_x87_status_register();			//odczyt status word

void print_out_16_bit_value(const char *label, unsigned short n)	// label - nazwa w princie, n wartość wypisana na 16b
{
	int i;
	
	printf("%s:\t", label);
	
	for (i = 15; i >= 0; i--)
	{
		printf("%d", (n & (1 << i)) != 0);	// wyświetlenie pojedynyczy bitów przez and na kazdej pozycji
	}
	
	printf("\n");
}

int main(int argc, char **argv)
{
	unsigned short n;
	double d;
	
	read_x87_control_register(&n);	//wywołanie funkcji z asm
	print_out_16_bit_value("CONTROL REGISTER (WARTOŚĆ PIERWOTNA)", n);	
	
	n &= ~ZERO_DIVIDE_EXCEPTION_BIT;	// zerowanie bitu odpowiedzialnego za dzielenie przez 0
	write_x87_control_register(n);
	read_x87_control_register(&n);
	print_out_16_bit_value("CONTROL REGISTER (WYCZYSZCZONY BIT)", n);

	n |= ZERO_DIVIDE_EXCEPTION_BIT;
	write_x87_control_register(n);
	read_x87_control_register(&n);	
	print_out_16_bit_value("CONTROL REGISTER (USTAWIONY BIT)", n);
	// printf("%lf\n", 2.0/0.0);
	
	n = read_x87_status_register();
	print_out_16_bit_value("STATUS REGISTER (WARTOŚĆ PIERWOTNA)", n);
	
	d = 1.0 / 0.0;
	n = read_x87_status_register();
	print_out_16_bit_value("STATUS REGISTER (PO DZIELENIU PRZEZ 0)", n);

	return 0;
}
