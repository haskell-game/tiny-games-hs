#!/usr/bin/env stack
-- stack --verbosity=error script --resolver=lts-20.13 --package process
import System.Process (system)
main = do
  putStr "The current date/time is: "
  system "date"




-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/template1 (mynick) -}
