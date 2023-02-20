#!/usr/bin/env -S runghc -XLambdaCase
import System.IO;main=hSetBuffering stdin NoBuffering>>a(r,repeat 0,repeat 20,0)
a s=mapM putStrLn (h s)>>g>>= \case{'\^['->g>>g>>=z s 20. \case{'C' -> (1 +);'D'
 ->(\n->i(n>19)(n-1)n)};d->z s(2*length(takeWhile(/=d)w)+1)id}; q=map; n=iterate
h(_,t,b,c)=("\^[[2J\^[[H "++(w>>=(:" "))):q(\n->k 19$l n ' '++"v")(k 5 b)++[q(
 " X*0123456789"!!)$k 19 t,"Turns: "++o c];i b y x=if b then x else y;v=return()
z(u:r,t,b,c)l f=i(all(`elem`[1,2])$k 19 t)(let y=q f b::[Int] in a(r,m u$x(y!!4)
 t,l:y,c+1))v;r=q(`div`2^16)$n(\k->mod(k*22695477+1)(2^32))9;g=getChar;p=splitAt
x b t=let(l,c:r)=p b t in q(\k->k-i(k>2)0 1)(l++(i(c==2)0 1):r); l=replicate
m n t=let(l,c:r)=p(mod n 19)t in i(c==0)t(l++12:r);w="asdfghjkl"; o=show; k=take
-- ^10 ------------------------------- 80> -------------------------------------
{- base-10-80/shoot (migmit) -}
