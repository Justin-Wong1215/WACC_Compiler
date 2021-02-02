parser grammar WACCParser;

options {
  tokenVocab=WACCLexer;
}

program     : BEGIN func* stat END EOF;
func        : type IDENT OPEN_PARENTHESES param_list? CLOSE_PARENTHESES IS stat* end_stat END;
param_list  : param (COMMA param )* ;
param       : type IDENT;

stat : SKP
     | type IDENT ASSIGN assign_rhs
     | assign_lhs ASSIGN assign_rhs
     | READ assign_lhs
     | FREE expr
     | RETURN expr
     | end_stat
     | PRINTLN expr
     | IF expr THEN stat ELSE stat FI 
     | WHILE expr DO stat DONE
     | BEGIN stat END
     | stat SEMICOLON stat
     ;

end_stat: EXIT expr
        | PRINT expr
        ;

assign_lhs : IDENT
           | array_elem
           | pair_elem
           ;

assign_rhs : expr
           | array_liter
           | NEWPAIR OPEN_PARENTHESES expr  COMMA expr  CLOSE_PARENTHESES | pair_elem
           | CALL IDENT  OPEN_PARENTHESES arg_list? CLOSE_PARENTHESES
           ;

// argument list for functions 
arg_list  : expr (COMMA expr)*;
pair_elem : FST expr
          | SND expr
          ;

type : BASE_TYPE  
     | array_type
     | pair_type 
     ;

array_type     : array_type OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET 
               | BASE_TYPE OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET
               | pair_type OPEN_SQUARE_BRACKET CLOSE_SQUARE_BRACKET
               ;
pair_type      : PAIR OPEN_PARENTHESES pair_elem_type  COMMA pair_elem_type  CLOSE_PARENTHESES ;
pair_elem_type : BASE_TYPE  
               | array_type  
               | PAIR 
               ;

expr : INT_LITER      #IntExpr
     | PLUS INT_LITER #IntExpr
     | BOOL_LITER     #BoolExpr
     | CHAR_LITER     #CharExpr
     | STR_LITER      #StrExpr
     | PAIR_LITER     #PairExpr
     | IDENT          #IdExpr
     | array_elem     #ArrayExpr
     | uop=( '-' | '!' | 'len' | 'ord' | 'chr' ) expr #UnopExpr
     | expr bop=( '*' | '/' | '%' ) expr              #MulDivExpr
     | expr bop=( '+' | '-' ) expr                    #PlusMinExpr
     | expr bop=( '>' | '>=' | '<' | '<=' ) expr      #CmpExpr
     | expr bop=( '==' | '!=' ) expr                  #EqExpr
     | expr bop=( '&&' | '||' ) expr                  #AndOrExpr
     | OPEN_PARENTHESES expr CLOSE_PARENTHESES        #ParenExpr
     ;

array_elem  : IDENT (OPEN_SQUARE_BRACKET expr CLOSE_SQUARE_BRACKET)+ ;
array_liter : OPEN_SQUARE_BRACKET (expr (COMMA expr)*)? CLOSE_SQUARE_BRACKET ;