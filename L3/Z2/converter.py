def convert(value, base):
    mod = value % base
    if mod < 0:
        mod += base
    return mod

def divide(a, b, p):
    gcd, x, y = gcd_extended(p,b)
    y = convert(y, p)
    return convert(y*a, p)

def gcd_extended(a, b):
    if a == 0:
        return (b, 0, 1)
    else:
        gcd, x, y = gcd_extended(b % a, a)
        return gcd, y - (b//a) * x, x
