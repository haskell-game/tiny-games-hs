#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Imports;g=translate;o=True;d f=foldMap(\(x,y)->g x y f);q=circle;main=
 play FullScreen white 60((0,1,[],0),0,20,mzero)r i st;y0= -28;r((_,_,m,z),x,_,
 b)=text(show z)<>(scale 18 18$g x y0 sh<>d(q 0.4)b<>d v m);sh=q 1;v=line[(-1,2)
 ,(0,0),(1,2)];i(EventKey(Char k)Down _ _)(s,x,d,b)|k=='a'=(s,x,-20,b)|k=='d'=(s
 ,x,20,b)|k=='.'=(s,x,d,b<|>Just(x,y0));i _ s=s;n(a,b)(x,y)=(a-x)^2<1&&(b-y)^2<1
 ;st t((w,s,m,z),a,d,b)=((v,p,l,q),a+t*e,e,u)where{p=(s`div`2)`xor`bool 0 96(odd
 s);e|a>30= -20|a< -30=20|o=d;(c,y)|Just b<-b=partition(n b)m|o=([],m);m1=map(\(
 x,y)->(x,y-t*10))y;u=b>>= \(x,y)->(x,y+t*20)<$guard(null c&&(y<30));(v,l)|w>0=(
 w-t,m1)|o=(0.35,(int2Float(s`mod`60)-30,30):m1);q|any(n(a,y0))y=0|o=z+length c}
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/vaders (gergoerdi)
-}
