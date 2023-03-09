#!/usr/bin/env -S stack script --resolver lts-20.13 --package ansi-terminal-game
import Terminal.Game;a=80;b=20;c(p,q,r)=sqrt(p*p+q*q+r*r);k=abs;l=const;m=cos
d(p,q,r)=(max p 0,max q 0,max r 0);e p q(r,s,t)=c.d$(k r-q,k s-p,k t-0.03)
n=round;o=sin;j p=foldr(i(p/10)0)(blankPlane(n a)(n b))q;i _ 10 _=id
i p q(r,s,(t,u,v))=let w=t*m p-v*o p;x=t*o p+v*m p;y=h(w,u,x) in if
 y<=0.01then(s,r)%cell 'λ'else i p(q+1)(r,s,(t,u,v+y))
f p(q,r,s)=(q*m p-r*o p,q*o p+r*m p,s);g(p,q,r)=(p+0.05,q-0.4,r)
q=[(n x,n y,(x/a*2-1,(y/b*2-1)*0.2,-10))|y<-[0..b],x<-[0..a]]
main=playGame(Game 13 0(\_ p _->p+1)(l j)(l False))
h p=min(e 0.8 0.05(f 1p))(e 0.4 0.04(g(f(-1)p)))
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/lazy-march (tristanC)

- Play: $ ./lazy-march.hs

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
