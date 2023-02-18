# lambda-ray

This demo renders a rotating Haskell logo in 3D.

<img src="lambda-ray.gif" title="Playing the game">

## Playing

- Slow version: `runhaskell lambda-ray.hs`
- Fast version: `ghc -O2 lambda-ray.hs && ./lambda-ray`
- Stack script: `stack script --resolver lts-20 --optimize lambda-ray.hs`

## Documentation

This demo is a follow-up on [lazy-march](../../hackage/lazy-march).
It uses the same ray-marcher technique, and I encourage you to checkout
[Inigo Quilez website](https://iquilezles.org/) for more information on the subject.

Thanks to the minification tricks presented in the issue#52,
this demo features the missing bits I wanted to do with lazy-march.

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env -S stack script --resolver lts-20 --optimize
-- | lambda-ray expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

-- 'Control.Concurrent' is needed to pause between frames.
import Control.Concurrent (threadDelay)

-- 'puts' enables drawing in one syscall to avoid flickering.
-- This only works with ascii though.
import System.Posix.Internals (puts)

type V3 = (Float, Float, Float)
type Distance = Float

-- | The rendering area in pixel
cols, rows, screenRatio :: Float
cols = 100
rows = 20
screenRatio = rows / cols

-- | uvs are the normalized pixel coordinate with (0,0) in the center.
uvs =
    [ (x / cols * 2 - 1, (y / rows * 2 - 1) * screenRatio)
    | y <- [0 .. rows]
    , x <- [0 .. cols + 1]
    ]

-- | The render loop
go :: Float -> IO ()
go n = do
    puts $ "\ESCc" <> (map (pixelColor (n / 6)) uvs)
    threadDelay 100000
    go (n + 1)

-- | Start the render loop at t=0
main :: IO ()
main = go 0

-- | Render a single pixel
pixelColor _ (1.02, _) = '\n'
pixelColor t (x, y) = rayCast t 0 (10 * x, 10 * y, -5)

-- | The signed-distance function of a box
-- This is missing the @min(max(width,max(height,depth)),0.0)@ component, but that somehow work...
sdBox :: Float -> Float -> V3 -> Distance
sdBox height width (x, y, z) = sqrt (a ** 2 + b ** 2 + c ** 2)
  where
    a = max (abs x - width) 0
    b = max (abs y - height) 0
    c = max (abs z - depth) 0
    depth = 0.4

-- | The signed-distance function of the Haskell logo
--
--  \  \k
--  i\  \     m
--    \  \  -----
--    /  /\  ----
--  j/  /l \
--  /  /    \
--
sdHaskell :: V3 -> Distance
sdHaskell p@(x, y, z) =
    let
        -- The first segment
        ijOffset = (x + 3, y, z)
        i | y >= 0 = sdBox 5 0.4 (rotXY (-1) ijOffset) | o = 9
        j | y  < 0 = sdBox 5 0.4 (rotXY   1  ijOffset) | o = 9

        -- The straight bar
        k          = sdBox 5 0.4 (rotXY   1  p)

        -- The lambda leg
        l | y >= 0 = sdBox 5 0.4 (rotXY (-1) p) | o = 9

        -- The equal sign
        eqBar s    = sdBox 6 0.2 (rotXY (pi / 2) (x - 1, y + s * 0.4, z))
        eqBars     = min (eqBar 1) (eqBar (-1))
        mask       = sdBox 5 2   (rotXY 1 (x - 6, y, z))
        -- The intersection of the mask and the horizontal bars.
        m = max eqBars mask
     in
        -- The union of all the segments
        min i $ min j $ min k $ min l m

-- | Rotation on the XY plane
rotXY :: Float -> V3 -> V3
rotXY angle (x, y, z) =
    ( x * cos angle - y * sin angle
    , x * sin angle + y * cos angle
    , z
    )

-- | Rotation on the XZ plane
rotXZ :: Float -> V3 -> V3
rotXZ angle (x, y, z) =
    ( x * cos angle - z * sin angle
    , y
    , x * sin angle + z * cos angle
    )

-- | March the ray
rayCast :: Float -> Int -> V3 -> Char
rayCast _ 20 _ = ' '
rayCast angle n p@(x, y, z) =
    let
        -- Animate by rotating the coordinate
        (rx,ry,rz) = rotXZ angle p

        -- Get the distance to the haskell logo
        distance = sdHaskell (rx, ry, rz)

        -- Crappy normal approximation by casting a couple of rays around the hit point
        eps = 0.01
        nz = sdHaskell (rx, ry, rz + eps) - sdHaskell (rx, ry, rz - eps)
        ny = sdHaskell (rx, ry + eps, rz) - sdHaskell (rx, ry - eps, rz)

        lightColor | nz < 0 = 'o' -- the point is facing the camera
                   | ny < 0 = '>' -- the point is facing upward
                   | o = '.'      -- the point is on the back
        color | distance < 0.01 = lightColor -- the ray hit the logo
              | o = rayCast angle (n + 1) (x, y, z + distance)
     in
        color

o = True
```
