#!/usr/bin/env -S runghc-9.2 -XUnicodeSyntax
{import System.Exit;import System.IO;ऄ=replicate;अ=putStr;आ=mod;इ=stdin;ई=pure;
main=do{अ(unlines((ऄ 40 ' '++"v"++ऄ 39 ' '):ऄ 5(ऄ 80 ' ')));hSetEcho इ False;
hSetBuffering इ NoBuffering;उ(0,2^30,[30,40,50]:repeat[],40)};उ(ऊ,ऋ,ऌ,ऍ)=do{let{
ऎ=zipWith(\ए ऐ→((((ऋ`div`3^ए)`आ`3)-1)+ऐ)`आ`80)[1..](ऌ!!0)++if ऋ`आ`7<1 then[ऋ`आ`
80]else[];ऑ=if ऋ`आ`101<length ऎ*1 then tail ऎ else ऎ};input←getChar;ऒ←fmap(`आ`80
)$case input of{'a'→ई(ऍ-1);'d'→ई(ऍ+1);'\ESC'→ओ ऊ;_→ई ऍ};अ("\^[[6A\^[["++show(ऍ+1
)++"G.\^[[B\^[["++show(ऒ+1)++"Gv\^[[5E");अ(fmap(\औ→if औ`elem`ऌ!!0||औ`elem`ऌ!!1
then '#' else ' ')[0..79]++"\n");if ऒ`elem`ऌ!!5||ऒ`elem`ऌ!!6 then ओ ऊ else उ(ऊ+1
,13*ऋ`आ`(2^31-1),take 7(ऑ:ऌ),ऒ)};ओ ऊ=अ"Score: ">>print ऊ>>exitSuccess}
-- ^10 ------------------------------------------------------------------ 80> --
-- base-10-80/woosh.caves (Kindaro), ghc 9.2
