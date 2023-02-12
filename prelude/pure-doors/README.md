# pure-doors

An adventure game.

![Playing the game](pure-doors.png)

## Playing

The goal of pure-doors is to pass through doors by moving the player
left/forward/right with <kbd>j</kbd>/<kbd>k</kbd>/<kbd>l</kbd>. You
get one point per door.

Start by running [./pure-doors.hs](pure-doors.hs).

## Documentation

This game is powered by `interact :: (String -> String) -> IO ()`.
The trick is that the input/output are consumed/produced lazily.

For example:

```ShellSession
>>> interact (\input -> "World\n" <> "Prompt: " <> take 1 input <> "Done\n")
World
Prompt: <player input>
Done
```

As you can see, `interact` produces the output until the input is needed lazily.
Therefore, the whole game is a pure `String -> String` function, hence its name.

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env runhaskell
-- | pure-doors expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

-- | Door positions are generated using a 'zipWith' fib sequence.
type Position = Int
nums :: [Position]
nums = 1 : 2 : zipWith (+) nums (tail nums)

-- | Initialize the doors' distance.
type DoorDistance = Int
type Door = (DoorDistance, Position)
type World = [Door]
world :: World
world = map (\n -> (5, mod n 8)) nums

-- | Render a single line.
draw :: Char -> String -> Position -> String
draw sep mid pos = "|" <> replicate pos sep <> mid <> replicate (7 - pos) sep <> "|\n"

-- | An empty line.
t :: String
t = draw ' ' " " 7

-- | Draw the world and check for crash.
s :: Int -> Door -> Position -> World -> (World -> String) -> String
-- last line contains a door, check the player position.
s 5 (0,d) p x c = if d /= p then "Crash!" <> c [] else s 5 (head x) p (tail x) c
-- last line is clear, draw the player and continue by reducing the door distance.
s 5 (l,d) p x c = draw ' ' "^" p <> "[jkl]> " <> c ((l - 1, d) : x)
-- otherwise, draw the current line and recurse.
s n e@(l,d) p x c = (if (n==5-l) then draw '-' " " d else t) <> s (n+1) e p x c

-- | The main loop processing the user input.
type Score = Int
go :: Score -> World -> Position -> String -> String
go x m p i = "\ESCcpure-doors\n" <> s 0 (head m) p (tail m) (\m -> case (m,i) of
 (_:_, c:'\n':xs) | c > 'h' && c < 'n' -> go (x+1) m (p + fromEnum c - 107) xs
 _ -> (if x>5 then " GG, your score is: " <> show (div x 5) else "") <> "\n")

-- | Start the game.
main :: IO ()
main = interact (go (-1) world 3)
```

Note that the 9th door is impossible to pass, but there is a hidden trick:
use <kbd>i</kbd> and <kbd>m</kbd> to move the player by two :-)

Thanks for your time, have fun!
