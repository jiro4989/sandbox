%{
package main

import "fmt"

type Token struct {
  lit string
}

type StatementVarDef struct {
  VarName string
  Expr    Expression
}
%}

%union {
  stmts []Statement
  stmt  Statement
  expr  Expression
  tok   Token
}

%type<stmts> stmts
%type<stmt>  stmt
%type<expr>  expr
%token<tok>  IDENT NUMBER VAR

%%
stmt
    : expr
    {
        $$ = &StatementExpression{ Expr: $1 }
    }
    | VAR IDENT '=' expr
    {
        $$ = &StatementVarDef{ VarName: $2.lit, Expr: $4 }
    }

stmts
    : stmt
    | stmts stmt

expr
    : NUMBER
    {
        $$ = &ExpressionNumber{ Expr: $1.lit }
    }
    | IDENT
    {
        $$ = &ExpressionIdent{ Expr: $1.lit }
    }

%%
