.global write_x87_control_register
.global read_x87_control_register
.global read_x87_status_register

.text	
write_x87_control_register:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax	# eax = n
	pushl %eax		
	fldcw (%esp)	# za pomocą adresu szczytu stosu ładujemy n do control word (load control word)
	fwait			# czeka az instrukcja zostanie wykonana
	popl %eax
	leave
	ret	

read_x87_control_register:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %eax
	fstcw (%eax)	# store control word
	fwait
	leave
	ret

read_x87_status_register:
	pushl %ebp
	movl %esp, %ebp
	fstsw %ax	# store status word
	fwait
	leave
	ret
	
