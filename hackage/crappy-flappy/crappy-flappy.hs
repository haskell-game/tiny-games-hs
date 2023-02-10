#!/usr/bin/env stack
-- stack script --resolver=lts-20.10 --package ansi-terminal-game
import Imports;end ps (y,dy,x)=y>120||y<0||x>3950||
  (x`mod`40==0&&let(t,b)=ps!!(x`div`40)in y`div`5<t||y`div`5>(t+b)); main=do
{s<-fromIntegral.(`mod`100)<$>getMonotonicTimeNSec
;let _:(ps@((y0,_):_))=iterate(\(x,y)->(3+((x+9)`mod`7),5+((y+12)`mod`5)))(s,s)
;playGame(Game 20 (y0+1,0,1) logic (draw (take 10 ps)) (end ps));}
logic _ (y,dy,x) e=case e of { Tick -> (y+dy`div`2,dy+1,x+1); _ -> (y-3,0,x+1)}
draw p r(y,_,x)=mergePlanes(blankPlane 80 24&(y`div`5,x`div`5)%cell '@')$concat
  [[((0,x*8),box 1 t '|'),((t+b,x*8),box 1(24-t-b) '|')]|(x,(t,b))<-zip[0..]p]
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/crappy-flappy (gergoerdi)

-}
