#!/usr/bin/env stack
-- stack script --resolver lts-20 --package "random text Decimal hledger-lib"
import Import;p=putStrLn;q=Type[Asset,Liability];main=defaultJournal>>=gu.fst.
 balanceReport defreportspec{_rsQuery=q};gu[]=p"";gu bs=do{i<-randomRIO(0,length
bs-1);let{(a,_,_,b0)=bs!!i};putStr$"\n"++unpack a++" balance ? ";g<-getLine;let{
b=mixedAmountStripPrices b0;q=maximum$0:map(abs.aquantity)(amounts b);(d,e)=er(
read g)q;f=roundTo 1e;s=100-min 100f};if d/=0then p("Off by ~"++show d++
", score: "++show s)>>gu bs else p$"Correct! It is "++showMixedAmountOneLine b++
".";};er g b=let d=abs$round g-round b in(d,fromIntegral d*100/b+0.001);av as=
 sum as/if null as then 1else fromIntegral(length as)
-- ^10 ------------------------------------------------------------------ 80> --
{- 
hackage-10-80/guess-balance
Tests/drills your financial situational awareness, asking for the balance
in random asset/liability accounts until you get one right.
Uses your default hledger journal if you have one:

$ ./guess-balance.hs
  
otherwise finance data in a hledger-readable format, from somewhere else:

$ LEDGER_FILE=~/src/hledger/examples/sample.journal ./guess-balance.hs
-}
