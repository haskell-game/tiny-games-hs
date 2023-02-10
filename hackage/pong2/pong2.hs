#!/usr/bin/env -S stack script --resolver lts-20 --package ansi-terminal-game
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
gam-10-80-hs-hackage/pong2 (sm). Keys: , left  . right  q quit.
Uses an emoji, may not look right with all fonts/machines.

-- less compressed
{import Terminal.Game;
k (KeyPress a)=a;k _=' ';
t=20;w=50;h=24;xl=1;xh=w-2;yl=2;yh=h;pw=10;p=(w+pw)`div`2;py=h-3;y0=(h-pw)`div`2;
main=playGame$Game t[0,p,1,2,y0,1,0,0]up dr ((>0).head);
up _[_,p,x,u,y,v,s,hi]e=(if k e=='q' then 1 else 0):if y>=yh then [p,1,2,y0,1,0,max s hi]else case k e of{','->p-3;'.'->p+3;_->p}:eb xl xh(x+u)u 1++pb p x s hi(eb yl yh(y+v)v 0);
eb l h x u r=case()of{_|x>h-r->[x-1,-u];_|x<l+r->[x+1,-u];_->[x,u]};
pb p x s hi [y,v]=case()of{_|y>=py&&x>p-2&&x<=p+pw->[y,-v,s+1,hi];_->[y,v,s,max s hi]};
dr _[q,p,x,u,y,v,s,hi]=box w h '#'&(2,2)%box(w-2)(h-2)' '&(h,w`div`2-2)%stringPlane(" sc:"++show s++" hi:"++show hi++" ")&(y,x)%cell '🎾'&(py,p)%box pw 1 '=';
}

-- with colors
dr _[q,p,x,u,y,v,s,hi]=c Blue d(box w h wl&(2,2)%box(w-2)(h-2)' '&(h,w`div`2-2)%c White d(stringPlane(" sc:"++show s++" hi:"++show hi++" ")))&(y,x)%c White Vivid (cell bl)&(py,p)%c Red d(box pw 1 '=');

Legend
t:     game ticks per second
w:     playfield width
h:     playfield height
xl:    x low edge
xh:    x high edge
yl:    y low edge
yh:    y high edge
pw:    player bat width
p:     player x
py:    player y
y0:    initial ball y
wl:    wall character
bl:    ball character
game state: [q,p,x,u,y,v,s,hi]
  q:   quit game?
  p:   player x
  x:   ball x
  u:   ball x velocity
  y:   ball y
  v:   ball y velocity
  s:   score
  hi:  high score
up:    update game
eb:    calculate x or y edge bounce, with "radius" adjustment
       (0 normally, 1 for horizontal bounce of a double-wide character
pb:    calculate player bat bounce
dr:    draw game state

http://hackage.haskell.org/package/ansi-terminal-game/docs/Terminal-Game.html
-}
