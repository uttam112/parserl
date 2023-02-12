%{

/*definition*/
#include <stdio.h>
#include<bits/stdc++.h>
using namespace std;
int yylex();
int yyerror(char *s);
extern FILE* yyin;
int num_Chapters = 0;
int num_Sections = 0;
int num_sentence=0;
int num_declarative = 0;
int num_exclamatory = 0;
int num_interrogative = 0;
int num_words=0;
int num_paragraphs = 0;
string s;
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
%token FULLSTOP EXCLAMATION QUESTIONMARK WORD NUMBER BREAK
%%

input:
|     line input
;


line: 
    TITLE   {printf("%s\n",$1);}
|   CHAPTER {s+=string($1) + "\n";num_Chapters++;}
|   SECTION {s+="   "+string($1) + "\n";num_Sections++;}
|   cpara    
|   para_breaker
;


cpara: para {num_paragraphs++;}

para:
        sentences end
    |   sentences end para;

para_breaker:
         BREAK;

sentences:
     word sentences 
   | word
   | seperator sentences

end :
     FULLSTOP  {num_declarative++;}
   | EXCLAMATION {num_exclamatory++;}
   | QUESTIONMARK {num_interrogative++;}

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

num_sentence = num_interrogative + num_declarative + num_exclamatory;

printf("\nNumber of Chapters   : %d\n",num_Chapters);
printf("Number of Sections   : %d\n",num_Sections);
printf("Number of Paragraphs : %d\n",num_paragraphs);
printf("Number of sentences  : %d\n", num_sentence);
printf("Number of Words      : %d\n\n",num_words);
printf("Number of Declarative sentences    : %d\n",num_declarative);
printf("Number of Interrogative sentences  : %d\n",num_interrogative);
printf("Number of Exclamatory sentences    : %d\n",num_exclamatory);

printf("\nTable of Contents:\n\n");
cout<<s<<"\n";
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