{-
metapong.hs
https://github.com/simonmichael/metapong
http://hackage.haskell.org/package/ansi-terminal-game/docs/Terminal-Game.html

-}

{-# LANGUAGE RecordWildCards #-}

module Main where

import Terminal.Game
-- import Lib

--------------------------------------------------------------------------------
-- Data types

-- Game st - an ANSI terminal game with custom state, from Terminal.Game.

-- The "world" state of a pong game.
data Pong = Pong {
   sQuit :: Bool
  ,sBallX :: Column
  ,sBallY :: Row
  ,sBallVX :: Int
  ,sBallVY :: Int
  }

-- A pong game.
type PongGame = Game Pong

--------------------------------------------------------------------------------
-- Setup

fps  = 30
w    = 80
h    = 24::Int
xmin = 2
xmax = 79
ymin = 2
ymax = 23

main :: IO ()
main = do
  g <- newPongGame
  playGame g

newPongGame :: IO PongGame
newPongGame = do
  s <- newPong
  return $
    Game{
       gTPS           = fps
      ,gInitState     = s
      ,gLogicFunction = gameUpdate
      ,gDrawFunction  = gameDraw
      ,gQuitFunction  = gameShouldQuit
      }

newPong :: IO Pong
newPong = return $ Pong {
   sQuit   = False
  ,sBallX  = w `div` 2
  ,sBallY  = h `div` 2
  ,sBallVX = 2
  ,sBallVY = 1
  }

--------------------------------------------------------------------------------
-- Logic

gameShouldQuit = sQuit

gameUpdate genv s ev =
  gameShouldQuitUpdate s ev &
  ballUpdate

gameShouldQuitUpdate s ev =
  case ev of
    KeyPress 'q' -> s{sQuit = True}
    _            -> s

ballUpdate s@Pong{..} =
  s{sBallX=bx''
   ,sBallY=by''
   ,sBallVX=bvx
   ,sBallVY=bvy
   }
  where
    bx' = sBallX + sBallVX
    by' = sBallY + sBallVY
    (bx'', bvx) | bx' > xmax = (bx' - 1, -sBallVX)
                | bx' < xmin = (bx' + 1, -sBallVX)
                | otherwise  = (bx'    , sBallVX)
    (by'', bvy) | by' > ymax = (by' - 1, -sBallVY)
                | by' < ymin = (by' + 1, -sBallVY)
                | otherwise  = (by'    , sBallVY)

--------------------------------------------------------------------------------
-- Drawing

gameDraw genv s@Pong{..} =
  walls s &
  (sBallY,sBallX) % ball s

ball s = color White Vivid $ cell 'o'

walls _ =
  color Blue Dull $
  box w h '*' &
  (2,2) % box (w-2) (h-2) ' ' &
  (h,w `div` 2 - 4) % stringPlane " q: quit "
  -- stringPlane $ unlines [
  --  "********************************************************************************"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"*                                                                              *"
  -- ,"********************************************************************************"
  -- ]
