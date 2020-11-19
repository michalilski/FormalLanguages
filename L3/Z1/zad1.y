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
  bool is_err = 0;
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
      if(!is_err){
        if(res != ""){
          for(std::string::size_type i=0; i<res.size(); ++i){
            if(res[i]=='#'){
              res[i] = '\0';
              if(i>0){
                res[i-1] = '\0';
              }
              if(i>1){
                int j = i-2;
                while(res[j]!=' ' && j>=0){
                  res[j] = '\0';
                  j--;
                }
              }
            }
          }
        }

        std::cout << res << std::endl;
        std::cout << "Wynik: " << convert($1, p) << std::endl;
      }
      std::cout << std::endl;
      res = "";
      is_err = 0;
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
| exp DIV exp        { 
                       if($3 == 0){
                         yyerror("Error: Found divion by 0.");
                       }
                       else{
                         $$ = divide($1, $3, p); res.append("/ ");
                       }
                     }
| SUB exp %prec NEG  {
                       res.append("#");
                       $$ = convert(-$2, p);
                       res.append(std::to_string(convert(-$2, p)));
                       res.append(" ");
                     }
| exp POW exp        { $$ = power($1, $3, p); res.append("^ ");}
| LSB exp RSB        { 
                       $$ = convert($2, p);
                       res.append(" ");
                     }
| exp MOD exp        { 
                       if($3 == 0){
                         yyerror("Error: Found modulo by 0.");
                       }
                       else{
                         $$ = convert($1 % $3, p); res.append("% ");
                       }
                     }
;
%%

void yyerror(char const* err){
  if(err == "syntax error"){
    std::cout << "Blad." << std::endl;
  }
  else{
    std::cout << err << std::endl;
  }
  is_err = 1;
}

int main() {
  return yyparse();
}