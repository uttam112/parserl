%{

/*definition*/
#include <stdio.h>
int yylex();
int yyerror(char *s);
%}

%union {
int num ;
char sym;
}


%token EOL
%token<num> NUMBER
%type<num> exp
%token PLUS MINUS MULTIPLY DIVIDE
/*rules*/

%%

input:
|     line input
;


line: 
    exp EOL { printf("%d\n",$1);}
|   EOL;


exp: 
    NUMBER { $$ = $1; } 
|   exp PLUS exp { $$ = $1 + $3; }
|   exp MINUS exp { $$ = $1 - $3; }
|   exp MULTIPLY exp { $$ = $1 * $3; }
|   exp DIVIDE exp { $$ = $1 / $3; } 
;

%%

int main() {
 yyparse();
 return 0;
}

int yyerror(char* s){
printf("ERROR: %s\n",s);
return 0;
}


// flex lexer.l
// bison -t -d parser.y
// g++ lex.yy.c parser.tab.c
// ./a.out