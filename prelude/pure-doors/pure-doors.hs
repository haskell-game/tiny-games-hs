#!/usr/bin/env runghc
e=head;f=replicate;b h i j="|"<>f j h<>i<>f(7-j)h<>"|\n"
a=1:2:zipWith(+)a(g a);main=interact(d(-1)(map(\h->(5,mod h 8))a)3)
c 5(0,h)i j k|h/=i="Crash!"<>k[]|otherwise=c 5(e j)i(g j)k
c 5(h,i)j k l=b ' '"^"j<>"[jkl]> "<>l((h-1,i):k)
c h i@(j,k)l m n=(if h==5-j then b '-'" "k else b ' '" "7)<>c(h+1)i l m n
g=tail;d h i j k="\ESCcpure-doors\n"<>c 0(e i)j(g i)(\l->case (l,k) of
 (_:_,m:'\n':n)|m>'h'&&m<'n'->d(h+1)l(j+fromEnum m-107)n
 _->(if h>5then" GG, your score is: "<>show(div h 5)else"")<>"\n")

-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/pure-doors (tristanC)

Play: $ ./pure-doors.hs
Goal: pass through doors
Keys: j/k/l to move left/forward/right

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
