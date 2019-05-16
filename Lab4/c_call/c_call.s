.data
format_scanf: .asciz "%d %f %lf",  # Łańcuchy znaków wykorzystywane do
format_printf: .asciz "%lf \n",  # wywoływania funkcji scanf i printf
 
.bss
.comm integer, 4 
.comm float, 4
.comm double, 8
 
.text
.global main
 
main:
mov $0, %rax            # liczba argumentow zmiennoprzecinkowych 
mov $format_scanf, %rdi # adres stringa formatujacego
mov $integer, %rsi  
mov $float, %rdx    
mov $double, %rcx
push %rbx               # stos musi byc zapelniony (chyba)
call scanf    
pop %rbx
 

movq $0, %rdi
movq $0, %rcx
movq $2, %rax           # liczba arg zmiennoprzec
movq integer(,%rcx, 4), %rdi
movss float, %xmm0      # przekazanie argumentu o poj prez
movsd double, %xmm1     # przekazanie argumentu o pod prez
call function 
 
 
movq $1, %rax               # liczba arg zmniennoprzec
movq $format_printf, %rdi   # string formatujacy
sub $8, %rsp                # workaround
call printf
add $8, %rsp
 
 
mov $0, %rax 
call exit
