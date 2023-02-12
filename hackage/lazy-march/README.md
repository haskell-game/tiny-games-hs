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
w, h :: Float
w = 80
h = 20

-- | Convert a float.
i :: Float -> Int
i = round

-- | Screen coordinates along with the associated 3d positions.
p :: [(Int, Int, V3)]
p = [(i x, i y, (x/w*2-1, (y/h*2-1)*0.2, -10)) | y <- [0..h], x <- [0..w]]

-- | Compute the length of a position.
l3 :: V3 -> Float
l3 (x,y,z) = sqrt (x*x + y*y + z*z)

-- | Clamp a position.
m3 :: V3 -> V3
m3 (x,y,z) = (max x 0, max y 0, max z 0)

-- | The signed distance function of a box.
sdBox :: Float -> Float -> V3 -> Float
sdBox h w (x, y, z) = l3(m3(abs x-w, abs y-h, abs z-0.03))

-- | Rotate a position on the XY plane.
rot :: Float -> V3 -> V3
rot t (x,y,z) = (x*cos t - y*sin t, x*sin t + y*cos t, z)

-- | Offset the lambda leg position.
o :: V3 -> V3
o (x,y,z) = (x + 0.05, y - 0.4, z)

-- | The scene combine two boxes to form the λ segments.
scene :: V3 -> Float
scene p = min (sdBox 0.8 0.05 (rot 1 p)) (sdBox 0.4 0.04 (o (rot (-1) p)))

-- | The ray marching function.
m :: Time -> Int -> (Int, Int, V3) -> (Plane -> Plane)
m _ 10 _ = id -- stop after 10 steps
m t n (ix,iy,(x,y,z)) =
  let
    -- rotate the starting position on the XZ plane
    a = x * cos t - z * sin t
    c = x * sin t + z * cos t
    -- get the current distance
    d = scene (a,y,c)
  in
    if d <= 0.01
      -- we hit the scene
      then (iy,ix) % cell '%'
      -- otherwise we keep marching
      else m t (n+1) (ix, iy, (x, y, z+d))

-- | Render a single frame.
go :: Float -> Plane
go t = foldr (m (t/10) 0) (blankPlane (i w) (i h)) p

-- | Start the animation.
main :: IO ()
main = playGame (Game 13 0 (\_ t _->t+1) (const go) (const False))
```

Here is an alternative prelude-10-80 version that uses a keyboard input to advance.
In the end I used `ansi-terminal-game` to make it runs automatically.

```
p=[(x/80*2-1,(y/20*2-1)*0.2,-10)|y<-[0..20],x<-[0..80]];s=sin;c=cos;
l3(x,y,z)=sqrt(x*x+y*y+z*z); m3(x,y,z)=(max x 0, max y 0, max z 0);
sdBox h w (x,y,z)=l3(m3(abs x-w,abs y-h,abs z-0.03));o (x,y,z)=(x+0.05,y-0.4,z)
scene p = min (sdBox 0.8 0.05 (r 1 p)) (sdBox 0.4 0.04 (o (r (-1) p)))
r t (x,y,z)=(x*cos t-y*sin t,x*sin t+y*cos t,z);m _ 10 _ = " ";m _ 0(1,_,_)="\n"
m t n (x,y,z) = let a = x*cos(t)-z*sin t;c=x*sin(t)+z*cos t;d=scene(a,y,c)in
  if d <= 0.01 then "#" else m t (n+1) (x,y,z+d)
go (t,_) = "\ESCclazy-march\n" <> concatMap (m (t/2) 0) p
main = interact (foldMap go . zip [00..] . mappend "g")
```
