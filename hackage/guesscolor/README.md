# Guess the Color

This [Haskell tiny game][] implements a color guessing game.  How well do you
know your colors?  Guess RGB values for the displayed color!

* Category: `hackage-10-80`
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
$ cd hackage/guesscolor
```

With Stack installed, execute the game:

```
$ ./guesscolor.hs
```

After the game builds, it should open a window.  In the terminal, enter
space-separated RGB values (0-255) for the color in the window and press
enter:

```
180 180 220
```

The game displays the actual RGB values and your score, from 0 (terrible
guess) to 100 (excellent guess):

```
Actual color: 168 195 233
Score: 94
```

## Notes

* There is no error handling.  The program exits with an error if the input is
  not correct, for example.
* There is no input validation.  It is up to the player to input RGB values
  within the correct range.
* If you press escape in the color window, the game exits.
* A comment on line 1 breaks some parsers, so I used a Haskell comment on
  line 4 instead.
