module Imports
  ( ord
  , getStdGen, randomRs
  , play, Display(InWindow), white, translate, scale, rectangleWire, text
  , rectangleSolid, Event(EventKey), KeyState(Down), Key(Char)
  ) where
import Data.Char
import System.Random
import Graphics.Gloss.Interface.Pure.Game
