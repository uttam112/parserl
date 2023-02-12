
%{
#include<bits/stdc++.h>
using namespace std;
#include "ass.tab.h"

%}


TITLE "Title:"[^\n]+ 
CHAPTER "Chapter"[^\n]*":"[^\n]+ 
SECTION "Section"[^\n]*":"[^\n]+ 



%%
[ \t\f\r\n"\r\n"]+ {/*eat up white spaces*/}

[ ]        {return SPACE;}
[,]        {return COMMA;}
[;]        {return SEMICOLON;}
{TITLE}    {yylval.str = yytext; return TITLE;}
{CHAPTER}  {yylval.str = yytext; return CHAPTER;}
{SECTION}  {yylval.str = yytext; return SECTION;}
[a-zA-Z]+  {return WORD;}  
[0-9]+[.]?[0-9]+ {return NUMBER;}
[0-9]+ {return NUMBER;}
"." {return FULLSTOP;}
"?" {return QUESTIONMARK;}
"!" {return EXCLAMATION;}


. {}


%%

int yywrap() { }

