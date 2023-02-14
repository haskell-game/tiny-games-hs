#!/usr/bin/env stack
-- stack script --resolver lts-20 --package ansi-terminal-game
{-# LANGUAGE RecordWildCards #-}
{
import Terminal.Game;
-- ^10 ------------------------------------------------------------------ 80> --
data Pong=Pong{sQuit::Bool,bx::Column,by::Row,bvx::Int,bvy::Int};
fps=30;w=80;h=24;xmin=2;xmax=79;ymin=2;ymax=23;
main=newPongGame>>=playGame;
newPongGame=do{s<-newPong;return Game{gTPS=fps,gInitState=s,gLogicFunction=gameUpdate,gDrawFunction=gameDraw,gQuitFunction=gameShouldQuit}};
newPong=return$Pong{sQuit=False,bx=w`div`2,by=h`div`2,bvx=2,bvy=1};
gameShouldQuit=sQuit;
gameUpdate genv s ev=gameShouldQuitUpdate s ev&ballUpdate;
gameShouldQuitUpdate s ev=case ev of{KeyPress 'q'->s{sQuit=True};_->s};
ballUpdate s@Pong{..}=s{bx=bx'',by=by'',bvx=bvx,bvy=bvy} where
  bx'=bx+bvx;by'=by+bvy;
  (bx'',bvx)=case True of _|bx'>xmax->(bx'-1,-bvx);_|bx'<xmin->(bx'+1,-bvx);_->(bx',bvx);
  (by'',bvy)=case True of _|by'>ymax->(by'-1,-bvy);_|by'<ymin->(by'+1,-bvy);_->(by',bvy);
;
gameDraw genv s@Pong{..} = walls s & (by,bx) % ball s;
ball s = color White Vivid $ cell 'o';
walls _ = color Blue Dull $ box w h '*' & (2,2) % box (w-2) (h-2) ' ' & (h,w `div` 2 - 4) % stringPlane " q: quit ";
}
