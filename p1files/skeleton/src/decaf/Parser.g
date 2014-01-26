header {package decaf;}

options
{
  mangleLiteralPrefix = "TK_";
  language="Java";
}

class DecafParser extends Parser;
options
{
  importVocab=DecafScanner;
  k=3;
  buildAST=true;
}

program: TK_class ID LCURLY (field_decl)* (method_decl)* RCURLY EOF;

field_decl: TYPE fd_dec (COMMA fd_dec)* SEMI ;
protected
fd_dec: ID | (ID LSQAR INT RSQAR);

method_decl: (TYPE | VOID) ID LPARA (md_dec (COMMA md_dec)*)? RPARA block;
protected
md_dec: TYPE ID;

block: LCURLY (var_decl)* (statement)* RCURLY;

var_decl: TYPE ID (COMMA TYPE ID)* SEMI ;

statement: (location assign_ops expr SEMI) | (RETURN (expr)* SEMI) | (IF LPARA expr RPARA block (ELSE block)?) | (FOR ID EQUALS_OP expr COMMA expr block) | (method_call SEMI) | (BREAK SEMI) | (CONTINUE SEMI);
protected
assign_ops: ASS_OP | EQUALS_OP;

location: ID | (ID LSQAR expr RSQAR) ;

expr : (expr_lit bin_op)=>(expr_lit bin_op expr_p) | (expr_lit);
protected
expr_lit: (method_name LPARA)=>(method_call) | (location | literal | (MINUS_OP expr) | (LPARA expr RPARA) | (TK_! expr));
protected
expr_p: (expr_lit bin_op)=>(expr_lit bin_op expr_p) | (expr_lit);

bin_op : ARTH_OP | REL_OP | EQ_OP | COND_OP | MINUS_OP;
literal: INT | CHARLITERAL | BOOL;
method_call : (method_name LPARA (expr (COMMA expr)*)? RPARA) | (CALLOUT LPARA STRING (COMMA callout_arg)* RPARA);
method_name : ID;
callout_arg: expr | STRING;

