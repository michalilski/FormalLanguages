from ply import lex
import ply.yacc as yacc
import sys
import re
from converter import convert, divide

tokens = (
    'ADD',
    'SUB',
    'MUL',
    'DIV',
    'MOD',
    'POW',
    'LSB',
    'RSB',
    'NUM',
    'NL'
)

states = (
    ('comment', 'exclusive'),
)

rpn = ''
base = 1234577

t_ignore = ' \t'

t_ADD = r'\+'
t_SUB = r'\-'
t_MUL = r'\*'
t_DIV = r'\/'
t_MOD = r'\%'
t_POW = r'\^'
t_LSB = r'\('
t_RSB = r'\)'
t_NL = r'\n'

def t_NUM(t):
    r'[0-9]+'
    t.value = int(t.value)
    return t

def t_error(t):
  print("Invalid Token:",t.value[0])
  t.lexer.skip(1)


def t_comment(t):
    r'\#'
    t.lexer.begin('comment')

def t_comment_in(t):
    r'.'
    pass

def t_comment_nl(t):
    r'\\\n'
    pass

def t_comment_end(t):
    r'\n'
    t.lexer.begin('INITIAL')

lexer = lex.lex()

precedence = (
    ('left', 'ADD', 'SUB'),
    ('left', 'MUL', 'DIV', 'MOD'),
    ('right', 'POW'),
    ('nonassoc', 'NEG')
)

def p_input(p):
    '''input : 
        | input line'''
    pass

def p_line(p):
    'line : NL'
    pass

def p_line2(p):
    'line : exp NL'
    global rpn
    temp = list(rpn)
    for i in range(len(temp)):
        if temp[i] == '#':
            temp[i] = ''
            if i > 0:
                temp[i-1] = ''
                j = i-2
                while temp[j]!=' ' and j>=0:
                    temp[j] = ''
                    j-=1

    rpn = ''.join(temp)  
    print(rpn)
    print('Wynik: ',p[1])
    print()
    rpn = ''

def p_num(p):
    'exp : NUM'
    p[0] = convert(p[1], base)
    global rpn 
    rpn += str(p[0]) + " "

def p_add(p):
    'exp : exp ADD exp'
    p[0] = convert(p[1] + p[3], base)
    global rpn 
    rpn += "+ "

def p_sub(p):
    'exp : exp SUB exp'
    p[0] = convert(p[1] - p[3], base)
    global rpn 
    rpn += "- "

def p_usub(p):
    'exp : SUB exp %prec NEG'
    p[0] = convert(-p[2], base)
    global rpn 
    rpn += "#" + str(convert(-p[2], base)) + " "

def p_mul(p):
    'exp : exp MUL exp'
    p[0] = convert(p[1] * p[3], base)
    global rpn 
    rpn += "* "

def p_div(p):
    'exp : exp DIV exp'
    p[0] = convert(divide(p[1], p[3], base), base)
    global rpn 
    rpn += "/ "

def p_brackets(p):
    'exp : LSB exp RSB'
    p[0] = convert(p[2], base)

def p_pow(p):
    'exp : exp POW exp'
    p[0] = convert(p[1]**p[3], base)
    global rpn 
    rpn += "^ "

def p_mod(p):
    'exp : exp MOD exp'
    _, p[0], _ = convert(p[1]%p[3], base)
    global rpn 
    rpn += "% "

def p_error(p):
    print("Syntax error in input!")

parser = yacc.yacc()

inp = ''
for line in sys.stdin:
    inp += line

res = parser.parse(inp)
