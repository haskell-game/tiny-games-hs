# The lambda calculus game!

Define lambda calculus terms with the desired behavior.

## Lambda calculus syntax

Lambda calculus terms are represented using de Bruijn indices
(https://en.wikipedia.org/wiki/De_Bruijn_index), where 0 refers to the
innermost enclosing lambda, 1 refers to the next enclosing lambda, and
so on.  The syntax of terms is given by

```
  t ::= <i>
      | <K>
      | '\' t
      | t t
      | '(' t ')'
```

where `<i>` represents a single digit from 0-9 representing a variable
(a de Bruijn index), and `<K>` represents any single-character constant
other than a digit, backslash, or parentheses.  No whitespace is
allowed whatsoever.

For example, `\\1(t0)` represents `\x -> \y -> x (t y)`.

## How to play

With each level, you are required to define a certain name as a lambda
calculus term with the desired behavior. You should enter something of
the form `<name>=<term>`, where `<name>` is a single-letter name, and
`<term>` is a lambda-calculus term using the syntax explained above.
Typically you would define the `<name>` you are required to define,
but you could define other names first.

You will be shown a series of examples showing the desired result of
applying the given name to some arguments.  For example,

```
tTF=T
```

would mean that you are supposed to define a term `t`, which when
applied to free variables `T` and `F`, should reduce to `T`.  A valid
definition for `t` would be

```
t=\\1
```

You may use previously defined names in later inputs (previously
defined names may also show up in later examples).  For example, once
you correctly defined `t`, you would be free to refer to it in any of
your later definitions.

## Regrets

Unfortunately, in the end there was not room for very many levels.  Oh well!
