%{
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    int errorCount = 0;
    extern int lineNumber;
    int yylex();
    void yyerror(char *);
    extern FILE *yyin;
    extern FILE *yyout;
%}
%start STARTOBJECT
%token POSITIVEREAL
%token POSITIVEINTEGER
%token STRING
%token JSONARRAY
%token COMMA
%token COLON
%token BOOLEAN
%token DIGIT
%token DIGITZERO
%token DIGITTWOTOEIGHT
%token DIGITONE
%token HOOKLEFT
%token BRACKETLEFT
%token HOOKRIGHT
%token BRACKETRIGHT
%%
STARTOBJECT: HOOKLEFT ElemLast COMMA ElemActive HOOKRIGHT | HOOKLEFT ElemContent COMMA ElemTotalPages COMMA ElemTotalElements COMMA ElemLastBool COMMA ElemNumberOfElements COMMA ElemSort COMMA ElemFirst COMMA ElemSize COMMA ElemNumber HOOKRIGHT ;
ElemContent : STRING COLON BRACKETLEFT ElemContentExpandEXISTS BRACKETRIGHT;
ElemContentExpandEXISTS: | ElemContentExpand COMMAEXISTS ElemContentExpandEXISTS;
ElemContentExpand:  HOOKLEFT ElemGameId COMMA ElemDrawId COMMA ElemDrawTime COMMA ElemStatus COMMA ElemDrawBreak COMMA ElemVisualDraw COMMA ElemPricePoints COMMA ElemWinningNumbers COMMA ElemPrizeCategories ElemWagerStatisticsEXISTS HOOKRIGHT;
ElemWagerStatisticsEXISTS: | COMMA ElemWagerStatistics;
ElemLast: STRING COLON HOOKLEFT ElemGameId COMMA ElemDrawId COMMA ElemDrawTime COMMA ElemStatus COMMA ElemDrawBreak COMMA ElemVisualDraw COMMA ElemPricePoints COMMA ElemWinningNumbers COMMA ElemPrizeCategories ElemWagerStatisticsEXISTS HOOKRIGHT;
ElemWinningNumbers : STRING COLON HOOKLEFT STRING COLON ElemList COMMA STRING COLON ElemBonus HOOKRIGHT;
COMMAEXISTS: | COMMA;
AST2: | TYPEOFNUM COMMAEXISTS AST2;
TYPEOFNUM: POSITIVEINTEGER | DIGIT ;
ElemList : BRACKETLEFT AST2 BRACKETRIGHT;
ElemBonus : BRACKETLEFT TYPEOFNUM BRACKETRIGHT;
ElemActive : STRING COLON HOOKLEFT ElemGameId COMMA ElemDrawId COMMA ElemDrawTime COMMA ElemStatus COMMA ElemDrawBreak COMMA ElemVisualDraw COMMA ElemPricePoints COMMA ElemPrizeCategories ElemWagerStatisticsEXISTS HOOKRIGHT;
ElemGameId : STRING COLON POSITIVEINTEGER;
ElemDrawId : STRING COLON POSITIVEINTEGER;
ElemDrawTime : STRING COLON POSITIVEINTEGER;
ElemStatus : STRING COLON STRING;
ElemDrawBreak : STRING COLON POSITIVEINTEGER;
ElemVisualDraw : STRING COLON POSITIVEINTEGER;
ElemPricePoints : STRING COLON HOOKLEFT STRING COLON POSITIVEREAL HOOKRIGHT;
AST1: | COMMAEXISTS ElemTempObj1 AST1 | ElemTempObj2 AST1 ;
ElemPrizeCategories : STRING COLON BRACKETLEFT AST1 BRACKETRIGHT;
ElemTempObj1 : HOOKLEFT ElemId1 COMMA ElemDivident COMMA ElemWinners COMMA ElemDistributed COMMA ElemJackpot COMMA ElemFixed COMMA ElemCategoryType COMMA ElemGameType HOOKRIGHT;
ElemMinDistEXISTS: | COMMA ElemMinDist;
ElemTempObj2 : HOOKLEFT ElemId2 COMMA ElemDivident COMMA ElemWinners COMMA ElemDistributed COMMA ElemJackpot COMMA ElemFixed COMMA ElemCategoryType COMMA ElemGameType ElemMinDistEXISTS HOOKRIGHT;
ElemId1 : STRING COLON DIGIT;
ElemId2 : STRING COLON DIGIT;
ElemDivident : STRING COLON POSITIVEREAL;
ElemWinners : STRING COLON TYPEOFNUM;
ElemDistributed : STRING COLON POSITIVEREAL;
ElemJackpot : STRING COLON POSITIVEREAL;
ElemFixed : STRING COLON POSITIVEREAL;
ElemCategoryType : STRING COLON DIGIT;
ElemGameType : STRING COLON STRING;
ElemMinDist : STRING COLON POSITIVEREAL;
ElemWagerStatistics : STRING COLON HOOKLEFT ElemColumns COMMA ElemWagers COMMA ElemAddOn HOOKRIGHT;
ElemColumns : STRING COLON TYPEOFNUM;
ElemWagers : STRING COLON TYPEOFNUM;
ElemAddOn : STRING COLON JSONARRAY;
ElemTotalPages : STRING COLON TYPEOFNUM;
ElemTotalElements : STRING COLON TYPEOFNUM;
ElemLastBool : STRING COLON STRING;
ElemNumberOfElements : STRING COLON TYPEOFNUM;
ElemSort : STRING COLON BRACKETLEFT ElemTempObj3 BRACKETRIGHT;
ElemTempObj3 : HOOKLEFT ElemDirection COMMA ElemProperty COMMA ElemIgnoreCase COMMA ElemNullHandling COMMA ElemDescending COMMA ElemAscending HOOKRIGHT;
ElemDirection : STRING COLON STRING;
ElemProperty : STRING COLON STRING;
ElemIgnoreCase : STRING COLON STRING;
ElemNullHandling : STRING COLON STRING;
ElemDescending : STRING COLON STRING;
ElemAscending : STRING COLON STRING;
ElemFirst : STRING COLON STRING;
ElemSize : STRING COLON TYPEOFNUM;
ElemNumber : STRING COLON TYPEOFNUM;
%%
void yyerror (char *s)
{
    errorCount++;
    fprintf(stderr,"%s on line %d \n",s,lineNumber); /*here I get the info about errors */
}
int main(int argc, const char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    } else {
        yyin = stdin;
    }
    int result;
    if ((result = yyparse()) == 0) {
        printf("\nPARSING COMPLETED.\nPROGRAM IS VALID.\n");
    } else {
        printf("\nfound %d syntax errors.\n",errorCount);
    }
    return 0;
}
