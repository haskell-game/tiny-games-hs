#!/usr/bin/env -S runghc-9.2 -XUnicodeSyntax
{import System.Exit;import System.IO;ऄ=replicate;अ=putStr;आ=mod;इ=stdin;ई=pure;
main=do{अ(unlines((ऄ 10 '　'++"🐈"++ऄ 29 '　'):ऄ 15(ऄ 40 '　')));hSetEcho इ False;
hSetBuffering इ NoBuffering;उ(0,2^30,[]:repeat[],10)};उ(ऊ,ऋ,ऌ,ऍ)=do{let{ऎ=
zipWith(\ए ऐ→((((ऋ`div`3^ए)`आ`3)-1)+ऐ)`आ`40)[1..](ऌ!!0)++if ऋ`आ`1<1 then[ऋ`आ`40]
else[];ऑ=if ऋ`आ`10<length ऎ*1 then tail ऎ else ऎ};input←getChar;ऒ←fmap(`आ`40)$
case input of{'a'→ई(ऍ-1);'d'→ई(ऍ+1);'\ESC'→ओ ऊ;_→ई ऍ};अ("\^[[16A\^[["++show(ऍ*2+
1)++"G.\^[[B\^[["++show(ऒ*2+1)++"G🐈\^[[15E");अ(fmap(\औ→if औ`elem`ऌ!!0||औ`elem`ऌ
!!1 then '🌳' else '　')[0..39]++"\n");if ऒ`elem`ऌ!!15||ऒ`elem`ऌ!!16 then ओ ऊ else
उ(ऊ+1,13*ऋ`आ`(2^31-1),take 17(ऑ:ऌ),ऒ)};ओ ऊ=अ"Score: ">>print ऊ>>exitSuccess}
-- ^10 ------------------------------------------------------------------ 80> --
-- base-10-80/woosh.forest (Kindaro), ghc 9.2
