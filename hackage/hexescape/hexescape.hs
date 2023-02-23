#!/usr/bin/env stack
-- stack script --resolver lts-20.11 --package grid,random
import Import;c=putStrLn;n=4;u=pure;v z=randomRIO(0,z);main=do{let{gH=
hexHexGrid n};let{aC=indices gH\\[(0,0)]};e<-(aC!!)<$>v (length aC-1);(_,_,h)<-
g(gH,e)(head(centre gH),False,100);if h<=0then c"✝"else c"🪜"};m p=do{mapM_(c.(
\(k,r)->([k..n]>>" ")++((mC r p)=<<[2..n+k])))(zip([1..n-1]++[n, n-1..1])[1..])
};g(w,e)(p,s,h)|p==e||h<=0=u(p,True,h)|True=do{m p;d::Int<-v 10;;let{nh=h-d};
let{mO=neighbours w p};c.show$zip[1..](map(\x->head$directionTo w p x)$mO);
i<-read<$>getLine;c$"You have "++show nh++"hp";g(w,e)(mO!!(i-1),False,nh)};
mC r (a,b) c|(n-r)==b&&(if r<=n then(c-1-n)else(c-1)-n+(r-n))==a="⬢ "|True="⬡ "
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/hexEscape (nevrome).

Copyright 2023, Clemens Schmid
SPDX-License-Identifier: CC-BY-4.0

You are in room ⬢. Select the next, adjacent room ⬡ you want to explore with a
number between 1 and 6 (+ Enter). Search for the exit 🪜, before you run out of
healthpoints (hp) and die ✝.

Uses the unicode characters ✝, 🪜, ⬡ and ⬢, so it may not look right with all
fonts/machines.
-}