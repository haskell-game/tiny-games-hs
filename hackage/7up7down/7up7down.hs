#!/usr/bin/env stack
-- stack --resolver lts-20 script --package random --compile
import GHC.Clock;import Data.Bifoldable;import System.IO;r=fromEnum.(+1).(`mod`6
 ).(`div`1000)<$>getMonotonicTimeNSec; d n=putStr$toEnum<$>[9855+n,32];main=g 10
g b=if(b<=0)then putStrLn"c ya l8r l0$3r"else putStr("balance=₹"++(show b)++"|b\
\et=₹1|7/7up/7down/q: ")>>hFlush stdout>>getLine>>= \i->if i/="q"then(,)<$>r<*>r
 >>= \(x,y)->bimapM_((d x>>d y>>).putStrLn)g$if(x+y>7&&i=="7up")||(x+y<7&&i=="7\
\down")||(x+y==7&&i=="7")then("You win!",b+1+fromEnum(i=="7"))else("You lose!",b
 -1) else putStrLn"Bye!"
-- ^09 ------------------------------------------------------------------ 80> --
--
-- Category: hackage-10-80
-- Tested with: GHC 9.2.6
-- Author: @akshaymankar
--
-- Guess the result of rolling two 6 sided dice by writing one of 7up, 7down or
-- 7.
-- 7up wins if the result greater than 7
-- 7down wins if the result is less than 7
-- 7 wins if the result is exactly 7.
-- Starting balance is ₹10, every bet is ₹1.
-- On victory with 7up or 7down, the player wins ₹1
-- On victory with a 7, the player wins ₹2.
-- Enter q instead of a guess to exit.
-- Any invalid inputs (including typos) lose.
