#!/usr/bin/env stack
-- stack script --resolver lts-20 --package random
import Control.Monad (when);import System.Random (uniformR, newStdGen)
l=length;f=sum. fmap fromEnum;p=putStrLn;(x:xs)!!!0=(x,xs);(x:xs)!!!n=(x:)<$>(xs
 !!!(n-1));r n x g=let{(i,h)=uniformR(0,l x-1)g;(z,y)= x!!!i}in if n==1 then[z]
else z:r(n-1)y h;main=turn 10. r 4['0'..'9']=<<newStdGen;turn 0 s=p"You lost :("
 *>p("The secret was: "<>s);turn a s=p(show a<>" attempts left")*>getLine>>= \g
 ->do if(l g/=4)then do{p$"You need to guess 4 digits";turn a s}else do{let{b=f$
zipWith(==)g s;c=f((flip elem g)<$>s)-b};if b==4 then p"You won!"else do{p(show
b<>" bulls and "<>show c<>" cows");turn(a-1)s}}
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-hackage/bullsandcows (akadude)
-}
