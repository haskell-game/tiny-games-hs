#!/usr/bin/env stack
-- stack --verbosity=error script --resolver=lts-20.9 --package random
import System.IO (hFlush, stdout)
import System.Random (randomRIO)
main = randomRIO (1,100::Int) >>= print





-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/template1 (mynick). ghc-9.4, random

https://hackage.haskell.org/package/base/docs/System-IO.html
https://hackage.haskell.org/package/random

-}
