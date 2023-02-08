#!/usr/bin/env stack  # gam-10-80-hs-default/wordle (halogenandtoast)
-- stack --verbosity=error script --resolver=lts-20.9 --package random
import System.Random (randomRIO)
main=let d=["pearl","rogue","rusty","sheet","label","fjord","orate","haunt"] in
  (!!) d <$> randomRIO (0,7) >>= \ws -> let
    m (g, w) = if g == w then 'x' else if g `elem` ws then 'o' else ' '
    l n = if n == 6 then putStrLn "You lose" else getLine >>= \gs ->
      if gs == ws then putStrLn "You win" else putStrLn (map m $ zip gs ws)
      >> l (n + 1) in l 0

-- ^10 ------------------------------- 80> -------------------------------------
