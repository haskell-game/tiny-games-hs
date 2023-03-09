#!/usr/bin/env runhaskell
import System.Random (randomRIO);w = ["cute","game","play","dream"];n wr f = do
  putStrLn $ map (\i -> if i `elem` f then i else '_') wr
  if (length wr == length f) then putStrLn "You won!"
  else getLine >>= \i ->  (if (i !! 0) `elem` wr then do
      putStrLn "You got it"
      n wr (i !! 0 : f)
    else putStrLn "try again" >> n wr f)
main=putStrLn "Guess the word!" >> randomRIO (0,length w - 1::Int) >>= \r -> do
  return (w !! r) >>= \wr -> n wr [];
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/short-guess (RimuhRimu). random 

stack runghc --resolver lts-20.13 --package random "$1"
-}
