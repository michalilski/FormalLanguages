from utils import display_setup
from sys import stderr

def display_config(pattern, file_name):
    print('Algorithm: FA')
    display_setup(pattern, file_name)

def transition(pattern):
    return None
    
def fa(pattern, file_name):
    display_config(pattern, file_name)
    T = get_prefix_table(pattern)
    i = 0
    try:
        with open(file_name, 'r') as file:
            char = file.read(1)
            while char:
                #fa here
                char = file.read(1)
    
    except:
        stderr.write(f'File {file_name} could not be found. Make sure that your file is in the same directory as scripts.\n')


