import semmle.code.java.Expr

from CharacterLiteral lit
select lit, lit.getStringValue(), lit.getCodePointValue()
