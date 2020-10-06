from sys import argv, stderr
from kmp_search import kmp
from fa_search import fa

def parse_args():
    if(len(argv)!=4):
        stderr.write('Wrong number of arguments was given. There should be: FA/KMP <pattern> <filename>.\n')
        exit(1)
    
    return argv

def main():
    _, search_type, pattern, file_name = parse_args()
    if(search_type.lower() == 'fa'):
        print('Found:', fa(pattern, file_name))
    else:
        print('Found:', kmp(pattern, file_name))

if __name__ == "__main__":
    main()