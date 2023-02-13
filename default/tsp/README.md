# TSP - Tiny Space Program

You are a rocket pilot flying for the Tiny Space Agency (TSA).
Your goal is to deliver curry to the Tiny Space Station (TSS).
There is no time to loose, you need to go as fast as possible.
The world record, by Simon Kerman Jones, is under 9.9 seconds.

![Playing the game](tsp.gif)


## Playing

Instructions:

- The game starts with your ship `>` attached to the launch pad clamp `--,`.
- Press <kbd>f</kbd> to fire the engine at full throttle.
- After a 3 seconds countdown, the ship is released and you lift off.
- Release <kbd>f</kbd> when you have enough speed to reach the TSS `~|~`.
- After you reach the station you need to go back and land on the launch pad.
- Your ship is equiped with retrograde thrusters that you can activate with <kbd>r</kbd>.
- On your way down, reduce your vertical velocity by pressing <kbd>f</kbd> again.
- To survive the landing, your velocity must be over `-50`.
- When the delivery trip is completed, your travel time*10 is printed.
- Good luck!

Start by running: runhaskell [./tsp.hs](tsp.hs)


## Documentation

This game implements a render loop using the bytestring `hGetNonBlocking` and `hPut`.

Here is the less-minified version with type annotations:

```haskell
#!/usr/bin/env runhaskell
-- | tsp expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC-BY-4.0

-- | 'System.IO' to setup the terminal
import System.IO (stdin, stdout, hSetBuffering, hSetEcho, BufferMode(NoBuffering))

-- | 'Control.Concurrent' for sleep
import Control.Concurrent (threadDelay)

-- | 'Data.ByteString' to do bulk and non-blocking I/O
import Data.ByteString (elemIndices, hGetNonBlocking, hPut)
import Data.ByteString.Char8 (pack)

-- | For type annotations
import Data.ByteString (ByteString)

type Time = Int
type Velocity = Float
type World =
  ( Time     -- Time, in deci-second
  , Float    -- Position
  , Velocity -- Velocity
  , Float    -- Max height
  , Char     -- Engine plume
  )

-- | The initial world, with a 3 seconds countdown encoded as a negative value.
i :: World
i = (-30, 0, 0, 0, ' ')

-- | Render the countdown.
c :: Time -> String
c t | t<0 = show (t`div`10)
    | o   = ""

-- | 'q' prints the string in a single write syscall, to avoid cursor flickering.
q :: String -> IO ()
q = hPut stdout . pack

-- | 'o' is used for minifying function guard to do tight if-then-else.
o :: Bool
o = True

-- | Render the ship.
s :: Velocity -> String
s v | v>=0 = ">"
    | o    = "<"

-- | Render the world.
p :: Int -> World -> String
p 0 (_,p,v,_,_) = "VEL " ++ show v ++ " | ALT " ++ show p
p 1 _           = "--," ++ [' ' | _ <- [0..69]] ++ "~|~"
p 2 (t,p,v,_,f) = [' ' | _ <- [0..floor(p/40)]] ++ f:s v ++ c t

-- | Print the world.
r :: World -> IO ()
r s = q $ "\ESCc=<< TSP >>=   | " ++ unlines (map (flip p s) [0..2])

-- | Process the input and compute the next world.
e :: World -> ByteString -> IO ()
e (t,p,v,h,_) i =
  let
    -- 'j' look for a given byte in the input buffer
    j = (/= [] ) . flip elemIndices i
    -- has f been pressed?
    f = j 102
    -- has r been pressed?
    r = j 114
    -- set the engine plume
    g | f = '*'
      | r = '['
      | o = ' '
    -- the engine thrust
    n | f = 5
      | r = (-5)
      | o = 0
    -- adjust the position (gravity is 1)
    q = max 0 (p + v - 1)
    -- check if countdown is running
    c | t < 0 = 0
      | o     = 1
  in if (q == 0 && h > 2900)
      then -- the ship is on the ground, back from the TSS
           z t v
      else go (
        -- increase time
        t + 1,
        -- new position
        c * q,
        -- new velocity
        c * (v + n - 1),
        -- record max height
        max h p,
        -- the plume
        g)

-- | This is the end.
z :: Time -> Velocity -> IO ()
z t v | v > (-50) = print t
      | o         = q ""

-- | The game loop.
go :: World -> IO ()
go s = do
  r s
  threadDelay 100000
  input <- hGetNonBlocking stdin 42
  e s input

-- | Setup the terminal and starts the game loop.
main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetEcho stdin False
  go i
```
