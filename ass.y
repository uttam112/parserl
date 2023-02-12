%{

/*definition*/
#include <stdio.h>
#include<bits/stdc++.h>
using namespace std;
int yylex();
int yyerror(char *s);
extern FILE* yyin;
int num_sentence=0;
int num_words = 0; // ignore title, chapter, section lines also ignore digits and numbers
int num_declarative = 0;
int num_exclamatory = 0;
int num_interrogative = 0;
int num_words=0;
%}

%union {
char* str;
int num ;
char sym;
}


%token<str> TITLE
%token<str> CHAPTER
%token<str> SECTION
%token SPACE COMMA SEMICOLON
%%

input:
|     line input
;


line: 
    TITLE   {printf("%s\n",$1);}
|   CHAPTER {printf("%s\n",$1);}
|   SECTION {printf("   %s\n",$1);}
|   para    
;

para:
        sentences {num_sentence++;}

sentences:
        DECLERATIVE {num_declarative++;}
    |   INTERROGATIVE {num_interrogative++;}
    |   EXCLAMATORY {num_exclamatory++;}





sentences:
     word sentences 
   | word

end :
     FULLSTOP  {num_declarative++;}
   | EXCLAMATION {num_exclamatory++;}
   | QUESTIONMARK {num_exclamatory++;}

word:
    WORD {num_words++;}
 |  NUMBER

seperator:
        COMMA 
    |   SEMICOLON
    |   SPACE
;

%%

int main() {
freopen ("input.txt", "r", stdin);  //a.txt holds the expression
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