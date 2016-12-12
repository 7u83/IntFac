import sys


def getbit(i, n):
    return (i >> n) & 1


def setbit(i, n, val=1):
    if val == 1:
        return i | (1 << n)
    return i & (~(1 << n))


def bitcmp(i1, i2, n):
    for i in range(0, n):
        b2 = getbit(i2, i)
        b1 = getbit(i1, i)
        if b1 != b2:
            return b1 - b2
    return 0


def fac_check(i, i1, i2, bits):
    p = i1 * i2
    if p > i:
        return -3
    if p == i:
        if i1 == 1 or i2 == 1:
            return -4
        return 10
    return bitcmp(i, p, bits)


def factorize_run(i, i1, i2, n):
    for b in range(0, 4):
        i1 = setbit(i1, n, getbit(b, 0))
        i2 = setbit(i2, n, getbit(b, 1))
        rc = fac_check(i, i1, i2, n + 1)
        if rc == 10:
            return factorize(i1) + factorize(i2)
        if rc == 0:
            f = factorize_run(i, i1, i2, n + 1)
            if f != [i]:
                return f
    return [i]


def factorize(i):
        l = factorize_run(i, 0, 0, 0)
        l.sort()
        return l

fpr = int(sys.argv[1])

print (("Factorizing " + str(fpr) + " ..."))
rc = factorize(fpr)
print (rc)