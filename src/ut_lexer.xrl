Definitions.

Digit    = 0-9
Operator = +#/;?&=!@|
Special  = *,.:{}
Word     = a-zA-Z_
Literal  = ^{Digit}{Operator}{Special}{Word}

Rules.

[{Digit}]+   : {token, {number, TokenLine, TokenChars}}.
[{Operator}] : {token, {operator, TokenLine, TokenChars}}.
[{Special}]  : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.
[{Word}]+    : {token, {word, TokenLine, TokenChars}}.
[{Literal}]+ : {token, {simple_literal, TokenLine, TokenChars}}.

Erlang code.
