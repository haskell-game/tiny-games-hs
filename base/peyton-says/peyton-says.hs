#!/usr/bin/env runhaskell
import System.IO;import Control.Concurrent;import Control.Monad;import GHC.Clock
import Data.Char;main=c>>m0>>hSetBuffering stdin NoBuffering>>getChar>>e""
p y=c>>mapM_ (\x->m1>>d 300000>>putStrLn [x]>>d 700000>>c) y>>e y
e y=mapM_(i y)y>>rnd>>= \x->p(y++[x]);c=putStr "\^[[2J\^[[H";d=threadDelay
rnd=(chr.fromIntegral.(+49).(`mod`4))<$>getMonotonicTimeNSec
f y=error("You got as far as " ++ show(length y) ++ " steps:\n" ++ y)
i y x=m2>>getChar>>= \j->c>>if j`elem`"1234" then unless(j==x)(f y)else i y x
m1=putStrLn "\n\nSimon Peyton Jones says:";m2=putStrLn "\n\nYour turn!"
m0=putStrLn "\n\nRepeat what Simon says!\nPress a key when ready."
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-base/peyton-says (gergoerdi)

Repeat what Simon (Peyton Jones, of course) says! Press the same
sequence of digits as flashed on the screen. The sequence keeps growing,
until you make a mistake.
-}
