#!/usr/bin/env -S stack script --resolver=lts-20 --package ansi-terminal-game
import Imports;main=playGame(Game 6(p!!0,r 20 0)l d(\_->False));z=zipWith;h=map
p=[[[120],[32,32,32,32]],[[32,112],[32,48,32],[112,32],[32,96,32]],l,y$m l,z,m z
 ,[[48,48]]]where{m=h y;l=[[16,112],[32,32,48],[112,64],[48,16,16]];z=[[24,48],[
 32,48,16]]};u=unlines.h(\r->foldMap(bool "  ""▇▉".testBit (r*8))[0..14]);a(p,f)
 =t((p!!0)++repeat 0)f;w=t(r 19 2049++[4095]);r=replicate;o(p,f)=(tail.cycle$p,f
 );l _ s(KeyPress k)|k=='k',let y=o s,c y=y|k=='j',let y=m(`div`2)s,c y=y|k=='l'
 ,let y=m(*2)s,c y=y;l _ s _|let y=f s,c y=y|True=g s;d _ s=stringPlane$u(w$a s)
m x(p,f)=(h(h x)p,f);f(p,f)=(h(0:)p,f);c(p,f)=all(<1)$z(.&.)(p!!0)$w f;y=reverse
t=z(.|.);g s=(p!!(sum k`mod`7),h(\_->0)e++k)where(k,e)=partition(<2046)(a s)
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/tetris (gergoerdi)

Play with `j` and `l` to move the piece, `k` to rotate. Hold any other
key to drop faster.
-}
