from utils import display_setup
from sys import stderr

def display_config(pattern, file_name):
    print('Algorithm: KMP')
    display_setup(pattern, file_name)

def get_prefix_table(pattern, length):
    T = [0]*length
    T[0] = -1
    k = -1
    offset = 0
    i = 0
    while i < length:
        if pattern[i] == pattern[offset]:
            T[i] = offset
            offset += 1
            i += 1
        else:
            if length != 0:
                length = T[length - 1]
            else:
                T[i] = 0
                i += 1

    return T
    
def kmp(pattern, file_name):
    display_config(pattern, file_name)
    pattern_length = len(pattern)
    T = get_prefix_table(pattern, pattern_length)
    i = 0
    counter = 0
    matches = []
    # try:
    with open(file_name, 'r') as file:
        char = file.read(1)
        while char:
            while i>0 and pattern[i] != char:
                i = T[i-1] + 1
            if pattern[i] == char:
                i += 1
            if i == pattern_length:
                temp = counter - pattern_length + 1
                matches += [temp]
                i = T[i-1] + 1
            char = file.read(1)
            counter += 1
    return matches
# except:
    #     stderr.write(f'File {file_name} could not be found. Make sure that your file is in the same directory as scripts.\n')

    
