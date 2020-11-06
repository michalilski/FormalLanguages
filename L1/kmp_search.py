def compute_prefix_function(pattern):
    m = len(pattern)
    pi = [0]*m
    pi[0] = 0
    k = 0
    for q in range(1, m):
        while k > 0 and pattern[k] != pattern[q]:
            k = pi[k]
        if pattern[k] == pattern[q]:
            k += 1
        pi[q] = k
    return pi
    
def kmp_matcher(text, pattern):
    res = []
    m = len(pattern)
    pi = compute_prefix_function(pattern)
    q = 0
    for i, letter in enumerate(text):
        while q > 0 and pattern[q] != letter:
           q = pi[q-1]
        if pattern[q] == letter:
           q += 1
        if q == m:
           res.append(i-(m-1))
           q = pi[q-1]
    return res 
