%{
#include <stdio.h>
#include <string.h>
int yylex();
int doc_flag=0;
%}

%s comment
%s comment2
%s multilinecomment
%s multilinecomment2
%s string

%%
<INITIAL>\" {ECHO; BEGIN(string);}
<INITIAL>\/\/ {BEGIN(comment);}
<INITIAL>\/\/[\/|!] {
    BEGIN(comment2);
    if(doc_flag){
        ECHO;
    }
}
<INITIAL>\/\* {BEGIN(multilinecomment);}
<INITIAL>\/\*[\*|!] {
    BEGIN(multilinecomment2);
    if(doc_flag){
        ECHO;
    }
}

<string>\\\"    ECHO;
<string>\"  {ECHO; BEGIN(INITIAL);}

<comment>.  ;
<comment>\\\n   ;
<comment>\n BEGIN(INITIAL);

<comment2>.  {
    if(doc_flag){
        ECHO;
    }
};
<comment2>\\\n   {
    if(doc_flag){
        ECHO;
    }
}
<comment2>\n {
    BEGIN(INITIAL);
    if(doc_flag){
        ECHO;
    }
}

<multilinecomment>(.|\n) ;
<multilinecomment>\*\/  BEGIN(INITIAL);

<multilinecomment2>(.|\n) {
    if(doc_flag){
        ECHO;
    }
}
<multilinecomment2>\*\/  {
    BEGIN(INITIAL);
    if(doc_flag){
        ECHO;
    }
}
%%

int main(int argc, char **argv) {
    if(argc > 1){
        if(strcmp(argv[1], "doc")==0){
            doc_flag=1;
        }
    } 
    return yylex(); 
}