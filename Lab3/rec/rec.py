def rec(num):
    if(num == 2):
        return 3
    if(num == 1):
        return 1
    if (num == 0):
        return 2
    else:
        return rec(num-2) - 2*rec(num-3)

for i in range(0,11):
    print(f"Krok {i}: {rec(i)}")