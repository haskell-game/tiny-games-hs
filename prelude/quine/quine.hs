#!/usr/bin/env runghc
q=t 34;e=t 92;n=t 10;d='-';t=toEnum;z="-- ^10 ";b('#':'!':y)=q:'#':'!':b y
b[]=q:c;b(x:y)|x==n=e:'n':e:n:e:b y|x==q=e:q:b y|o=x:b y;l="SPDX: CC0-1.0"
s=n:z++[d|_<-[0..66]]++" 80> --"++n:"{- prelude-10-80/quine (tristanC)"
o=True;c=n:s++n:l++n:"-}";main=putStrLn(s++b s)where s="#!/usr/bin/env runghc\n\
\q=t 34;e=t 92;n=t 10;d='-';t=toEnum;z=\"-- ^10 \";b('#':'!':y)=q:'#':'!':b y\n\
\b[]=q:c;b(x:y)|x==n=e:'n':e:n:e:b y|x==q=e:q:b y|o=x:b y;l=\"SPDX: CC0-1.0\"\n\
\s=n:z++[d|_<-[0..66]]++\" 80> --\"++n:\"{- prelude-10-80/quine (tristanC)\"\n\
\o=True;c=n:s++n:l++n:\"-}\";main=putStrLn(s++b s)where s="

-- ^10 ------------------------------------------------------------------- 80> --
{- prelude-10-80/quine (tristanC)
SPDX: CC0-1.0
-}
