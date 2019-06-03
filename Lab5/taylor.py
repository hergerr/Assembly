def taylor_arctg(x):
    result = x
    n = 3.0
    sign = -1.0

    for i in range(100):
        result =  result + sign * (x ** n / n)
        n += 2.0
        sign = -sign

    return result

#----------------------------------------------

def power(x, n):
    result = x
    i = n

    while i > 1:
        result *= x
        i -= 1

    return result