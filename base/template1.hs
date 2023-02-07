#!/usr/bin/env runghc   # ghc 9.2.5, gam-10-80-hs-base/template1 (mynick)
import Text.Printf
  -- https://hackage.haskell.org/package/base/docs/Text-Printf.html
main = do
  putStrLn "playable game here"
  s <- getLine
  printf "you entered: %s\n" s



-- ^10 ------------------------------- 80> -------------------------------------