#!/usr/bin/env stack  # gam-10-80-hs-default/template1 (mynick)
-- stack --verbosity=error script --resolver=lts-20.9 --package random
import System.IO (hFlush, stdout)
  -- https://hackage.haskell.org/package/base/docs/System-IO.html
import System.Random (randomRIO)  -- https://hackage.haskell.org/package/random
main = randomRIO (1,100::Int) >>= print




-- ^10 ------------------------------- 80> -------------------------------------