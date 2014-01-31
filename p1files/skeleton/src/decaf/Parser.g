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

protected 
field_decl: TYPE fd_dec (COMMA fd_dec)* SEMI ;
protected
fd_dec: ID | (ID LSQAR INT RSQAR);

protected
method_decl: (TYPE | VOID) ID LPARA (md_dec (COMMA md_dec)*)? RPARA block;
protected
md_dec: TYPE ID;

protected
block: LCURLY (var_decl)* (statement)* RCURLY;

protected
var_decl: TYPE ID (COMMA ID)* SEMI ;

protected
statement: (location assign_ops expr SEMI) | (RETURN (expr)* SEMI) | (IF LPARA expr RPARA block (ELSE block)?) | (FOR ID EQUALS_OP expr COMMA expr block) | (method_call SEMI) | (BREAK SEMI) | (CONTINUE SEMI);
protected
assign_ops: ASS_OP | EQUALS_OP;

protected
location: ID | (ID LSQAR expr RSQAR) ;

protected
expr: (MINUS_OP expr)=>(MINUS_OP expr) | (TK_! expr)=> (TK_! expr) | expr_2;
protected
expr_2: (expr_3 ARTH_OP expr_2)=>(expr_3 ARTH_OP expr_2) | expr_3;
protected
expr_3: (expr_4 expr_3_ops expr_3)=>(expr_4 expr_3_ops expr_3) | expr_4;
protected
expr_4: (expr_5 REL_OP expr_4)=>(expr_5 REL_OP expr_4) | expr_5;
protected
expr_5: (expr_6 EQ_OP expr_5)=>(expr_6 EQ_OP expr_5) | expr_6;
protected
expr_6: (expr_7 AND_OP expr_6)=>(expr_7 AND_OP expr_6) | expr_7;
protected
expr_7: (expr_lit OR_OP expr_7)=>(expr_lit OR_OP expr_7) | expr_lit;
protected
expr_lit: ((method_name LPARA) | (CALLOUT LPARA))=>(method_call) | (location | literal | (MINUS_OP expr) | (LPARA expr RPARA) | (TK_! expr));

protected
expr_3_ops: MINUS_OP | PLUS_OP;

/*
expr : (expr_lit bin_op)=>(expr_lit bin_op expr_p) | (expr_lit);
protected
protected
expr_lit: (method_name LPARA)=>(method_call) | (location | literal | (MINUS_OP expr) | (LPARA expr RPARA) | (TK_! expr));
expr_p: (expr_lit bin_op)=>(expr_lit bin_op expr_p) | (expr_lit);
*/

protected
bin_op : ARTH_OP | REL_OP | EQ_OP | COND_OP | MINUS_OP;
protected
literal: INT | CHARLITERAL | BOOL;
protected
method_call : (method_name LPARA (expr (COMMA expr)*)? RPARA) | (CALLOUT LPARA STRING (COMMA callout_arg)* RPARA);
protected
method_name : ID;
protected
callout_arg: expr | STRING;

