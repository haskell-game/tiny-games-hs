#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss

-- Copyright Francesco Gazzetta
-- SPDX-License-Identifier: EUPL-1.2

import Graphics.Gloss;
import Graphics.Gloss.Interface.IO.Interact;

-- Scaling factor
r :: Float
r = 20;

type Position = (Float, Float)
type Velocity = (Float, Float)
-- paddle position, ball position, ball velocity, brick positions
type State = (Float, Position, Velocity, [Position])

main :: IO ()
main = play FullScreen white 60
  (0, (-10,-20), (8,16), (,) <$> [-10.9,-8.9..9.1] <*> [2,4..8])
  f g h;

-- Colored overlay when b is true
o :: Bool -> Color -> Picture
o b c | b = color c $ thickCircle 1 99
      | True = blank;

-- Square path
s :: Float -> (Float, Float) -> Path
s l c@(x, y) = [c,(x+l,y),(x+l,y+l),(x,y+l),c];

-- render
f :: State -> Picture
f (p, (x, y), _, bs) = scale r r $
  -- the win overlay (green) has to be drawn over the lose overlay (red), since
  -- if the ball is lost after a win, it's still a win
  o (y< -20) red <>
  o (null bs) green <>
  line (s 22 (-11,-11)) <>
  line [(p - 2, -10), (p + 2, -10)] <>
  translate x y (circle 1) <>
  foldMap (polygon . s 1.8) bs;

-- input
g :: Event -> State -> State
g (EventMotion (p, _)) (_, b, bv, bs) = (p/r, b, bv, bs);
g _ a = a;

-- step
h :: Float -> State -> State
h t (p, (x, y), (v, w), bs) = (p, (x+v*t,y+w*t), (v',w'), bs')
  where {
    bs' = filter (\(bx, by) -> bx > x || bx+2 < x || by > y || by+2 < y) bs;
             -- Bounce on paddle, adjust horizontal velocity
             -- depending on bounce location
    (v', w') | y < -10 && y > -11 && x > p-2 && x < p+2 = ((x-p)*10, abs w)
             -- Bounce on left and right walls
             | x < -10 || x > 10 = (-abs v * signum x,w)
             -- Bounce on top wall and bricks.
             -- Computing the brick bounce direction takes a lot of space,
             -- so we only bounce in the most likely direction, and that's why
             -- the bottom of the ball is special :D
             | y > 10 || bs /= bs' = (v, -abs w)
             | True = (v, w)
  }
