%{
#define MAX_SIZE 1024
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex();
int stack[MAX_SIZE];
int stack_pointer = -1;

int power(int a, int b){
    int res = 1;
    for(int i=0; i<b; i++){
        res*=a;
    }
    return res;
}
%}

%%
[^0-9|^\-|^+|^*|^\/|^%|^\^|^ ] {
    fprintf(stderr, "Błąd - niedozwolony znak \"%s\"\n", yytext);
    exit(1);
}
-[0-9]+   {
    if(stack_pointer == MAX_SIZE-1){
        fprintf(stderr, "Błąd - przekroczono limit stosu.\n");
        exit(1);
    }
    stack_pointer += 1;
    stack[stack_pointer] = atoi(yytext);
}
[0-9]+    {
    if(stack_pointer == MAX_SIZE-1){
        fprintf(stderr, "Błąd - przekroczono limit stosu.\n");
        exit(1);
    }
    stack_pointer += 1;
    stack[stack_pointer] = atoi(yytext);
}
"+"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    stack[stack_pointer-1] = stack[stack_pointer-1] + stack[stack_pointer];
    stack_pointer -= 1;
}
"*"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    stack[stack_pointer-1] = stack[stack_pointer-1] * stack[stack_pointer];
    stack_pointer -= 1;
}
"-"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    stack[stack_pointer-1] = stack[stack_pointer-1] - stack[stack_pointer];
    stack_pointer -= 1;
}
"/"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    if(stack[stack_pointer] == 0){
        fprintf(stderr, "Błąd - wykryto dzielenie przez 0.\n");
        exit(1);
    }
    stack[stack_pointer-1] = stack[stack_pointer-1] / stack[stack_pointer];
    stack_pointer -= 1;
}
"%"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    if(stack[stack_pointer] == 0){
        fprintf(stderr, "Błąd - wykryto obliczanie reszty z dzielenia przez 0.\n");
        exit(1);
    }
    stack[stack_pointer-1] = stack[stack_pointer-1] % stack[stack_pointer];
    stack_pointer -= 1;
}
"^"  {
    if(stack_pointer == 0){
        fprintf(stderr, "Błąd - za mała liczba argumentów.\n");
        exit(1);
    }
    stack[stack_pointer-1] = power(stack[stack_pointer-1],stack[stack_pointer]);
    stack_pointer -= 1;
}
" " ;
%%



void print_stack(){
    int i = 0;
    for(int i=0; i<stack_pointer; i++){
        printf("%d ", stack[i]);
    }
    printf("\n");
}

int main(int argc, char **argv) {
    yylex();
    if(stack_pointer != 0){
        fprintf(stderr, "Błąd - za mała liczba operatorów.\n");
        exit(1);
    }
    printf("= %d\n", stack[stack_pointer]);
    return 0;
}