-- #!/usr/bin/env -S stack script --resolver lts-20 --package gloss
import Graphics.Gloss;import Graphics.Gloss.Interface.IO.Interact;main=play
 FullScreen white 60(0,(0,0),(0.2,0.2),[(x,y)|x<-[0,2..20],y<-[0,2..8]])render
 input step;scaleFactor=20;render(p,(x,y),_,bricks)=scale scaleFactor
 scaleFactor$line[(p-2,-10),(p+2,-10)]<>translate x y(circle 1)<>foldMap(\(bx,
 by)->polygon[(bx,by),(bx+1,by),(bx+1,by+1),(bx,by+1)])bricks;input(EventMotion
 (p,_))(_,ball,ballV,bricks)=(p/scaleFactor,ball,ballV,bricks);input _ s=s;
step t (p,(x,y),(v,w),bricks)=(p,(x+v,y+w),(v',w'),filter(\(bx,by)->bx<x||bx>x+
 2||by<y||by>y+2)bricks)where{(v',w')|y< -10&&y> -11&&x>p-2&&x<p+2=
 ((x-p)/10,abs w)|x<0||x>20=(-abs v*signum x,w)|y>10=(v,-abs w)|otherwise=(v,w)}
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/brickbreaker (fgaz)

Move the pointer to move the paddle.
The ball is lost if it moves past the paddle.
Try to destroy all bricks!

-}
