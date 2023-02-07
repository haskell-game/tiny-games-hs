#!/usr/bin/env stack
-- stack script --resolver=lts-20.9 --package random --verbosity=error
import System.IO (hFlush, stdout)
import System.Random (randomRIO)
main = let m = 10 in do { n <- randomRIO (1,m::Int);
 putStrLn $ "I'm thinking of a number between 1 and "++show m++", what is it ?";
 putStr "Guess: "; hFlush stdout; g <- read <$> getLine; if g /= n
 then putStrLn ("Wrong! It was "++show n++". Try again.") >> main
 else putStrLn "Right! You win." }

--11---------------------------------80-----------------------------------------
