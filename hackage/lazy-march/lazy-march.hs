#!/usr/bin/env -S stack script --resolver lts-20 --package ansi-terminal-game
import Terminal.Game;w=80;h=20;go t=foldr (m (t/10) 0)(blankPlane (i w) (i h)) p
p=[(i x, i y, (x/w*2-1, (y/h*2-1)*0.2, -10)) | y<-[0..h], x<-[0..w]];s=sin;c=cos
main=playGame (Game 13 0 (\_ t _->t+1) (const go) (const False));i=round
l3 (x,y,z)=sqrt(x*x+y*y+z*z);m3 (x,y,z)=(max x 0, max y 0, max z 0)
sdBox h w (x,y,z)=l3(m3(abs x-w,abs y-h,abs z-0.03));o(x,y,z)=(x+0.05, y-0.4, z)
scene p=min (sdBox 0.8 0.05 (rot 1 p)) (sdBox 0.4 0.04 (o (rot (-1) p)))
rot t (x,y,z)=(x*cos t - y*sin t, x*sin t + y*cos t, z);m _ 10 _ = id
m t n (ix,iy,(x,y,z))=let a=x*cos(t)-z*sin t;c=x*sin(t)+z*cos t;d=scene(a,y,c)in
  if d <= 0.01 then (iy,ix) % cell '%' else m t (n+1) (ix,iy,(x,y,z+d))
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/lazy-march (tristanC)

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
