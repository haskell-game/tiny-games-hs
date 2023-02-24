#!/usr/bin/env stack
-- stack script --resolver=ghc-9.2.5
import Imports;printSec sec=do{when(sec>=(-0.01))$do{printf
"\ESC[2K\ESC[A\ESC[2K%.2f secs\n"sec;threadDelay 20000;printSec(sec-0.02);}}
check=length.takeWhile(==True).zipWith(==)['a'..'z'];main=do{s<-getArgs;
hSetBuffering stdin NoBuffering;buf<-newIORef[];putStrLn"start\n\n";threadId<-
forkIO$forever$do{c<-getChar;atomicModifyIORef' buf(\cs->(c:cs,()));};printSec
(case s of{["-x"]->3::Double;["-h"]->5;["-e"]->10;_->7});putStrLn"\nend\n";
 killThread threadId;a<-reverse<$>readIORef buf;printf"you typed %s\n"a;
 printf"your score is: %.2f%%"(100*fromIntegral(check a)/26::Double);}

{-
default-10-80/type-and-furious (lsmor)

use flags -e -m -h -x to switch the difficulty level
see README.md 

Uses only base, but is in the default category to allow the separate import file.
-}