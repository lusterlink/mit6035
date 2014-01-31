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
  "!";
}


LCURLY options { paraphrase = "{"; } : "{";
RCURLY options { paraphrase = "}"; } : "}";

ID options { paraphrase = "an identifier"; } : 
  (("0x")=>("0x" ('0'..'9' | 'a'..'f' | 'A'..'F')+) | ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')+) {
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
    } else if (result.length() > 1 && result.charAt(0) == '0' && result.charAt(1) == 'x') {
        _ttype = INT;
    } else if (Character.isDigit(result.charAt(0))) {
        throw new NoViableAltForCharException((char)LA(1), getFilename(), getLine(), getColumn());
    }
  };

ASS_OP options { paraphrase = "an assignment operation"; } : ("==" | '=' | "+=" | "-=" | '+' | '-') {
    String result = new String(text.getBuffer(), _begin, text.length()-_begin);
    if (result.equals("==")) {
       _ttype = EQ_OP;
    } else if (result.equals("+")) {
       _ttype = PLUS_OP;
    } else if (result.equals("-")) {
       _ttype = MINUS_OP;
    } else if (result.equals("=")) {
       _ttype = EQUALS_OP;
    }
};
protected
EQUALS_OP options { paraphrase = "="; } : ;
ARTH_OP options {paraphrase = "an arth operator"; } : '*' | '/' | '%';
REL_OP options {paraphrase = "a rel operator"; } : '<' | '>' | "<=" | ">=";
EQ_OP options { paraphrase = "an equaltiy operator"; } : "!=";
AND_OP options { paraphrase = "&&"; } : "&&";
OR_OP options { paraphrase = "||";} : "||" ;

COMMA options { paraphrase = ","; } : ',' ;

RPARA options { paraphrase = ")"; } : ')';
LPARA options { paraphrase = "("; } : '(';
SEMI options { paraphrase = ";"; } : ';';
LSQAR options { paraphrase = "["; } : '[';
RSQAR options { paraphrase = "]"; } : ']';

//INT : ('0'..'9')+;


WS_ : ('\t' | ' ' | '\n' {newline();}) {_ttype = Token.SKIP; };

SL_COMMENT : "//" (~'\n')* '\n' {_ttype = Token.SKIP; newline (); };

CHARLITERAL options { paraphrase="a character literal"; } : '\'' (ESC | ~('\'' | '\\' | '"' | '\n' | '\t')) '\'';
STRING options { paraphrase="a string literal"; } : '"' (ESC|~('"' | '\\' | '\'' | '\n' | '\t'))* '"';

protected
PLUS_OP options { paraphrase="+"; } : ;

protected
MINUS_OP options { paraphrase="-"; } : ;

protected
ESC :  '\\' ('n'|'"'|'t'|'\\'|'\'');

protected
CLASS options { paraphrase="class"; } : ;

protected
CONTINUE options { paraphrase="continue"; } : ;

protected
ELSE options { paraphrase="else"; } : ;

protected
FOR options { paraphrase="for"; } : ;

protected
IF options { paraphrase="if";} : ;

protected
RETURN options { paraphrase="return"; } : ;

protected
BREAK options { paraphrase="break"; } : ;

protected
CALLOUT options { paraphrase="callout"; } : ;

protected
VOID options { paraphrase="void"; } : ;

protected
INT options { paraphrase="an integer"; } : ;

protected
TYPE options { paraphrase="a type identifier"; } : ;

protected
KEYWORD options { paraphrase="a keyward"; }: ;

protected
BOOL options { paraphrase="a boolean"; } : ;
