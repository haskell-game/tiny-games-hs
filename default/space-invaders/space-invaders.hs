import Import;main=do{hSetBuffering stdin NoBuffering;l 0 1(8,15)[][]$(,)<$>[1,3
,5]<*>[3,6..24]};x!y=mod y x==0;i=hReady stdin>>=y(pure '.')(getChar<*i);y=bool
k=intersect$(,)<$>h<*>w;p(i,j)(k,l)=(i+k,j+l);u c p b q=y(b q)c(p==q);w=[0..34]
l t d s b v a|a==[]=error"WIN"|or[0<1|(7,_)<-a]||elem s v=error"LOSE"|let=i>>=
 \c->let{a2=p(0,y 0 d$10!t)<$>a;a3=p(1,0)<$>a;(a4,d2)=y(a3,-d)(a2,d)(a2==k a2);
a5=a4\\b2;v2=k$[z|z@(i,j)<-a5,307!(97*i`xor`97*j`xor`t)]++map(p(mod t 2,0))v;
s2=cl$p(0,maybe 0(1-)$elemIndex c"d a")s;b2=k$map(p(-1,0))$y b[s]$c==' '&&b==[];
f=foldr(u '*')(foldr(u 'W')(foldr(u 'v')(u 'A's2(\_->' '))v2)a5)b2;cl(i,j)=(min
9$max 0i,min 34$max 0j);}in do{putStrLn$"\ESC[H"++unlines[[f(i,j)|j<-w]++
"\ESC[K"|i<-h]++"\ESC[J";threadDelay$9^5;l(t+1)d2 s2(b2\\a4)v2 a5};h=[0..9]
-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/space-invaders (meooow25)

GHC 9.2.5

runghc space-invaders.hs

a - left
d - right
spc - shoot
-}
