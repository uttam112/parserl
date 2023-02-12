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
int line_num = 1;
string s;
bool flag = false;
extern int yylex();
extern int yyparse();
extern FILE* yyin;
%}

%union {
char* str;

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
         BREAK {line_num++;}

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

freopen("out.txt","w",stdout);
freopen ("input.txt", "r", stdin);  //a.txt holds the expression
yyparse();
if(flag)return 0;
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
flag = true;
cerr<<"ERROR: "<<s<<" at Line Number:" <<line_num<<"\n";
return 0;
}


// flex lexer.l
// bison -t -d parser.y
// g++ lex.yy.c parser.tab.c
// ./a.out