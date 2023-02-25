#!/usr/bin/env runghc
import System.IO;import GHC.Conc;import System.Environment;i=round;g=True
main=hSetBuffering stdin NoBuffering>>getArgs>>=j;f j=d j>>getChar>>=e j
a(j,k,l)=take l$iterate(\(m,n)->(m+pi*j/90,n+k/30))(0,0);j[]=f(29.6,3,k)
j(a:_)=f(read a);b(j,k)=(i(60+k*cos j),i(0.5*(50+k*sin j)));h=putStrLn
c(j,k)=threadDelay 1000>>h("\^[["++show k++";"++show j++"f❤");k=400
d j=h("\^[cflower-seeds "<>show j)>>traverse(c.b)(a j);e(j,k,l)m=let
 n|m=='j'=(-1)|m=='l'=1|g=0;o|m=='k'=(-1)|m=='i'=1|g=0
 p|m=='c'=(-1)|m=='v'=1|g=0in f(j+n/20,max 0.1(k+o/10),max 1(l+p*17))

-- ^10 ------------------------------------------------------------------ 80> --
{- base-10-80/flower-seeds (tristanC)

- Play: $ ./flower-seeds.hs
- Keys: i/j/k/l/c/v to change the flower

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
