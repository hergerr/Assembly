def f(tab, len2):
    """Tab to ciag znakow, len1 to len(tab), a len2 to dlugosc poszukiwanego ciagu x"""
    counter = 0
    for i in range(0, len(tab)):
        j = i
        while tab[j] == 'x':
            counter += 1
            if counter == len2:
                return i
            j += 1
            if (j == len(tab)):
                return -1 #dojechalismy do konca 
        counter = 0
    return -1

print(f('aaaaaxaaxaaxx', 2))