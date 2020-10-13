def prepare_alphabet(text):
    pass

def compute_transition_function(pattern, alphabet):
    tf = dict()
    m = len(pattern)
    for q in range(m+1):
        for a in alphabet:
            k = min(m, q+1)
            while not has_end(pattern[:q]+a, pattern[:k]):
                k -= 1
            tf[(q, a)] = k
    return tf, m

    
def finite_automation_matcher(text, tf, m):
    res = []
    n = len(text)
    q = 0
    for i in range(n):
        q = tf[(q,text[i])]
        if q == m:
            res.append(i-m+1)
    return res
            

def has_end(a, b):
    return a[len(a)-len(b):]==b

