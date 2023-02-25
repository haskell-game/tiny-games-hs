# Snake

Category: base-10-80
Tested with: GHC 9.2.6
Author: @akshaymankar

Classic game of snake, control the snake using WASD (up,left,down,right).
Limitations:
1. Pressing invalid key would make the snake "fall down".
2. Snake overlapping itself would not immediately end the game, but will show
up as 'X'. In fact real snakes can do this all the time!
3. The snake only moves when it is asked to move, i.e. there are no automatic
movements making the game much easier

## Runnnig

Only tested on linux: Execute `snake.hs` while `runhaskell` available in
`$PATH`. It _should_ just work on other Operating Systems 🤞

## Notes

Game is fairly straightforward. It doesn't handle the lose condition because
there wasn't enough space, but it shows the mistake so it makes for a friendlier
game.

## Better formatted code

This is just output of pasting the minified code into https://ormolu-live.tweag.io/

```haskell
#!/usr/bin/env runhaskell
import GHC.Clock
import System.IO

q p a b = if p then a else b

i = [(0, 0)]

w = [0 .. 25]

p s f =
  putStrLn . ("\27[2J\27[1;1H" <>) . unlines $
    ["WASD Snake"]
      <> t
      <> map
        ( \x ->
            "|"
              <> map
                ( \y -> case filter (== (x, y)) s of [] -> (q ((x, y) == f) '#' ' '); [_] -> '*'; _ -> 'X'
                )
                w
              <> "|"
        )
        u
      <> t

main = hSetBuffering stdin NoBuffering >> (i,) <$> h i >>= g

t = [replicate 28 '-']

c
  s = filter (`notElem` s) $ concatMap (\x -> map (\y -> (x, y)) w) u

h s =
  (c s !!)
    . ( `mod`
          ( length
              ( c s
              )
          )
      )
    . fromEnum
    . (`div` 1000)
    <$> getMonotonicTimeNSec

m ((x, y) : _) i = ( \(a, b) ->
                       ( a
                           `mod` 10,
                         b `mod` 26
                       )
                   )
  $ case i of 'd' -> (x, y + 1); 'a' -> (x, y - 1); 'w' -> (x - 1, y); _ -> (x + 1, y)

g
  ( s,
    f
    ) =
    p s f
      >> getChar
      >>= (\h -> pure $ m s h : q (m s h == f) s (init s))
      >>= ( \t ->
              (t,)
                <$> q
                  ( head
                      t
                      == f
                  )
                  (h t)
                  (pure f)
          )
      >>= g

u = [0 .. 9]
-- ^ 10 ------------------------------------------------------------------ 80> --
--
--  Category: base-10-80
--  Tested with: GHC 9.2.6
--  Author: @akshaymankar
--
--  Classic game of snake, control the snake using WASD (up,left,down,right).
--  Limitations:
--  1. Pressing invalid key would make the snake "fall down".
--  2. Snake overlapping itself would not immediately end the game, but will show
--  up as 'X'. In fact real snakes can do this all the time!
--  3. The snake only moves when it is asked to move, i.e. there are no automatic
--  movements making the game much easier
```
