#!/usr/bin/env -S runghc -cpp -DD=a=replicate;b=putStrLn;c=length;p=map;u=max(2)
f=y"LMONRSVZ\nealoeaeo\nnjgrkrre\naaaaaaa ";main=n$p(`div`2^16)$iterate(\k->mod(
 k*22695477+1)(2^32))9;m=y"Adam\nBela\nErik\nFeri\nGeza\nHugo\nImre\nJeno\nPal "
n r=(\(l,q)->w 8l>>b(a 40'=')>>n q)$g r$a 10$a 8 1++[3];q n l=getLine>>= \r@(~[y
 ,x])->(\k j->z(c r/=2||l!!j!!k>0)[w(n-1)(p(i k u 8)$i j(p u)9l),q n l])(d x$f!!
 0)(d y$p(!!0)m);i j c=((\(l,v:r)->l++c v:r).).splitAt.mod j;w n l=z(all(all(0<)
 )l)[mapM b(h l)>>q n l,b$z(n<1)$y"LOSS\nWIN"];z b=(!!fromEnum b);g(o:p:q:r)l=z(
 o<6555&&all(\s->c[k|k<-l,any((1>).(k!!))s]>=c s)(foldr(\r->(>>= \q->[r:q,q]))[[
 ]][0..7]))[g r$i p(i q(*0)8)9l,(l,r)];d x=c.takeWhile(x/=);s=(' ':).(>>=(:" "))
h l=zipWith(++)(a 4"    "++m)$p s$f++p(p("O.X "!!))l;y=lines;D
-- ^10 ------------------------------------------------------------------ 80> --
