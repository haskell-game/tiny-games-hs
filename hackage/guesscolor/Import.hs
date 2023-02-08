{-# LANGUAGE PackageImports #-}
module Import (module I) where -- imports for guesscolor.hs
import "base"   Control.Concurrent        as I (forkIO)
import "base"   GHC.Float.RealFracMethods as I (ceilingFloatInt)
import "gloss"  Graphics.Gloss            as I
  (Display(InWindow), Picture(Blank), display, makeColorI)
import "base"   System.Exit               as I (exitSuccess)
import "random" System.Random             as I (newStdGen, randomRs)
