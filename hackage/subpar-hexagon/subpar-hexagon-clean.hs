#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Import

type State =
    ( Int    -- ^ player position
    , Float  -- ^ Trippy rotation
    , Float  -- ^ "Enemy" size
    , [Bool] -- ^ "Enemy" pattern
    , Int    -- ^ PRNG
    , Int    -- ^ Score
    )

s0 :: State
s0 = (0, 0, 20, cycle (False:replicate 5 True), 1, 0)

main = play FullScreen white 60 s0 paint react step

hex :: [Bool] -> Picture
hex sides = foldMap (\(p1, p2) -> line [p1, p2]) [p | (p, b) <- take 6 $ zip ps sides, b]
  where
    ps = zip hexPoints (tail hexPoints)

hexPoints :: [Point]
hexPoints = cycle [(-1, 0), (-0.5, 0.87), (0.5, 0.87), (1, 0), (0.5,-0.87), (-0.5,-0.87)]

paint :: State -> Picture
paint (p, r, enemySize, enemyPattern, rng, score) =
    scale 5 5 $ rotate r $
    (translate 20 20 (rotate (-r) (text (show score))) <>) $
      scale s s $
        hex (repeat True) <>
        rotate 30 (uncurry translate (hexPoints!!p) $ circle 0.1) <>
        scale enemySize enemySize (hex enemyPattern)
  where
    s = 20 + 4 * sin (0.17 * r)

react :: Event -> State -> State
react (EventKey key Down _ _) (p, r, enemySize, enemyPattern, rng, score)
  | key == Char 'j' = ((p - 1)`mod`6, r, enemySize, enemyPattern, rng, score)
  | key == Char 'l' = ((p + 1)`mod`6, r, enemySize, enemyPattern, rng, score)
react _ s = s

step :: Float -> State -> State
step dt (p, r, enemySize, enemyPattern, rng, score)
    | enemySize > 1
    = (p, r + dt * 90, enemySize * 0.2**dt, enemyPattern, rng', score)
    -- = (p, r + dt * 90, enemySize - 10*dt, enemyPattern, rng', score)
    | otherwise
    = (p, r + dt * 90, 20, drop rng enemyPattern, rng', if hit then 0 else score + 1)
  where
    rng' = rng `div` 2 `xor` bool 0 96 (odd rng)
    hit = enemyPattern!!p
