#!/usr/bin/env runhaskell
w=80;h=24;z2 (cx,cy) (x,y) = (cx +(x*x-y*y), cy +2*x*y)
r=(-0.5);p=[(x,y)|y<-[0..h],x<-[0..w+1]];mb=(-1.4844,0)
main = interact (foldMap go . zip [00..] . mappend "g")
dot (x,y) = let l=abs(x*y) in if isNaN l then 42 else l
coord z (c,d)(x,y) = (c+z*(x-w/2)/w, (d+z*(y-h/2)/h)*r)
brot c p = dot . last . take c . iterate (z2 p) $ (0,0)
zoom x = 4.18-4.179*(1-cos(x/10)**8); d _ (81,_) = "\n"
d z c = if brot 150 (coord z mb c)>20 then " " else "λ"
go (x,_)="\ESCctiny-brot\n" <> concatMap (d (zoom x)) p
-- ^10 ----------------------------------------- 55> --
{- prelude-10-80/tiny-brot (tristanC)

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
