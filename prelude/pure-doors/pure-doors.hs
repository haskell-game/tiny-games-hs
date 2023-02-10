#!/usr/bin/env runhaskell
main = interact (go (-1) ((\n -> (5, mod n 8)) <$> nums) 3)
draw c mid pos = "|" <> r pos c <> mid <> r (7 - pos) c <> "|\n"
(r, t, nums) = (replicate, draw ' ' " " 7, 1 : 2 : zipWith (+) nums (tail nums))
s 5 (0,d) p x c = if d /= p then "Crash!" <> c [] else s 5 (head x) p (tail x) c
s 5 (l,d) p x c = draw ' ' "^" p <> "[jkl]> " <> c ((l - 1, d) : x)
s n e@(l,d) p x c = (if (n==5-l) then draw '-' " " d else t) <> s (n+1) e p x c
go x m p i = "\ESCcpure-doors\n" <> s 0 (head m) p (tail m) (\m -> case (m,i) of
 (_:_, c:'\n':xs) | c > 'h' && c < 'n' -> go (x+1) m (p + fromEnum c - 107) xs
 _ -> (if x>5 then " GG, your score is: " <> show (div x 5) else "") <> "\n")
-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/pure-doors (tristanC)

The goal of pure-doors is to pass through doors by moving the player
left/forward/right with 'j'/'k'/'l'.


This game is powered by `interact :: (String -> String) -> IO ()`.
The trick is that the input/output are consumed/produced lazily.

For example:

>>> interact (\input -> "World\n" <> "Prompt: " <> take 1 input <> "Done\n")
World
Prompt: <player input>
Done

As you can see, `interact` produces the output until the input is needed lazily.
Therefore, the whole game is a pure `String -> String` function, hence its name.


This game's loop goes like this:

- L8, clear the screen.
- L5-7, draw the world.
- L9, if the state is valid, read the input and repeat.
- L10, otherwise, print the final score.

Here are the game components:

- The world is a list of doors tuple: (distance to player, door position).
  L4, The positions `nums` are generated using a `zipWith` fib sequence.
- The step function `s` takes a continuation argument to compute the next world:
    s :: Line -> Door -> Player -> Doors -> (\Doors -> String) -> String
  L5, when passing a door, check the player position.
  L6, after 5 lines, draw the player.
  L7, otherwise draw the current door or an empty line.
- The loop function `go` calls `s` and advances the game:
    go :: Score -> Doors -> Player -> String -> String
  L9, if the new world `m` is not empty and the input is valid, then recurse.
  L10, otherwise print the final score.
- The input char `c` is converted to a number using the Enum Char instance.


Note that the 9th door is impossible to pass, but there is a hidden trick:
use 'i' and 'm' to move the player by two :-)

Thanks for your time, have fun!
-Tristan
-}
