
%{
  #include <math.h>
  #include <stdio.h>
  #include <string>
  #include <iostream>
  #include "converter.h"
  int yylex();
  void yyerror(char const*);
  std::string res = "";
  int p = 1234577;
%}


%token NUM
%token NL
%token LSB 
%token RSB

%left SUB ADD
%left MUL DIV MOD
%right POW       
%precedence NEG

%% 
input:
  | input line
;

line:
  NL {res = "";}
  | exp NL  { 
      printf ("Wynik: %ld\n", convert($1, p));
      std::cout << res << std::endl;
      res = "";
      std::cout << std::endl;
    }
;

exp:
  NUM                {
                      $$ = convert($1, p); 
                      res.append(std::to_string(convert($1, p)));
                      res.append(" ");
                     }
| exp ADD exp        { $$ = convert($1 + $3, p); res.append("+ ");}
| exp SUB exp        { $$ = convert($1 - $3, p); res.append("- ");}
| exp MUL exp        { $$ = convert($1 * $3, p); res.append("* ");}
| exp DIV exp        { $$ = divide($1, $3, p); res.append("/ ");}
| SUB exp %prec NEG  {
                       $$ = convert(-$2, p);
                       res.append(std::to_string(convert(-$2, p)));
                       res.append(" ");
                     }
| exp POW exp        { $$ = power($1, $3, p); res.append("^ ");}
| LSB exp RSB        { 
                       $$ = convert($2, p); 
                       res.append(" ");
                     }
| exp MOD exp        { $$ = convert($1 % $3, p); res.append("% ");}
;
%%

void yyerror(char const* err){
  std::cout << err << std::endl;
}


int main() {
  return yyparse();
}