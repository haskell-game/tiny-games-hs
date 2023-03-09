#!/usr/bin/env stack
-- stack script --compile --resolver=lts-20.13 --package gloss --package random
import Import
main = do -- hackage-10-80/guesscolor (TravisCardwell)
  [r, g, b] <- take 3 . randomRs (0, 255) <$> newStdGen
  _ <- forkIO $ display (InWindow "" (96, 96) (8, 8)) (makeColorI r g b 0) Blank
  [r', g', b' :: Int] <- map read . words <$> getLine
  putStrLn . unwords $ "Actual color:" : map show [r, g, b]
  let x = sqrt (fromIntegral $ (r - r')^2 + (g - g')^2 + (b - b')^2) / 4.4167296
  putStrLn ("Score: " ++ show (100 - ceilingFloatInt x)) >> exitSuccess
