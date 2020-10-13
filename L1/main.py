from sys import argv, stderr
from kmp_search import kmp_matcher
from fa_search import finite_automation_matcher, compute_transition_function

def parse_args():
    if(len(argv)!=4):
        stderr.write('Wrong number of arguments was given. There should be: FA/KMP <pattern> <filename>.\n')
        exit(1)
    
    return argv

def main():
    _, search_type, pattern, file_name = parse_args()
    try:
        with open(file_name, 'r') as file:
            text = file.read()
    except:
        stderr.write(f'File {file_name} could not be found.')
        exit(1)

    if(search_type.lower() == 'fa'):
        tf, m = compute_transition_function(pattern, alphabet=''.join(set(text)))
        res = finite_automation_matcher(text, tf, m)
    else:
        res = kmp_matcher(text, pattern)
    
    print('Indices:', end=" ")

    for n in range(len(res)-1):
        print(res[n], end=", ")

    if len(res) > 0:
        print(res[len(res)-1])
    
    print('Total found:', len(res))


if __name__ == "__main__":
    main()