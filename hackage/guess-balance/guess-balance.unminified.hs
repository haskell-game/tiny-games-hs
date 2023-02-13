#!/usr/bin/env stack
-- stack script --resolver lts-20 --package hledger-lib --package random --package text --package Decimal
import Hledger
import System.Random
import qualified Data.Text as T
import Data.Decimal
-- q=And[Type[Asset,Liability],Sym$toRegex'$T.pack"^.$",Acct$toRegex'$T.pack"paypal"]
q=Acct$toRegex'$T.pack"Vanguard:Cash"
-- q=Type[Asset,Liability]
main=defaultJournal>>=gu.fst.balanceReport defreportspec{_rsQuery=q}
gu [] = putStrLn "no balances found"
gu bs = do
  i<-randomRIO(0,length bs-1)
  let (a,_,_,b0) = bs !! i
  putStrLn $ "\nWhat is the (main commodity) balance of " ++ T.unpack a ++ " ?\nEnter a positive integer: "
  g <- getLine
  let
    b = mixedAmountStripPrices b0
    q = maximum $ 0 : map (abs.aquantity) (amounts b)
    (d,p) = er (read g) q
    p' = roundTo 1 p
    s = 100-min 100 p'
  if d/=0
  then putStrLn("Off by ~"++show d++", score: "++show s) >> gu bs
  else putStrLn $ "Correct! The balance is "++showMixedAmountOneLine b++"."

-- er :: (RealFrac a, RealFrac b) => a -> b -> (Int, b)
er g b = let d=abs$round g-round b in (d,fromIntegral d*100/b+0.001)
-- av :: (Fractional a, Foldable t) => t a -> a
av as = sum as / if null as then 1 else fromIntegral (length as)

{- 
hackage-10-80/guess-balance (unminified version)

Tests/drills your financial situational awareness, asking for the balance
in random asset/liability accounts until you get one right.
Uses your default hledger journal if you have one:

$ ./guess-balance.hs
  
otherwise finance data in a hledger-readable format, from somewhere else:

$ LEDGER_FILE=~/src/hledger/examples/sample.journal ./guess-balance.hs

Legend
bs   balance report items
a    account name
b    account balance, possibly multicurrency
g    guess
e    error of guess, as a positive percentage of actual balance
f    e with fewer decimal places
s    score from 0 to 100
p    putStrLn
gu   guess repl
er   calculate error in one currency. Returns rounded difference and percentage difference.
av   calculate average

http://hackage.haskell.org/package/hledger-lib/docs/Hledger.html

-}
