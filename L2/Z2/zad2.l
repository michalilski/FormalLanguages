%{
#include <stdio.h>
int yylex();
%}

%s single_line_double_quote_string
%s single_line_single_quote_string
%s double_line_double_quote_string
%s double_line_single_quote_string

%%
<INITIAL>#.* ;
<INITIAL>\" ECHO; BEGIN(single_line_double_quote_string);
<INITIAL>\' ECHO; BEGIN(single_line_single_quote_string);
<INITIAL>\"\"\" ECHO; BEGIN(double_line_double_quote_string);
<INITIAL>\'\'\' ECHO; BEGIN(double_line_single_quote_string);

<single_line_double_quote_string>\\\" ECHO;
<single_line_double_quote_string>\"  { ECHO; BEGIN(INITIAL); }
<single_line_double_quote_string>\\\' ECHO;
<single_line_single_quote_string>\'  { ECHO; BEGIN(INITIAL); }
<double_line_double_quote_string>\"\"\" { ECHO; BEGIN(INITIAL); }
<double_line_double_quote_string>\\\" ECHO;
<double_line_single_quote_string>\'\'\' { ECHO; BEGIN(INITIAL); }
<double_line_single_quote_string>\\\' ECHO;
%%

int main() { 
    return yylex(); 
}