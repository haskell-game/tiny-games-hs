# Timing

This [Haskell tiny game][] implements a timing game.  How well can you
estimate a duration of time?

* Category: `base-10-80`
* Tested environment: [Stack][] [lts-20.10][] (GHC 9.2.5) on Linux
* Author: [TravisCardwell][]

[Haskell tiny game]: <https://github.com/haskell-game/tiny-games-hs>
[Stack]: <https://docs.haskellstack.org/>
[lts-20.10]: <https://www.stackage.org/lts-20.10>
[TravisCardwell]: <https://github.com/TravisCardwell>

## How to Play

Download the source files:

```
$ git clone https://github.com/haskell-game/tiny-games-hs.git
$ cd base/timing
```

With Stack installed, execute the game:

```
$ ./timing.hs
```

Alternatively, you can execute the game using `runghc`:

```
$ runghc timing.hs
```

The default duration is 30 seconds.  You may specify a different duration
using a command-line argument, as follows:

```
$ ./timing.hs 5
```

After the game builds, instructions are displayed.

```
Press enter.  Wait 30 seconds.  Press enter.
```

Press enter, wait for the specified duration, and then press enter again.  The
idea is to test how well you can estimate a duration of time, so do not use an
external time reference such as a clock.  The game displays how long you
waited and your score, from 0 (terrible) to 100 (excellent):

```
You waited 31.64782962400932 seconds.
Score: 94.5072345866356
```

## Notes

* There is no error handling.  The program exits with an error if the input is
  not correct, for example.
* There is no input validation.  It is up to the player to input a valid
  argument.
* A comment on line 1 breaks some parsers, so I used a Haskell comment on
  line 4 instead.
