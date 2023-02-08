{-# LANGUAGE PackageImports #-}
module Import (module I) where  -- imports for ski.hs
import "base"   Control.Concurrent as I (threadDelay)
import "base"   Control.Monad      as I (replicateM_, when)
import "base"   System.IO          as I (hSetBuffering,stdin,BufferMode(NoBuffering),hReady,hSetEcho)
import "random" System.Random      as I (randomRIO)
