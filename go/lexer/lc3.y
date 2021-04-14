%{
package main

type Token struct {
  lit string
}

type Stmt interface {
  statement()
}

type StmtExpr struct {
  Expr    Expr
}

type StmtVarDef struct {
  VarName string
  Expr    Expr
}

func (x *StmtExpr) statement() {}
func (x *StmtVarDef) statement() {}

type Expr interface {
  expression()
}

type ExprNumber struct {
  Lit string
}

type ExprIdent struct {
  Lit string
}

func (x *ExprNumber) expression() {}
func (x *ExprIdent) expression() {}
%}

%union {
  stmts []Stmt
  stmt  Stmt
  expr  Expr
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
        $$ = &StmtExpr{ Expr: $1 }
    }
    | VAR IDENT '=' expr
    {
        $$ = &StmtVarDef{ VarName: $2.lit, Expr: $4 }
    }

stmts
    :
    { $$ = nil }
    | stmt stmts
    {
        $$ = append([]Stmt{$1}, $2...)
    }

expr
    : NUMBER
    {
        $$ = &ExprNumber{ Lit: $1.lit }
    }
    | IDENT
    {
        $$ = &ExprIdent{ Lit: $1.lit }
    }

%%
