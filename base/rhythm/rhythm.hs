#!/usr/bin/env runghc
{import GHC.Conc;import System.IO;import System.CPUTime;i r|r>9="*"|let="";t=r w
;o a d p r(n:m)b=do{u$"\ESC[2J"++unlines(reverse p++("-O-O-O-O- "++show a++i r):
(n:m));threadDelay d;q<-g;u<-getCPUTime;let{k=q==filter(/=w)n;x|n==t=0|r>9,k=2|k
=1|let= -1;y|n==t,k=r|k=r+1|let=0};o(a+x)d(take 3$(c k++n++"\ESC[0m"):p)y(m++[b%
(u`div`cpuTimePrecision`mod`5)])b};h q|q=(:)<$>z<*>g;h _=pure[];v%0=t;(c:d:v)%n|
1<-n=c:d:map(\_->w)v|let=w:w:v%(n-1);g=h=<<hReady l;u=putStr;p m=u m>>(read.pure
<$>z)<*z;l=stdin;c x|x="\ESC[32m";c _="\ESC[31m";main=do{d<-p"Speed(0-9):\n";f<-
p"Keyset(0-2):\n";hSetEcho l$0==1;hSetBuffering l NoBuffering;o 0((10-d)*97897)[
]0(r t)$[" w a d s "," j k l ; "," 8 4 6 2 "]!!f};z=getChar;w=' ';r=replicate 9}
-- ^10 ------------------------------- 80> -------------------------------------
-- gam-10-80-hs-base/rythm (elderephemera), ghc 9.0, 9.2
