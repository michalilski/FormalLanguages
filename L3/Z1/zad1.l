%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "zad1.tab.h"
#define YY_DECL extern int yylex()
%}

%x COM

%%
<INITIAL>\n return NL;

<INITIAL>[0-9]+    {
    yylval = atoi(yytext);
    return NUM;
}

<INITIAL>\+  return ADD;
<INITIAL>\-  return SUB;
<INITIAL>\*  return MUL;
<INITIAL>\/  return DIV;
<INITIAL>\%  return MOD;
<INITIAL>\^  return POW;
<INITIAL>\(  return LSB;
<INITIAL>\)  return RSB;

<INITIAL>\\\n    ;
<INITIAL>[ \t]+    ;
<INITIAL>#     BEGIN(COM);

<COM>.  ;
<COM>\\\n    ;
<COM>\n BEGIN(INITIAL);

<INITIAL>.  ;
%%