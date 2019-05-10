.data

.text
.globl _start
_start:

mov $3, %rax  # Ilość argumentów zmiennoprzecinkowych
              # - przesyłany jest jeden parametr i znajdzie się on
              # w rejestrze XMM0
mov $25, %rsi # Pierwszy parametr - typu całkowitego
mov $, %rdi # Drugi parametr - typu całkowitego
movss liczba, %xmm0 # Trzeci parametr - typu zmiennoprzecinkowego
                    # skopiowany z 4-bajtowej komórki w pamięci
call funkcja        # Wywołanie funkcji
