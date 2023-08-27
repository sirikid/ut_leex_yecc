Nonterminals
template
literal_or_expression
literal
expression
variables
variable
name
.

Terminals
number
operator
'*' ',' '.' ':' '{' '}'
word
simple_literal
.

Rootsymbol template.

template -> literal_or_expression          : ['$1'].
template -> literal_or_expression template : ['$1' | '$2'].

literal_or_expression -> literal    : unwrap('$1').
literal_or_expression -> expression : '$1'.

literal -> number         : '$1'.
literal -> operator       : '$1'.
literal -> '*'            : '$1'.
literal -> ','            : '$1'.
literal -> '.'            : '$1'.
literal -> ':'            : '$1'.
literal -> word           : '$1'.
literal -> simple_literal : '$1'.

expression -> '{' operator variables '}' : {unwrap('$2'), '$3'}.
expression -> '{'          variables '}' : {simple, '$2'}.

variables -> variable               : ['$1'].
variables -> variable ',' variables : ['$1' | '$3'].

variable -> name '*'        : {exploded, '$1'}.
variable -> name ':' number : {trimmed, '$1', list_to_integer(unwrap('$3'))}.
variable -> name            : '$1'.

name -> word          : list_to_binary(unwrap('$1')).
name -> word '.' name : safe_cons(list_to_binary(unwrap('$1')), '$3').

Erlang code.

unwrap(Token) ->
    element(3, Token).

safe_cons(Hd, Tl) when is_list(Tl) ->
    [Hd | Tl];
safe_cons(Hd, Tl) ->
    [Hd, Tl].
