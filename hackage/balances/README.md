# balances

![](balances.png)

## Play

This "game" tests/drills your financial situational awareness,
if you keep accounts in hledger (or can obtain a hledger-compatible
copy of some entity's accounts). It picks a random asset or liability account
and asks you to enter its approximate balance.
If your answer is not correct, it asks again, until you get one right.

It uses your default hledger journal if you have one:
```
$ ./play balances  # or: hackage/balances/balances.hs
```

or you can specify a file in one of hledger's data formats, using LEDGER_FILE:
```
$ curl -O https://raw.githubusercontent.com/simonmichael/hledger/master/examples/sample.journal
$ LEDGER_FILE=sample.journal ./play balances

assets:cash balance ? 1
Off by ~1, score: 50.0

assets:bank:saving balance ? 1
Correct! It is $1.
```

For each guess, enter a single positive integer, trying to match the integral
part of the balances. When an account has a multi-currency balance, only
the most numerous commodity is considered.

## About

A first draft, needs refinement. 
balances.dev.hs is the readable/dev version, balances.hs the minified version.

This bridges two favourite hobbies, Plain Text Accounting and game development. 
It could perhaps be developed into (a) a more fun game and/or (b) a more capable
[hledger script](https://hledger.org/scripts.html) with practical value.
