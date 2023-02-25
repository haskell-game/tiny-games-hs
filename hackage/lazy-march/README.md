# lazy-march

A 3d render demo.

<img src="lazy-march.gif" title="Playing the game">

## Playing

lazy-march renders a rotating λ sign.

Start by running [./lazy-march.hs](lazy-march.hs).

## Documentation

This demo implements a ray-marcher. Learn more at:
  [https://iquilezles.org/articles/raymarchingdf/](https://iquilezles.org/articles/raymarchingdf/).

With a bit more room, the demo could feature:
- the full `>>=` haskell logo.
- illumination using the hit point normal.

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env -S stack script --resolver lts-20 --package ansi-terminal-game
-- | lazy-march expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

import Terminal.Game

type V3 = (Float, Float, Float)
type Time = Float

-- | Render area.
width, height, screenRatio :: Float
width = 80
height = 20
screenRatio = 0.2

-- | Screen coordinates along with the associated 3d positions.
points :: [(Int, Int, V3)]
points =
    [ ( round x
      , round y
      ,
          ( x / width * 2 - 1
          , (y / height * 2 - 1) * screenRatio
          , -10
          )
      )
    | y <- [0 .. height]
    , x <- [0 .. width]
    ]

-- | Compute the length of a position.
dot :: V3 -> Float
dot (x, y, z) = sqrt (x * x + y * y + z * z)

-- | Clamp a position.
clamp :: V3 -> V3
clamp (x, y, z) = (max x 0, max y 0, max z 0)

-- | The signed distance function of a box.
sdBox :: Float -> Float -> V3 -> Float
sdBox height width (x, y, z) =
    dot . clamp $
        ( abs x - width
        , abs y - height
        , abs z - 0.03
        )

-- | Rotate a position on the XY plane.
rot :: Float -> V3 -> V3
rot t (x, y, z) = (x * cos t - y * sin t, x * sin t + y * cos t, z)

-- | Offset the lambda leg position.
offset :: V3 -> V3
offset (x, y, z) = (x + 0.05, y - 0.4, z)

-- | The scene combine two boxes to form the λ segments.
scene :: V3 -> Float
scene p = min (sdBox 0.8 0.05 (rot 1 p)) (sdBox 0.4 0.04 (offset (rot (-1) p)))

-- | The ray marching function.
march :: Time -> Int -> (Int, Int, V3) -> (Plane -> Plane)
march _ 10 _ = id -- stop after 10 steps
march time step (ix, iy, (x, y, z)) =
    let
        -- rotate the starting position on the XZ plane
        rx = x * cos time - z * sin time
        rz = x * sin time + z * cos time
        -- get the current distance
        distance = scene (rx, y, rz)
     in
        if distance <= 0.01
            then -- we hit the scene
                (iy, ix) % cell '%'
            else -- otherwise we keep marching
                march time (step + 1) (ix, iy, (x, y, z + distance))

-- | Render a single frame.
go :: Float -> Plane
go time = foldr (march (time / 10) 0) (blankPlane (round width) (round height)) points

-- | Start the animation.
main :: IO ()
main = playGame (Game 13 0 (\_ time _ -> time + 1) (const go) (const False))
```
