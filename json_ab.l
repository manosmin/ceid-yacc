%{
        #include "json_ab.tab.h"
        #include <stdio.h>
        #include <stdlib.h>
        #include <string.h>
        char *temp;
        char *stemp;
        int lineNumber = 1;
%}
%option noyywrap
%option yylineno
POSITIVEINTEGER [0-9]|[1-9][0-9]+
POSITIVEREAL ({POSITIVEINTEGER}[.]{POSITIVEINTEGER}+)|({POSITIVEINTEGER})
NUMBERS ({POSITIVEREAL})|([-]{POSITIVEREAL})
BOOLEAN "true"|"false"
STRING ["]([a-z]|[A-Z]|[0-9]|[\/.-:_@#^$<>!,?&*%+=]|[\"])*["]
COMMA [,]
NLINE [\n]
BRACKETLEFT [\[]
BRACKETRIGHT [\]]
JSONARRAY ({BRACKETLEFT}(({STRING}{COMMA})*|({NUMBERS}{COMMA})*)*({STRING}|{NUMBERS}){BRACKETRIGHT})|({BRACKETLEFT}({STRING}|{NUMBERS}){BRACKETRIGHT})|({BRACKETLEFT}{BRACKETRIGHT})
%%
":" {printf("%s", yytext); return (COLON);}
"{" {printf("%s", yytext); return (HOOKLEFT);}
"}" {printf("%s", yytext); return (HOOKRIGHT);}
{BRACKETLEFT} {printf("%s", yytext); return (BRACKETLEFT);}
{BRACKETRIGHT} {printf("%s", yytext); return (BRACKETRIGHT);}
{NLINE} {printf("\n"); lineNumber++;}
{COMMA} {printf("%s", yytext); return (COMMA);}
[0-9] {printf("%s", yytext); return (DIGIT);}
[1] {printf("%s", yytext); return (DIGITONE);}
[0] {printf("%s", yytext); return (DIGITZERO);}
[2-8] {printf("%s", yytext); return(DIGITTWOTOEIGHT);}
{POSITIVEINTEGER} {printf("%s", yytext); return (POSITIVEINTEGER);}
{POSITIVEREAL} {printf("%s", yytext); return (POSITIVEREAL);}
{STRING} {printf("%s", yytext); return (STRING);}
{JSONARRAY} {printf("%s", yytext); return (JSONARRAY);}

