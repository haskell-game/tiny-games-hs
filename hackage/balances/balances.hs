#!/usr/bin/env stack
-- stack script --resolver lts-20 --package "random text hledger-lib"
import Import;p=putStrLn;main=defaultJournal>>=g.fst.balanceReport defreportspec
 {_rsQuery=Type[Cash,Liability]};g bs=if null bs then p"no balances" else do{i<-
randomRIO(0,length bs-1);let{(a,_,_,b0) = bs !! i};u<-p(unpack a++" balance ? ")
>>getLine;let{b=mixedAmountStripPrices b0;q=maximum$0:map(abs.aquantity)(amounts
b);e=c(read u)q};p$(if e<=10 then "✅ " else "❌ ")++(if e<1 then "right!" else
show e++"% off")++", balance is "++showMixedAmountOneLine b;g bs;}
c u b=let d=abs$round u-round b in round$fromIntegral d*100/b+0.001

-- ^10 ------------------------------------------------------------------ 80> --
{- 
hackage-10-80/balances (sm)
This "game" tests/drills your financial situational awareness, asking hledger
for the balance in random cash/liability accounts. Not super fun but could be
a useful practice, since it's easy to keep detailed records in hledger and yet
still be unclear about current balances.

Uses your default hledger journal if you have one:

$ ./balances.hs
  
otherwise hledger-readable data from elsewhere:

$ curl -O https://raw.githubusercontent.com/simonmichael/hledger/master/examples/templates.journal
$ export LEDGER_FILE=$PWD/templates.journal

For each requested account balance, enter a positive integer
(for multicurrency balances, just guess the most numerous currency).
Within 10% is a success, within 1% is perfect.
Control-d to end. An example:

$ hledger bs type:CL   # optional; review balances
Balance Sheet 2013-01-31

                                           || 2013-01-31 
===========================================++============
 Assets                                    ||            
-------------------------------------------++------------
 assets:bank:bank1:checking                ||     $25750 
 assets:bank:bank1:prepaid revenue:client1 ||      $8000 
 assets:bank:checking                      ||       $-50 
-------------------------------------------++------------
                                           ||     $33700 
===========================================++============
 Liabilities                               ||            
-------------------------------------------++------------
 liabilities:prepaid revenue:client1       ||      $8000 
 liabilities:tax:federal:2010              ||      $3750 
 liabilities:tax:federal:2011              ||      $3750 
 liabilities:tax:state:2010                ||       $900 
 liabilities:tax:state:2011                ||      $1200 
-------------------------------------------++------------
                                           ||     $17600 
===========================================++============
 Net:                                      ||     $16100 
$ clear
$ ./balances.hs        # test your recall
assets:bank:checking balance ? 
8000
❌ 15900% off, balance is $-50
liabilities:tax:federal:2011 balance ? 
3000
❌ 20% off, balance is $-3750
liabilities:tax:state:2011 balance ? 
1000
❌ 17% off, balance is $-1200
liabilities:tax:federal:2010 balance ? 
4000
✅ 7% off, balance is $-3750
assets:bank:checking balance ? 
25000
❌ 49900% off, balance is $-50
liabilities:tax:state:2010 balance ? 
1200
❌ 33% off, balance is $-900
assets:bank:bank1:prepaid revenue:client1 balance ? 
8000
✅ right!, balance is $8000
assets:bank:checking balance ? 
balances.hs: <stdin>: hGetLine: end of file

Unminified version: balances.dev.hs.
-}
