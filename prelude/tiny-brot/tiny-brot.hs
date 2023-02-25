#!/usr/bin/env runghc
a=80;b=24;c(j,k)(l,m)=(j+(l*l-m*m),k+2*l*m);d j=4.18-4.179*(1-cos(j/10)**8)
i(j,_)="\ESCctiny-brot\n"<>concatMap(h(d j))[(j,y)|y<-[0..b],j<-[0..a+1]]
g j k=f$last$take j$iterate(c k)(0,0);main=interact(foldMap i.zip[0..].k)
e j(k,l)(m,n)=(k+j*(m-a/2)/a,(l+j*(n-b/2)/b)*(-0.5));h _(81,_)="\n"
h j k=if g 150(e j(-1.4844,0)k)>20then" "else"λ";k=mappend"g"
f(j,k)=let l=abs(j*k) in if isNaN l then 42else l



-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/tiny-brot (tristanC)

- Play: $ runhaskell ./tiny-brot.hs
- Keys: <enter> to zoom

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
