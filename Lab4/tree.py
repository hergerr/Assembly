width = int(input('Podaj szerokosc: '))

temp = width

for i in range(width):
	for j in range(temp):
		print('*', end='')
	temp -= 1
	print()
		

temp = 2		
for i in range(width-1):
	for j in range(temp):
		print('*', end='')
	temp+=1
	print()
