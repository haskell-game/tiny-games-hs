#!/usr/bin/env stack
-- stack --verbosity=info script --compile --resolver=lts-20.9 --package gloss
import Graphics.Gloss
main = do
  let msg = "Press Escape to quit"
  putStrLn msg
  display (InWindow msg (400, 400) (10, 10)) white (Circle 150)



-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-hackage/template1 (mynick). ghc-9.4, gloss

gloss requires a compiled program, hence --compile above
https://hackage.haskell.org/package/gloss/docs/Graphics-Gloss.html

-}
