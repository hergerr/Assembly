string = 'HAHAaaazzz'
key = 30

key = key % 26

output = ''
for i in range(0, len(string)):
	
	# pomieniecie znakow inne niz male litery
	if ord(string[i]) < 97 or ord(string[i]) > 122:
		output += string[i]
		continue
		
	# dodanie liczby klucza
	temp = ord(string[i]) + key
		

	#jesli wydzie dalej niz z, to musi isc modulo
	if temp > 122:
		temp = 96 + (temp % 122)

	output += chr(temp)

print(output)
