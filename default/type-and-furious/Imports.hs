module Imports(module I) where

import Text.Printf  as I (printf)
import Control.Monad as I (when, void, forever)
import Control.Concurrent as I (threadDelay, forkIO, killThread)
import Data.IORef as I ( atomicModifyIORef', newIORef, readIORef )
import System.IO as I (getContents, BufferMode (..), stdin, hSetBuffering)
import System.Exit as I (exitSuccess)
import Control.DeepSeq as I (force)
import System.Environment as I (getArgs)