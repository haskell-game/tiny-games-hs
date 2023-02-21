#!/usr/bin/env -S stack script --resolver=lts-20.10 --package ansi-terminal-game
import Imports

type Point = (Int, Int)
type State =
    ( [Point] -- Snake body
    , Point   -- Current direction
    , Point   -- Next food
    , Int     -- PRNG
    , Int     -- Score
    )

state0 :: State
state0 = ([(12, 20)], (0,1), (12,21), 99, 0)

main = playGame $ Game 15 state0 logic draw end

end ((p@(y, x):snake), _, _, _, _) = y<2 || y>23 || x < 2 || x > 79 || p `elem` snake

logic _ (snake@((y, x):_), d@(dy, dx), food, rng, score) e
  | h == food
  = ((y', x'):snake, d', (2 + ny `rem` 20, 2 + nx `rem` 76), rng', score + 1)
  | otherwise
  = ((y', x'):init snake, d', food, rng', score)
  where
    h@(y', x') = (y + dy, x + dx)
    (nx, ny) = rng `divMod` 40
    rng' = rng `div` 2 `xor` bool 0 0xe08 (odd rng)
    d' | KeyPress k <- e = move d k
       | otherwise = d

move d 'w' = (-1, 0)
move d 'a' = (0, -1)
move d 's' = (1, 0)
move d 'd' = (0, 1)
move d _ = d

draw _ (snake, _, food, _, _) = mergePlanes (box 80 24 '*') $
  ((2, 2), blankPlane 78 22) :
  (food, cell '*'):
  [(p, cell '#') | p <- snake]
