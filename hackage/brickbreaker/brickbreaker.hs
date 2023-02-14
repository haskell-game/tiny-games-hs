#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Graphics.Gloss;import Graphics.Gloss.Interface.IO.Interact;r=20;main=play
 FullScreen white 60(0,(0,-20),(8,16),(,)<$>[0,2..20]<*>[2,4..8])f g h;o b c|b=
 color c$thickCircle 1 99|True=blank;f(p,(x,y),_,bs)=scale r r$o(y< -20)red<>o(
 null bs)green<>line[(0,10),(22,10),(22,-11),(0,-11),(0,10)]<>line[(p-2,-10),(p+
 2,-10)]<>translate x y(circle 1)<>foldMap(\(x,y)->polygon[(x,y),(x+1.8,y),(x+
 1.8,y+1.8),(x,y+1.8)])bs;g(EventMotion(p,_))(_,b,bv,bs)=(p/r,b,bv,bs);g _ s=s;h
 t(p,(x,y),(v,w),bs)=(p,(x+v*t,y+w*t),(v',w'),bs')where{bs'=filter(\(bx,by)->bx<
 x||bx>x+2||by<y||by>y+2)bs;(v',w')|y< -10&&y> -11&&x>p-2&&x<p+2=((x-p)*10,abs w
 )|x<0||x>20=(-abs v*signum x,w)|y>10||bs/=bs'=(v,-abs w)|True=(v,w)}
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/brickbreaker (fgaz)

Copyright Francesco Gazzetta
SPDX-License-Identifier: EUPL-1.2

Move the pointer to move the paddle.
The ball is lost if it moves past the paddle.
Try to destroy all bricks!

Tip: the bottom of the ball has magical destructive properties, try to get it
above the bricks to destroy many at once.

Adjust the `r` variable if the game is too big or too small for your screen

Unminified version:

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
  (0, (0,-20), (8,16), (,) <$> [0,2..20] <*> [2,4..8])
  f g h;

-- Colored overlay when b is true
o :: Bool -> Color -> Picture
o b c | b = color c $ thickCircle 1 99
      | True = blank;

-- render
f :: State -> Picture
f (p, (x, y), _, bs) = scale r r $
  -- the win overlay (green) has to be drawn over the lose overlay (red), since
  -- if the ball is lost after a win, it's still a win
  o (y< -20) red <>
  o (null bs) green <>
  line [(0,10),(22,10),(22,-11),(0,-11),(0,10)] <>
  line [(p - 2, -10), (p + 2, -10)] <>
  translate x y (circle 1) <>
  foldMap (\(x, y) -> polygon [(x,y),(x+1.8,y),(x+1.8,y+1.8),(x,y+1.8)]) bs;

-- input
g :: Event -> State -> State
g (EventMotion (p, _)) (_, b, bv, bs) = (p/r, b, bv, bs);
g _ s = s;

-- step
h :: Float -> State -> State
h t (p, (x, y), (v, w), bs) = (p, (x+v*t,y+w*t), (v',w'), bs')
  where {
    bs' = filter (\(bx, by) -> bx < x || bx > x+2 || by < y || by > y+2) bs;
    (v', w') | y < -10 && y > -11 && x > p-2 && x < p+2 = ((x-p)*10, abs w)
             | x < 0 || x > 20 = (-abs v * signum x,w)
             | y > 10 || bs /= bs' = (v, -abs w)
             | True = (v, w)
  }

-}
