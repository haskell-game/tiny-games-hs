#!/usr/bin/env stack
-- stack script --compile --resolver=lts-20.9 --package gloss --package random
import Imports;m(x,y)=translate x y;z x=scale x x;f=fromIntegral;t=text.show
main=do{g<-getStdGen;play(InWindow""(512,512)(0,0))white 30(randomRs(1,4)g,0,16)
(\(g,s,h)->z 16$m(0,-13)(rectangleWire 33 2)<>foldMap(\x->m(-20+8*f x,-13.5)(z
0.01$t x))[1..4]<>(m(-9,-3)$z 0.1$t s)<>foldMap(\(y,x)->m(-20+8*f x,-13+8*y+h)$
rectangleSolid 8 2)(zip[0..]$take 5 g))(\e o@(x:g,s,h)->case e of{EventKey (Char
k) Down _ _|h> -2&&h<1&&ord k-ord '0'==x->(g,s+1,h+8);_->o})(\dt(g,s,h)->let{i=h
-(8+f s/4)*dt}in if i< -4then(drop 1 g,0,i+8)else(g,s,i))}

-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-hackage/1234-hero (gelisam)

-}
