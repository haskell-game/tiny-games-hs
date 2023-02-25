# tiny-brot

A fractal demo.

<img src="tiny-brot.gif" title="Playing the game">

## Playing

tiny-brot draws the mandelbrot set, press <kbd>enter</kbd> to zoom.

Start by running [./tiny-brot.hs](tiny-brot.hs).

## Documentation

The main challenge is finding a good location and zoom function to
reveals self-similar pattern.

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env runhaskell
-- | tiny-brot expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

-- | Render area.
width, height :: Float
width = 80
height = 24

-- | Screen ratio.
screenRatio :: Float
screenRatio = (-0.5)

-- | Compute z = z*z + c.
type Complex = (Float, Float)

z2c :: Complex -> Complex -> Complex
z2c (cx, cy) (x, y) = (cx + (x * x - y * y), cy + 2 * x * y)

-- | The location of the tiny brot.
miniBrot :: Complex
miniBrot = (-1.4844, 0)

-- | Compute a smooth zoom.
type Time = Float

type Zoom = Float
zoom :: Time -> Zoom
zoom time = 4.18 - 4.179 * (1 - cos (time / 10) ** 8)

-- | Convert a screen coordinate to a plane coordinate.
type Coord = (Float, Float)

coord :: Zoom -> Complex -> Coord -> Complex
coord z (c, d) (x, y) =
    ( c + z * (x - width / 2) / width
    , (d + z * (y - height / 2) / height) * screenRatio
    )

-- | Compute the length of a complex number.
dot :: Complex -> Float
dot (x, y) = let l = abs (x * y) in if isNaN l then 42 else l

-- | Iterate the mandelbrot function.
brot :: Int -> Complex -> Float
brot max_iter p = dot . last . take max_iter . iterate (z2c p) $ (0, 0)

-- | Draw a single pixel.
draw :: Zoom -> Coord -> String
draw _ (81, _) = "\n"
draw z c = if brot 150 (coord z miniBrot c) > 20 then " " else "λ"

-- | The list of screen coordinate.
points :: [Coord]
points = [(x, y) | y <- [0 .. height], x <- [0 .. width + 1]]

-- | Draw the fractal.
go :: (Time, Char) -> String
go (x, _) = "\ESCctiny-brot\n" <> concatMap (draw (zoom x)) points

-- | Start the game, adding a time increment to each input.
main :: IO ()
main = interact (foldMap go . zip [0 ..] . mappend "g")
```
