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
mov $0, %rax        
mov $format_scanf, %rdi 
mov $integer, %rsi  
mov $float, %rdx    
mov $double, %rcx
push %rbx
call scanf    
pop %rbx
 

movq $0, %rdi
movq $0, %rcx
movq $2, %rax
movq integer(,%rcx, 4), %rdi
movss float, %xmm0
movsd double, %xmm1
call function 
 
 
movq $1, %rax
movq $format_printf, %rdi
sub $8, %rsp
call printf
add $8, %rsp
 
 
mov $0, %rax 
call exit
