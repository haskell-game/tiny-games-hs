#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Import

type State =
    ( Int    -- ^ player position
    , Float  -- ^ Trippy rotation
    , Float  -- ^ "Enemy" size
    , [Bool] -- ^ "Enemy" pattern
    , Int    -- ^ PRNG
    )

s0 :: State
s0 = (0, 0, 20, cycle (False:replicate 5 True), 1)

main = play FullScreen white 60 s0 paint react step

hex :: [Bool] -> Picture
hex sides = foldMap (\(p1, p2) -> line [p1, p2]) [p | (p, b) <- zip ps sides, b]
  where
    ps = zip hexPoints (tail hexPoints)

hexPoints :: [Point]
hexPoints = cyle [(-1, 0), (-0.5, 0.87), (0.5, 0.87), (1, 0), (0.5,-0.87), (-0.5,-0.87)]

paint :: State -> Picture
paint (p, r, enemySize, enemyPattern, rng) = rotate r $ scale s s $
    hex (repeat True) <>
    rotate 30 (uncurry translate (hexPoints!!p) $ circle 0.1) <>
    scale enemySize enemySize (hex enemyPattern)
  where
    s = 100 + 20 * sin (0.17 * r)

react :: Event -> State -> State
react (EventKey key Down _ _) (p, r, enemySize, enemyPattern, rng)
  | key == Char 'j' = ((p - 1)`mod`6, r, enemySize, enemyPattern, rng)
  | key == Char 'l' = ((p + 1)`mod`6, r, enemySize, enemyPattern, rng)
react _ s = s

step :: Float -> State -> State
step dt (p, r, enemySize, enemyPattern, rng)
    | enemySize > 1
    = (p, r + dt * 90, enemySize * 0.2**dt, enemyPattern, rng')
    -- = (p, r + dt * 90, enemySize - 10*dt, enemyPattern, rng')
    | not (enemyPattern!!p)
    = (p, r + dt * 90, 20, drop rng enemyPattern, rng')
  where
    rng' = rng `div` 2 `xor` bool 0 96 (odd rng)
