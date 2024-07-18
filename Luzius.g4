grammar Luzius;

/*------------ REGRAS LEXICAS ------------*/

PLUS: '+';
MULT: '*';
MINUS: '-';
DIV: '/';
OPEN_P: '(';
CLOSE_P: ')';
OPEN_CON: '[';
CLOSE_CON: ']';
OPEN_C: '{';
CLOSE_C: '}';
ATTRIB: '=';
QUOTE: '"';
COMMA: ',';
EQ: '==';
NE: '!=';
GE: '>=';
GT: '>';
LE: '<=';
LT: '<';

MAIN: 'main';
PRINT: 'print';
PRINT_STRING: 'printString';
PRINT_COLORED_STRING: 'printColoredString';
READ_STRING: 'readString';
READ_INT: 'readInt';
PLAY: 'play';
LOOP: 'loop';
WHILE: 'while';
IF: 'if';
RANDOM: 'random';

VAR: [a-z]+;
NUM: [0-9]+;
STRING: QUOTE [a-zA-Z0-9 ]* QUOTE;
NL: ('\r')? '\n';
SPACE: [ \t]+ -> skip;

/*------------ ANALISE SINTATICA ------------*/

program: main;

main: MAIN OPEN_P CLOSE_P OPEN_C (statement)* CLOSE_C NL;

assigment: VAR ATTRIB expression;

playStatement: PLAY OPEN_P CLOSE_P NL;
printStatement: PRINT OPEN_P expression CLOSE_P NL;
printStringStatement: PRINT_STRING OPEN_P STRING CLOSE_P NL;
printColoredStringStatement:
    PRINT_COLORED_STRING OPEN_P STRING COMMA (NUM | VAR) CLOSE_P NL;
readStringStatement: READ_STRING OPEN_P CLOSE_P NL;
readIntStatement: VAR ATTRIB READ_INT OPEN_P CLOSE_P NL;
randomStatement:
    VAR ATTRIB RANDOM OPEN_P (NUM | VAR) CLOSE_P NL;

vetorStatement: VAR ATTRIB OPEN_CON (NUM | VAR) CLOSE_CON NL;
vetorAssigment:
    VAR OPEN_CON (NUM | VAR) CLOSE_CON ATTRIB (NUM | VAR);
vetorRead: VAR OPEN_CON (NUM | VAR) CLOSE_CON;

loopStatement: LOOP OPEN_C NL (statement)* CLOSE_C;

whileCondition: term operator term;
whileStatement:
    WHILE OPEN_P whileCondition CLOSE_P OPEN_C NL (statement)* CLOSE_C;

ifCondition: term operator term;
ifStatement:
    IF OPEN_P ifCondition CLOSE_P OPEN_C NL (statement)* CLOSE_C;

operator: EQ | NE | GE | GT | LE | LT;

statement:
    NL
    | loopStatement
    | whileStatement
    | ifStatement
    | playStatement
    | printStatement
    | printStringStatement
    | printColoredStringStatement
    | readStringStatement
    | readIntStatement
    | randomStatement
    | vetorStatement
    | vetorAssigment
    | assigment;

term: VAR | NUM | vetorRead;

expression:
    term
    | expression MULT expression
    | expression DIV expression
    | expression PLUS expression
    | expression MINUS expression;
