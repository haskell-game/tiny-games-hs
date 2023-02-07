#!/usr/bin/env stack  # gam-10-80-hs-hackage/template1 (mynick)
-- stack --verbosity=info script --compile --resolver=lts-20.9 --package gloss
  -- gloss requires --compile
import Graphics.Gloss
  -- https://hackage.haskell.org/package/gloss/docs/Graphics-Gloss.html
main = do
  let msg = "Press Escape to quit"
  putStrLn msg
  display (InWindow msg (400, 400) (10, 10)) white (Circle 150)

-- ^10 ------------------------------- 80> -------------------------------------