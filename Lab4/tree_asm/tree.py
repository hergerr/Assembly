width = int(input('Podaj szerokosc: '))


temp = 1

for i in range(width):
	for j in range(temp):
		print('*', end='')
	temp += 1
	print()
		

temp = width-1		
for i in range(width-1):
	for j in range(temp):
		print('*', end='')
	temp-=1
	print()
