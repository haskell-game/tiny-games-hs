#!/usr/bin/env -S stack script --resolver=lts-20.10 --package ansi-terminal-game
import Import

type State =
    ( [Coords] -- ^ Snake body
    , Coords   -- ^ Current direction
    , Coords   -- ^ Next food
    , Int      -- ^ PRNG
    , Int      -- ^ Score
    )

state0 :: State
state0 = ([(12, x) | x <- [10..16]], (0,-1), (16,21), 99, 0)

main = playGame $ Game 12 state0 logic draw end

end ((p@(y, x):snake), _, _, _, _) = y < 2 || y > 23 || x < 1 || x > 39 || p `elem` snake

logic :: GEnv -> State -> Event -> State
logic _ (snake@((y, x):_), d@(dy, dx), food, rng, score) e
  | h == food
  = consistent ((y', x'):snake, d', (y', x'), rng, score + 1)
  | otherwise
  = ((y', x'):init snake, d', food, rng, score)
  where
    h@(y', x') = (y + dy, x + dx)
    d' | KeyPress k <- e = move d k
       | otherwise = d

move (0, _) 'i' = (-1, 0)
move (_, 0) 'j' = (0, -1)
move (0, _) 'k' = (1, 0)
move (_, 0) 'l' = (0, 1)
move d _ = d

draw :: GEnv -> State -> Plane
draw _ (snake, _, food, _, score) = mergePlanes (box 80 24 '▒') $
  ((2, 2), blankPlane 78 22) :
  ((2*) <$> food, word (glyph score)) :
  [((2*) <$> p, word "██") | p <- snake]

glyph :: Int -> String
glyph score = take 2 . drop (3 * score) . cycle $ "∀∃⊥⊢⊤⊨∨∧⇒λ→ΣΠη"

consistent s@(snake, dir, food, rng, score)
  | food `elem` snake = consistent (snake, dir, food', rng', score)
  | otherwise = s
  where
    rng' = rng `div` 2 `xor` bool 0 0xe08 (odd rng)
    (y, x) = rng `divMod` 38
    food' = (2 + y `rem` 20, 2 + x)
