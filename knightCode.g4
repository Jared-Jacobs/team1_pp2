/*
BSD License
Copyright (c) 2017, Tom Everett
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of Tom Everett nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

grammar knightCode;

file
    : 'PROGRAM' ID declare body
    ;
declare
    : 'DECLARE' variable+
    ;
variable
    : type ID
    ;
type
    : 'INTEGER' | 'STRING'
    ;
body
    : 'BEGIN' stat+ 'END'
    ;
stat
    : setvar
    | expr
    | print
    | read
    | decision
    | loop
    ;
setvar
    : 'SET' ID ASSIGN (expr | STRING)
    ;
expr
    : expr muldiv expr
    | expr addsub expr
    | expr comp expr 
    | NUMBER
    | ID
    ; 
comp
    : GT | LT | EQ | NEQ
    ;
muldiv
    : MUL | DIV
    ;
addsub
    : ADD | SUB
    ; 
print
    : 'PRINT' (STRING | ID)
    ;
read
    : 'READ' ID
    ;
decision
    : 'IF' expr comp expr 'THEN' stat+ indecision* 'ENDIF'
    ;
indecision
	: 'ELSE' stat+
	;
loop
    : 'WHILE' expr comp expr 'DO' stat+ 'ENDWHILE'
    ;
ID 
   : LETTER (LETTER | [0-9])*
   ;
STRING
   : '"' (ESC|.)*? '"'
   ;
ASSIGN
   : ':='
   ;
LETTER 
   : [a-zA-Z]
   ;
NUMBER
   : [0-9]+
   ;
MUL 
   : '*'
   ;
DIV
   : '/'
   ; 
ADD
   : '+'
   ;
SUB
   : '-'
   ;
GT 
   : '>'
   ;
LT
   : '<'
   ;
EQ
   : '='
   ;
NEQ
   : '<>'
   ;
CR
   : [\r\n]* '"'
   ;
WS
   : [ \t\n\r;] -> skip
   ;
ESC
   : '//'
   ;
COMMENT
   : '#' .*? '\n' -> skip
   ;  
