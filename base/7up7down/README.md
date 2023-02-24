# 7up7down

A terminal based guessing game. The player has to guess the result of rolling
two dice as 7up, 7down or 7.

* Category: `base-10-80`
* Tested with: GHC 9.2.6
* Author: @akshaymankar

## Runnnig

Only tested on linux: Execute `7up7down.hs` while `runhaskell` available in
`$PATH`. It _should_ just work on other Operating Systems 🤞

## Notes

Thanks to @gergoerdi this game can work without depending on the `random`
package: https://github.com/haskell-game/tiny-games-hs/issues/79

Another idea for improvement could be to make the game validate player input so
the player doesn't automatically lose by making typos.

The buffering mode is set to `LineBuffering` when using compiled code, this
causes the input prompt to not get flushed and it seems like the game is just
stuck. Smallest way to get around it was to use `hFlush stdout`. Curiously this
doesn't happen when runing the code directly with `runhaskell`. Since there was
enough space left before the 10th line, this is part of the game.

Writing something like `if i=="7"then b+2else b+1` is valid haskell even if
there is no space between `2` and `else`. However, it is even shorter to write
`b+1+fromEnum(i=="7")`. Using `fromEnum` also helps GHC infer type of b to be
`Int`, so this also gets rid of a type annotation.

If the terminal is using a nerd fonts patched font, replacing `9855` with
`983498` will produce nicer looking dice. Including this in the game code would
of course go against having it "just work", so it was left out.

## Better formatted code

This is just output of pasting the minified code into https://ormolu-live.tweag.io/

```haskell
#!/usr/bin/env runhaskell
import Data.Bifoldable
import GHC.Clock
import System.IO

r =
  fromEnum
    . (+ 1)
    . ( `mod` 6
      )
    . (`div` 1000)
    <$> getMonotonicTimeNSec

d n = putStr $ toEnum <$> [9855 + n, 32]

main = g 10

g b =
  if (b <= 0)
    then putStrLn "c ya l8r l0$3r"
    else
      putStr
        ( "balance=₹"
            ++ (show b)
            ++ "|b\
               \et=₹1|7/7up/7down/q: "
        )
        >> hFlush stdout
        >> getLine
        >>= \i ->
          if i /= "q"
            then
              (,) <$> r <*> r
                >>= \(x, y) ->
                  bimapM_ ((d x >> d y >>) . putStrLn) g $
                    if (x + y > 7 && i == "7up")
                      || ( x + y < 7
                             && i
                               == "7\
                                  \down"
                         )
                      || (x + y == 7 && i == "7")
                      then ("You win!", b + 1 + fromEnum (i == "7"))
                      else
                        ( "You lose!",
                          b
                            - 1
                        )
            else putStrLn "Bye!"
-- ^ 08 ------------------------------------------------------------------ 80> --
--
--  Category: base-10-80
--  Tested with: GHC 9.2.6
--  Author: @akshaymankar
--
--  Guess the result of rolling two 6 sided dice by writing one of 7up, 7down or
--  7.
--  7up wins if the result greater than 7
--  7down wins if the result is less than 7
--  7 wins if the result is exactly 7.
--  Starting balance is ₹10, every bet is ₹1.
--  On victory with 7up or 7down, the player wins ₹1
--  On victory with a 7, the player wins ₹2.
--  Enter q instead of a guess to exit.
--  Any invalid inputs (including typos) lose.
```
