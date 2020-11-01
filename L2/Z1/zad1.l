%{
#include <stdio.h>
int lines=0; 
int words=0;
int last_new_line_status=0;
%}

%%
^[[:blank:]]*\n ;
^[[:blank:]]+ ;
[[:blank:]]+$ ;
[[:blank:]]+ printf(" ");
[^[:blank:]|^\n]+ ECHO; last_new_line_status=0; words+=1;
\n ECHO; last_new_line_status=1; lines+=1;
%%

void set_last_line(){
    if(last_new_line_status==0){
        printf("\n");
        lines+=1;
    }
}

int main() {
    yylex();
    set_last_line();
    printf("%d %d", words, lines);
    return 0;
}