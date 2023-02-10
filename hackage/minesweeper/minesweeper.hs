#!/usr/bin/env stack
-- stack script --compile --resolver=lts-20.10 --package random-shuffle
import System.Random.Shuffle;import System.IO;import Data.Bool(bool);
p=putStrLn;q=(>>readLn).putStr;s=show;l=length;j=bool;e=elem;r a=[0..a]
main=do{hSetBuffering stdout NoBuffering;l<-q"w:";h<-q"h:";n<-q"mines:";b<-
shuffleM[(x,y)|x<-[0..l-1],y<-[0..h-1]];g(take n b)(drop n b)b l h}
g m c b w h=j(do{p"";mapM_(\b->p$(r(w-1)>>= \a->j((s.l)[1|(x,y)
<-m,abs(a-x)<2,abs(b-y)<2])"?"(e(a,b)(m<>c))))$r(h-1);p"";x<-q"x:";y<-q"y:";
j(j(p"not in zone.">>g m c b w h)(do{g m (filter(/=(x,y))c)b w h})(e(x,y)b))
(p"boom")(e(x,y)m)})(p"you win!")(l c<1)
-- ^10 ------------------------------------------------------------------ 80> --
-- Author: Greg B.
-- Category: hackage (hackage-10-80)
-- Thumbnail: https://files.catbox.moe/ccs0dv.png
-- This is minesweeper.
-- Visit every safe cell to win. Visit a mine to lose.
-- Begin by specifying your playing field and the # of mines.
-- Then, enter the x and y coords of a cell you think is safe.
-- You may want to make a drawing for larger games :)
--
-- The start of a sample playthrough:
-- -- w:4
-- -- h:4
-- -- mines:3
-- --
-- -- ????
-- -- ????
-- -- ????
-- -- ????
-- --
-- -- x:0
-- -- y:0
-- --
-- -- 1???
-- -- ????
-- -- ????
-- -- ????
-- --
-- -- x:0
-- -- y:3
-- --
-- -- 1???
-- -- ????
-- -- ????
-- -- 1???
-- --
-- -- x:-2
-- -- y:2
-- -- not in zone.
-- --
-- -- 1???
-- -- ????
-- -- ????
-- -- 1???
-- --
-- -- x:
