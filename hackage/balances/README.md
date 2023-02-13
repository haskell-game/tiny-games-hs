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
