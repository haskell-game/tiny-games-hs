#!/usr/bin/env -S stack script --resolver lts-20.13 --package ansi-terminal-game
{import Terminal.Game;k(KeyPress a)=a;k _=' ';t=17;w=50;h=24;xl=1;xh=w-2;yl=2;yh
=h;pw=10;p=(w-pw)`div`2;py=h-3;y0=(h-pw)`div`2;main=playGame$Game t[0,p,1,2,y0,1
,0,0]up dr ((>0).head);up _[_,p,x,u,y,v,s,hi]e=(if k e=='q' then 1 else 0):if y
>=yh then [p,1,2,y0,1,0,max s hi]else case k e of{','->p-3;'.'->p+3;_->p}:eb xl
xh(x+u)u 1++pb p x s hi(eb yl yh(y+v)v 0);eb l h x u r=case()of{_|x>h-r->[x-1,-u
];_|x<l+r->[x+1,-u];_->[x,u]};pb p x s hi [y,v]=case()of{_|y>=py&&x>p-2&&x<=p+pw
->[y,-v,s+if v>0 then 1 else 0,hi];_->[y,v,s,hi]};dr _[q,p,x,u,y,v,s,hi]=
box w h '#'&(2,2)%box(w-2)(h-2)' '&(h,w`div`2-2)%stringPlane(" sc:"++show s++
" hi:"++show hi++" ")&(y,x)%cell '🎾'&(py,p)%box pw 1 '=';}
-- ^10 ------------------------------------------------------------------ 80> --
{-
hackage-10-80/pong2 (sm)
Bounce the ball to achieve a high score. Keys: , . q

Uses an emoji, may not look right with all fonts/machines.
See also pong2.unminified.hs.
-}
