# balances

![](balances.png)

Tests/drills your financial situational awareness, asking for the balance
in random asset/liability accounts until you get one right.
Uses your default hledger journal if you have one:
```
$ ./balances.hs
```
otherwise finance data in a hledger-readable format, from somewhere else:
```
$ LEDGER_FILE=~/src/hledger/examples/sample.journal ./balances.hs
```

A first draft, needs refinement. 
balances.dev.hs is the readable/dev version, balances.hs the minified version.

This bridges two favourite hobbies, Plain Text Accounting and game development. 
It could perhaps be developed into (a) a more fun game and/or (b) a more capable
[hledger script](https://hledger.org/scripts.html) with practical value.
