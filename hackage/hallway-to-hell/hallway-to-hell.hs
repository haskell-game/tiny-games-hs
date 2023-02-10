import RIO
import System.Random
move k c = if c=='a' then k-1 else if c=='d' then k+1 else k
run v b = threadDelay 200000 >> putStr "\ESC[2J" >> readIORef v >>= \k -> mapM_ 
  putStrLn("\n":b++[replicate k ' '++"^"])>>when(last b!!k==' ') (up b>>=run v)
up b = (\t -> ("X" ++ f t (init $ tail $ head b)++ "X") : init b) <$> randomIO
  where f t hb = if t then "X"++init hb else tail hb++ "X"
key v = readIORef v >>= \k -> getChar >>= writeIORef v . move k>> key v
main = hSetBuffering stdin NoBuffering >> newIORef 11 >>= \v->
  concurrently_ (key v) (run v $ replicate 10 $ "X" ++ replicate 21 ' ' ++ "X")
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/hallway-to-hell (juliendehos)

stack runghc hallway-to-hell.hs --resolver lts-20.10 --package rio --package random

-}
