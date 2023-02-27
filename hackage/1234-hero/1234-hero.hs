#!/usr/bin/env stack
-- stack script --compile --resolver=lts-20 --package gloss --package random
import Imports;m(x,y)=translate x y;z x=scale x x;f=fromIntegral;w=show;t=text
main=do{g<-getStdGen;play(InWindow""(512,512)(0,0))white 30(randomRs(1,4)g,0,16,
0)(\(g,s,y,h)->z 16$m(0,-13)(rectangleWire 33 2)<>foldMap(\x->m(-20+8*f x,-13.5)
(z 0.01$t$w$x))[1..4]<>(m(-12,-9)$z 0.05$t$w s<>(guard(s/=h)>>("/"<>w h)))<>
foldMap(\(i,x)->let h=8*i+y in m(-20+8*f x,-13+h)$if h< -2 then z 0.02$t"x"else
rectangleSolid 8 2)(zip[0..]$take 5 g))(\e o@(x:g,s,y,h)->case e of{EventKey(
Char k)Down _ _|y> -2&&y<1&&ord k-ord '0'==x->(g,s+1,y+8,h`max`(s+1));_->o})(\d(
g,s,y,h)->let{z=y-(8+f s/4)*d}in if z< -4then(drop 1 g,0,z+8,h)else(g,s,z,h))}
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/1234-hero (gelisam)

-}
