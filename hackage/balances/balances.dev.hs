#!/usr/bin/env stack
-- stack script --resolver lts-20 --package "random text hledger-lib" --verbosity error

import Data.Text (unpack)
import Hledger
import System.Random

-- Read the default hledger journal ($LEDGER_FILE or ~/.hledger.journal)
-- and calculate the balances of cash and liability accounts.
main = defaultJournal >>= g . fst . balanceReport defreportspec{_rsQuery=Type[Cash,Liability]}

p=putStrLn

-- Given some account balances, loop showing a random account name,
-- prompting for and scoring a guess of its balance, until a successful guess.
-- A guess is a positive integer, attempting to match the integral part
-- of the balance's most numerous commodity.
-- g :: [BalanceReportItem] -> IO ()
g [] = p "no balances found\n"
g bs = do
  i<-randomRIO(0,length bs-1)
  let (a,_,_,b0) = bs !! i
  u <- p(unpack a++" balance ? ") >> getLine
  let
    b = mixedAmountStripPrices b0
    q = maximum $ 0 : map (abs.aquantity) (amounts b)
    e = c (read u) q
  p$(if e<=10 then "✅ " else "❌ ")++(if e<1 then "right!" else show e++"% off")++", balance is "++showMixedAmountOneLine b
  g bs

-- Given a guess and an actual balance (both single-currency),
-- calculate the absolute percentage difference.
-- er :: (RealFrac a, RealFrac b) => a -> b -> b
c u b = let d=abs$round u-round b in round$fromIntegral d*100/b+0.001

{- 
balances.dev.hs, readable/dev version of hackage-10-80/balances (sm)
Tests/drills your financial situational awareness, asking for the balance
in random cash/liability accounts and reporting your accuracy.
Uses your default hledger journal if you have one:

$ ./balances.hs
  
otherwise finance data from elsewhere, in a hledger-readable format:

$ LEDGER_FILE=~/src/hledger/examples/sample.journal ./balances.hs


Code is fairly terse for easy minification.
Legend:
bs   balance report items
a    account name
b    account balance, possibly multicurrency
g    guess loop
u    guess
e    absolute percentage error of guess
c    calculate absolute percentage error of guess in main currency
d    absolute integer difference of guess
p    putStr

Reference
README
http://hackage.haskell.org/package/hledger-lib/docs/Hledger.html
http://hledger.org/scripting.html#hledger-lib-scripts
-}


-- Given a guess and an actual balance (both single-currency),
-- calculate their rounded difference and percentage difference.
-- er :: (RealFrac a, RealFrac b) => a -> b -> (Int, b)
-- er g b = let d=abs$round g-round b in (d,fromIntegral d*100/b+0.001)

-- Calculate an average, safely.
-- av :: (Fractional a, Foldable t) => t a -> a
-- av as = sum as / if null as then 1 else fromIntegral (length as)

-- And[Type[Asset,Liability],Sym$toRegex'$T.pack"^.$",Acct$toRegex'$T.pack"paypal"] }
-- Acct$toRegex'$T.pack"Vanguard:Cash" }

