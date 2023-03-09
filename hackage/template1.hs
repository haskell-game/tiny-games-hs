#!/usr/bin/env stack
-- stack --verbosity=info script --compile --resolver=lts-20.13 --package gloss
import Graphics.Gloss
main = do
  let msg = "Press Escape to quit"
  putStrLn msg
  display (InWindow msg (400, 400) (10, 10)) white (Circle 150)



-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/template1 (mynick)

The build command, needed here if not included at the top:
stack script --compile template1.hs --resolver lts-20.13 --package gloss

gloss requires a compiled program, hence script --compile

https://hackage.haskell.org/package/gloss/docs/Graphics-Gloss.html

-}
