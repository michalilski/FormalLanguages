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
    n = len(text)
    m = len(pattern)
    pi = compute_prefix_function(pattern)
    q = 0
    for i in range(n):
        while q > 0 and pattern[q] != text[i]:
           q = pi[q-1]
        if pattern[q] == text[i]:
           q += 1
        if q == m:
           res.append(i-(m-1))
           q = pi[q-1]
    return res 
