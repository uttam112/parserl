
%{
#include "parser.tab.h"


/* sscanf(yytext, "%s", yylval.name) */

%}





%%

[0-9]+ {yylval.num = atoi(yytext); return NUMBER;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLY;}
"/" {return DIVIDE;}
\n {return EOL;}
. {}


%%

int yywrap() { }

