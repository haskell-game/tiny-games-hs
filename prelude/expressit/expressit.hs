#!/usr/bin/env runghc
p=putStrLn;s=show;l=toInteger.length;main=h 1 1;b=zipWith;h t n=do
{p$"target = "++s t;p$"n = "++s n;j<-getLine;either(\a->p("stack "++a)>>p(
"score: "++s (t-1)))(\a->p("= "++s a)>>if a==t then p"">>h(t+1)(l j)else p$
"score: "++s (t-1))(v n j w)};v n[][s,_,_]=Right s;v n(c:k)s@(x:y:z)=v n k
 (case c of{'n'->n:s;'+'->y+x:z;'-'->y-x:z;'*'->y*x:z;'/'->y`div`x:z;'%'->y
 `mod`x:z;'f'->sum(f((==0).mod x)[1..x])*signum x:y:z;'c'->g x:y:z;'i'->iterate
 g y!!fromInteger(abs x):z;'t'->l(f((==1).u x)[1..x]):y:z;_->s});v _ _ i|l i>2=
 Left"overfull"|0<1=Left"empty";u 0 n=n;u m n=u(n`mod`m)m;f=filter;g x=if even x
 then x`div`2 else 3*x+1;w=[0,0]
-- ^10 ------------------------------------------------------------------ 80> --
-- prelude-10-80/expressit (Greg B.)
-- Try to make an expression for the given target using your RPN calculator.
-- see README for further instructions
