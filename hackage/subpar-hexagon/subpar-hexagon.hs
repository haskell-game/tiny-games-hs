#!/usr/bin/env -S stack script --compile --resolver lts-20 --package gloss
import Import;main=play FullScreen white 60(0,0,20,cycle(False:replicate 5 True)
 ,3)d l t;h=cycle[(-1,0),(-0.5,0.87),(0.5,0.87),(1,0),(0.5,-0.87),(-0.5,-0.87)];f
 s=foldMap(\(p1, p2)->line[p1, p2])[p|(p,b)<-take 6$zip(zip h(tail h))s, b];d(p,r
 ,s,q,_)=rotate r$join scale (100+20*sin(0.17*r))$f (repeat True)<>rotate 30(
 uncurry translate (h!!p) $ circle 0.1)<>scale s s(f q);l(EventKey k Down _ _)(p
 ,r,s,q,x)|k==Char 'a'=((p-1)`mod`6,r,s,q,x)|k==Char 'd'=((p+1)`mod`6,r,s,q,x);l
 _ s = s;t d(p,r,s,q,x)|s>1= (p,r+d*90,s*0.2**d, q,x)|not(q!!p)=(p,r+d*90,20,
 drop x q,x`div`2`xor`bool 0 96(odd x))

-- ^10 ------------------------------------------------------------------ 80> --
