header {package decaf;}

options 
{
  mangleLiteralPrefix = "TK_";
  language="Java";
}

class DecafScanner extends Lexer;
options 
{
  k=2;
}

tokens 
{
  "class";
}


LCURLY options { paraphrase = "{"; } : "{";
RCURLY options { paraphrase = "}"; } : "}";

ID options { paraphrase = "an identifier"; } : 
  ("0x")=>("0x" ('0'..'9' | 'a'..'f' | 'A'..'F')+) | ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')+ {
    String result = new String(text.getBuffer(), _begin, text.length()-_begin);
    if (result.equals("boolean") || result.equals("int")) {
        _ttype = TYPE; 
    } else if (result.equals("void")) {
        _ttype = VOID; 
    } else if (result.equals("break")) {
        _ttype = BREAK; 
    } else if (result.equals("callout")) {
        _ttype = CALLOUT;
    } else if (result.equals("class")) {
        _ttype = CLASS;
    } else if (result.equals("continue")) {
        _ttype = CONTINUE; 
    } else if (result.equals("else")) {
        _ttype = ELSE; 
    } else if (result.equals("for")) {
        _ttype = FOR; 
    } else if (result.equals("if")) {
        _ttype = IF; 
    } else if (result.equals("return")) {
        _ttype = RETURN; 
    } else if (result.equals("true") || result.equals("false")) {
        _ttype = BOOL;
    } else if (result.matches("[0-9]+")) {
        _ttype = INT;
    } else if (Character.isDigit(result.charAt(0))) {
        throw new NoViableAltForCharException((char)LA(1), getFilename(), getLine(), getColumn());
    }
  };

ASS_OP : "==" | '=' | "+=" | "-=" | '+' | '-' {
    String result = new String(text.getBuffer(), _begin, text.length()-_begin);
    if (result.equals("==")) {
       _ttype = EQ_OP;
    } else if (result.equals("+") || result.equals("-")) {
       _ttype = ARTH_OP;
    }
};
ARTH_OP : '*' | '/' | '%';
REL_OP : '<' | '>' | "<=" | ">=";
EQ_OP : "!=";
COND_OP : "&&" | "||" ;

COMMA : ',' ;

RPARA : ')';
LPARA : '(';
SEMI : ';';
LSQAR : '[';
RSQAR : ']';

//INT : ('0'..'9')+;


WS_ : ('\t' | ' ' | '\n' {newline();}) {_ttype = Token.SKIP; };

SL_COMMENT : "//" (~'\n')* '\n' {_ttype = Token.SKIP; newline (); };

CHARLITERAL : '\'' (ESC | ~('\'' | '\\' | '"' | '\n' | '\t')) '\'';
STRING : '"' (ESC|~('"' | '\\' | '\'' | '\n' | '\t'))* '"';

protected
ESC :  '\\' ('n'|'"'|'t'|'\\'|'\'');

protected
CLASS: ;

protected
CONTINUE: ;

protected
ELSE: ;

protected
FOR: ;

protected
IF: ;

protected
RETURN: ;

protected
BREAK: ;

protected
CALLOUT: ;

protected
VOID : ;

protected
INT : ;

protected
TYPE : ;

protected
KEYWORD : ;

protected
BOOL : ;
