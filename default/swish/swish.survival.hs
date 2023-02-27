#!/usr/bin/env -S runghc-9.2 -XUnicodeSyntax
{import Imports;ऄ=replicate;अ=putStr;आ=mod;इ=stdin;ई=pure;उ=(\उ ऊ ऋ→if उ then ऊ
else ऋ);main=do{अ("\^[[?25l"++unlines((ऄ 40 ' '++"▼"++ऄ 39 ' '):ऄ 19(ऄ 80 ' ')))
;hSetBuffering इ NoBuffering;ऌ(0,2^30,[1,80]:repeat[],40)};ऌ(ऍ,ऎ,ए,ऐ)=do{
threadDelay(20*10^4);ऑ←hReady इ>>=(\ऒ→उ ऒ getChar(ई ' '));let{ओ=zipWith(\औ क→(((
(ऎ`div`3^औ)`आ`3)-1)+क)`आ`80)[1..](ए!!0)++उ(ऎ`आ`7<1)[ऎ`आ`80][];ख=उ(ऎ`आ`101<length
ओ*1)(tail ओ)ओ};ग←fmap(`आ`80)$case ऑ of{'a'→ई(ऐ-1);'d'→ई(ऐ+1);'\ESC'→घ ऍ;_→ई ऐ};अ
(printf"\^[[20A\^[[%iG.\^[[B\^[[%iG▼\^[[19E"(ऐ+1)(ग+1));अ(fmap(\ङ→उ(any(ङ`elem`)
(take 2 ए))'▮' ' ')[0..79]++"\n");उ(any(ग`elem`)[ए!!19,ए!!20])(घ ऍ)(ऌ(ऍ+1,13*ऎ`आ
`(2^31-1),take 21(ख:ए),ग))};घ ऍ=अ"\^[[?25hScore: ">>print ऍ>>exitSuccess}
-- ^10 ------------------------------------------------------------------ 80> --
-- default-10-80/swish.survival (Kindaro), ghc 9.2
