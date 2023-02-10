#!/usr/bin/env -S runghc -cpp -DD=a=replicate;b=putStrLn;c=length;p=map;u=max(2)
m=y"Adam \nBela \nCsaba\nDavid\nErik \nFeri \nGeza \nImre \nJeno ";w 0_=b"WIN";w
 n l=z(all(all(0<))l)[mapM b(h l)>>q n l,b"LOSS"];d x=c.takeWhile(x/=);y=lines;D
f=y"HKLMNPRS\naiuaoeoa\nnajjrtzr\nnrzaaraa\naaa  a  ";z b=(!!fromEnum b);main=n$
 p(`div`2^16)$iterate(\k->mod(k*22695477+1)(2^32))9;h l=zipWith(++)(a 5"     "++
 m)$p((' ':).(>>=(:" ")))$f++p(p("O.X "!!))l;q n l=getLine>>= \r@(~[y,x])->(\k j
 ->z(c r/=2||l!!j!!k>0)[w(n-1)(p(i k u 8)$i j(p u)9l),q n l])(d x$f!!0)(d y$p(!!
 0)m);g(o:p:q:r)l=z(o<6555&&all(\s->c[k|k<-l,any((1>).(k!!))s]>=c s)(foldr(\r->(
 >>= \q->[r:q,q]))[[]][0..7]))[g r$i p(i q(*0)8)9l,(l,r)];i j c=((\(l,v:r)->l++c
 v:r).).splitAt.mod j;n r=(\(l,q)->w 8l>>b(a 40'=')>>n q)$g r$a 10$a 8 1++[3];
-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/matchmaking (migmit) -}
{- running:
 ./matchmaking.hs
OR, on older systems that don't support `env -S`
 runghc -cpp -DD='a=replicate;b=putStrLn;c=length;p=map;u=max(2)' matchmaking.hs
(Note that this line also fits into 80 characters limit)
-}
{-
In a small Hungarian village there are several guys: Adám, Béla, Csaba, Dávid,
Erik, Feri, Géza, Imre, and Jenő — and several girls: Hanna, Kiara, Lujza, Maja,
Nóra, Petra, Róza, and Sára. Some of them like each other. Help each girl find
herself a husband — it must be someone she likes, and who likes her.

What you see is a table with the names of all the guys and girls (girls names
are written vertically), where `.` means this guy would not make a suitable
husband for this girl, and `O` means he is a good choice. Enter first letters of
his and her names, without spaces, in that order, like `AH` — meaning, Adám gets
to marry Hanna. If Adám is not a good match for Hanna, entering `AH` will
produce no effect and you'd have to try again. As you keep doing that, the
entries in the rows and columns you indicated would be replaced by `X` — showing
that those guys and girls aren't available anymore. You win if every girl finds
a husband; you lose if there are no other matches to make.

The game would start again after you finish it, with different possible couples.
Rest assured, there is a solution for each puzzle.
-}
