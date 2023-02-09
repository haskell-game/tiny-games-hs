#!/usr/bin/env -S stack script --resolver=lts-19.21 --package ansi-terminal-game
-- stack script --ghc-options -threaded
import Terminal.Game;main=playGame(Game 20(10,10,1,1,10,0)logic draw end)
end(x,y,a,b,z,s)=x<2&&(y<z||y>z+8);logic _(x,y,a,b,z,s)e=(x+a,y+b,f 79 x a,
 f 21 y b, min 15$max 2$z+case e of{KeyPress 'w'-> -1;KeyPress 's'->1;_->0},
 s+if x<2then 1 else 0);draw r(x,y,dx,dy,z,s)=mergePlanes(blankPlane 80 24)
 [((1,1),box 80 23 '#'),((2,1),blankPlane 79 21),((z,1),box 1 8 '>'),((y,x),
 box 1 1 '*'),((24,60),stringPlane(show s))]
f m x a=if x<3 then 1 else if x>m then -1 else a

-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-hackage/pong (gergoerdi)

-}
