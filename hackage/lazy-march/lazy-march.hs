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

This demo implements a ray-marcher to render a λ sign. Learn more at:
  https://iquilezles.org/articles/raymarchingdf/

Alternative prelude-10-80 version:

p=[(x/80*2-1,(y/20*2-1)*0.2,-10)|y<-[0..20],x<-[0..80]];s=sin;c=cos;
l3(x,y,z)=sqrt(x*x+y*y+z*z); m3(x,y,z)=(max x 0, max y 0, max z 0);
sdBox h w (x,y,z)=l3(m3(abs x-w,abs y-h,abs z-0.03));o (x,y,z)=(x+0.05,y-0.4,z)
scene p = min (sdBox 0.8 0.05 (r 1 p)) (sdBox 0.4 0.04 (o (r (-1) p)))
r t (x,y,z)=(x*cos t-y*sin t,x*sin t+y*cos t,z);m _ 10 _ = " ";m _ 0(1,_,_)="\n"
m t n (x,y,z) = let a = x*cos(t)-z*sin t;c=x*sin(t)+z*cos t;d=scene(a,y,c)in
  if d <= 0.01 then "#" else m t (n+1) (x,y,z+d)
go (t,_) = "\ESCclazy-march\n" <> concatMap (m (t/2) 0) p
main = interact (foldMap go . zip [00..] . mappend "g")
-}
