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
world :: World
world = (-30, 0, 0, 0, ' ')

-- | Render the countdown.
countDown :: Time -> String
countDown time | time < 0  = show (time `div` 10)
               | otherwise = ""

-- | 'q' prints the string in a single write syscall, to avoid cursor flickering.
q :: String -> IO ()
q = hPut stdout . pack

-- | Render the ship.
ship :: Velocity -> String
ship velocity | velocity >= 0 = ">"
              | otherwise     = "<"

-- | Render the world.
renderWorld :: Int -> World -> String
renderWorld 0 (_,pos,vel,_,_) = "VEL " ++ show vel ++ " | ALT " ++ show pos
renderWorld 1 _               = "--," ++ [' ' | _ <- [0..69]] ++ "~|~"
renderWorld 2 (t,p,v,_,plume) = [' ' | _ <- [0..floor(p/40)]] ++ plume : ship v ++ countDown t

-- | Print the world.
printWorld :: World -> IO ()
printWorld world = q $ "\ESCc=<< TSP >>=   | " ++ unlines (map (flip renderWorld world) [0..2])

-- | Process the input and compute the next world.
eval :: World -> ByteString -> IO ()
eval (time, position, velocity, height, _plume) input =
  let
    -- 'j' look for a given byte in the input buffer
    has = (/=[] ) . flip elemIndices input
    -- has f been pressed?
    f = has 102
    -- has r been pressed?
    r = has 114
    -- set the engine plume
    plume | f = '*'
          | r = '['
          | otherwise = ' '
    -- the engine thrust
    n | f = 5
      | r = (-5)
      | otherwise = 0
    -- adjust the position (gravity is 1)
    newPosition = max 0 (position + velocity - 1)
    -- check if countdown is running
    cd | time < 0  = 0
       | otherwise = 1
  in if (newPosition == 0 && height > 2900)
      then -- the ship is on the ground, back from the TSS
           gameOver time velocity
      else go (
        -- increase time
        time + 1,
        -- new position
        cd * newPosition,
        -- new velocity
        cd * (velocity + n - 1),
        -- record max height
        max height position,
        -- the plume
        plume)

-- | This is the end.
gameOver :: Time -> Velocity -> IO ()
gameOver t v | v > (-50) = print t
             | otherwise = q "Lost\n"

-- | The game loop.
go :: World -> IO ()
go world = do
  printWorld world
  threadDelay 100000
  input <- hGetNonBlocking stdin 42
  eval world input

-- | Setup the terminal and starts the game loop.
main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetEcho stdin False
  go world
```
