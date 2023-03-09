#!/usr/bin/env stack
-- stack script --resolver=lts-20.13 --package ansi-terminal-game
import Terminal.Game;main=playGameS(Game 20(10,10,1,1,10,0)l d e)>>=finish
e(x,y,a,b,z,s)=x<2&&(y<z||y>z+8);l _(x,y,a,b,z,s)e=(x+a,y+b,f 79 x a,
 f 21 y b, min 15$max 2$z+case e of{KeyPress 'w'-> -1;KeyPress 's'->1;_->0},
 s+if x<2then 1 else 0);d r(x,y,dx,dy,z,s)=mergePlanes(blankPlane 80 24)
 [((1,1),box 80 23 '█'),((2,1),blankPlane 79 21),((z,1),box 1 8 '▕'),((y,x),
 box 1 1 '⬤'),((24,60),stringPlane(show s))]
f m x a=if x<3 then 1 else if x>m then -1 else a
finish (_,_,_,_,_,s)=putStrLn$unwords["You scored",show s,"points!\n"]
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/pong (gergoerdi)

-}
