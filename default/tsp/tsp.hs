import System.IO; import Control.Concurrent; import Data.ByteString(elemIndices,
 hGetNonBlocking,hPut); import Data.ByteString.Char8(pack); q=hPut stdout . pack
main = hSetBuffering stdin NoBuffering>>hSetEcho stdin False>>go (-30,0,0,0,' ')
o=True;k="Lost\n";s v|v>=0=">"|o="<";c t|t<0=show (t`div`10)|o="";l=2900;d="--,"
p 0(_,p,v,_,_)="VEL "++show v++" | ALT "++show p;p 1_=d++[' '|_<-[0..69]]++"~|~"
p 2(t,p,v,_,f)=[' '|_<-[0..floor(p/40)]]++f:s v++c t;z t v|v>(-50)=print t|o=q k
r s=q$"\ESCc=<< TSP >>=   | "++(unlines$map(flip p s)[0..2]);y=flip elemIndices;
go s=r s>>threadDelay 100000>>(hGetNonBlocking stdin 42>>=e s);e(t,p,v,h,_)i=let
 j=(/=[]).y i;f=j 102;r=j 114;g|f='*'|r='['|o=' ';n|f=5|r=(-5)|o=0;q=m 0(p+v-1);
 c|t<0=0|o=1;in if(q==0&&h>l)then z t v else go(t+1,c*q,c*(v+n-1),m h p,g);m=max
-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/tsp (tristanC)

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
