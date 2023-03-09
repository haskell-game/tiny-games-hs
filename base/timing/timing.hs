#!/usr/bin/env stack
-- stack script --resolver=lts-20.13
import GHC.Clock (getMonotonicTime)
import System.Environment (getArgs)
main = do -- base-10-80/timing (TravisCardwell)
  secs <- read . head . (++ ["30"]) <$> getArgs
  putStrLn $ "Press enter.  Wait " ++ show secs ++ " seconds.  Press enter."
  (t0,t1) <- (,) <$> (getLine>>getMonotonicTime) <*> (getLine>>getMonotonicTime)
  mapM_ putStrLn $ ("You waited " ++ show (t1 - t0) ++ " seconds.")
    : ["Score: " ++ show (100 * (1 - min 1 (abs (t0 + secs - t1) / secs)))]
