# flower-seeds

Use this game to draw a flower for your Valentine.

![Playing the game](flower-seeds.png)


## Playing

flower-seeds draws sunflower seeds distribution pattern.
You can adjust the parameters with:

- <kbd>j</kbd>/<kbd>l</kbd> : the growth angle.
- <kbd>k</kbd>/<kbd>i</kbd> : the growth distance.
- <kbd>c</kbd>/<kbd>v</kbd> : the seed count.

Start by running [./flower-seeds.hs](flower-seeds.hs).
Your terminal needs to be at least 120x50.

The parameters are printed at the top of the screen.
You can pass them as program argument to redraw your best flower:

```ShellSession
./flower-seeds.hs "(11.0,5.0,47)"
```


## Documentation

This game is based on this video: [The Golden Ratio (why it is so irrational) - Numberphile](https://www.youtube.com/watch?v=sj8Sg8qnjOg).

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env runhaskell
-- | flower-seeds expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

-- | 'System.IO' to setup the terminal
import System.IO (stdin, hSetBuffering, BufferMode(NoBuffering))

-- | 'Control.Concurrent' for sleep
import Control.Concurrent (threadDelay)

-- | 'System.Environment' to get command line arguments
import System.Environment (getArgs)

type Flower =
  ( Float -- Angle
  , Float -- Distance
  , Int   -- Numbers
  )

-- | The initial params.
initialParams :: Flower
initialParams = (29.6, 3, 400)

-- | Generate the seed params.
genSeeds :: Flower -> [(Float, Float)]
genSeeds (a, d, n) = take n $ iterate (\(b, e) -> (b + pi * a/90, e + d/30)) (0,0)

-- | Get a seed coordinate.
seedCoord :: (Float, Float) -> (Int, Int)
seedCoord (a, d) = (round (60 + d*cos a), round (0.5*(50 + d*sin a)))

-- | Plant a seed.
plantSeed :: (Int, Int) -> IO ()
plantSeed (x, y) = do
  threadDelay 1000
  putStrLn ("\^[[" ++ show y ++ ";" ++ show x ++ "f❤")

-- | Render the flower.
renderFlower :: Flower -> IO [()]
renderFlower flower = do
  putStrLn ("\^[cflower-seeds " <> show flower)
  traverse (plantSeed . seedCoord) (genSeeds flower)

-- | Evaluate the user input.
evalInput :: Flower -> Char -> IO ()
evalInput (a, d, n) i =
  let b | i == 'j' = (-1)
        | i == 'l' = 1
        | otherwise= 0
      e | i == 'k' = (-1)
        | i == 'i' = 1
        | otherwise= 0
      m | i == 'c' = (-1)
        | i == 'v' = 1
        | otherwise= 0
  in go
      ( -- angle
        a + b/20
      , -- distance
        max 0.1 (d + e/10)
      , -- count
        max 1 (n + m*17)
      )

-- | The game loop.
go :: Flower -> IO ()
go flower = do
  renderFlower flower
  input <- getChar
  evalInput flower input

-- | Setup the terminal, parse the arguments and start the game.
main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  args <- getArgs
  case args of
    [] -> go initialParams
    (x:_) -> go (read x)
```
