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
    String result = new String(new String(text.getBuffer(), _begin, text.length()-_begin));
    if (result.equals("boolean") || result.equals("break") || result.equals("callout") ||
        result.equals("class") || result.equals("continue") || result.equals("else") ||
        result.equals("for") || result.equals("if") || result.equals("int") || 
        result.equals("return") || result.equals("void")) {
           _ttype = KEYWORD; 
        } else if (result.equals("true") || result.equals("false")) {
           _ttype = BOOL;
        } else if (result.matches("[0-9]+")) {
           _ttype = INT;
        }
  };

OP : '+' | '-' | '*' | '/'| '=' | "==" |'<' | '>' | '%' | "||" | "<=" | "!=" | ">=" | "+=" | "-="| "&&";

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
INT : ;
protected
KEYWORD : ;
protected
BOOL : ;
