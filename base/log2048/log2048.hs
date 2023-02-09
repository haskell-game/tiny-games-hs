import Data.List ; g = map (p . c . filter (> 0)) ; p = take 4 . (++ repeat 0)
r = reverse . transpose ; q = putStrLn . unlines . map (map(".0123456789AB"!!))
c (x : y : z) | x == y = 1+x : c z ; c (x : z) = x : c z ; c [] = []
f x k = foldr (\j -> if k == j then g . r else r) x "hjlk"
h u x = s u x id where{ s i [] k | i == u = error "You lose!" | True = h i x ;
s 0 (0 : t) k = k (1 : t) ; s i (0 : t) k = s (i-1) t (k . (0 :)) ; s i (j : t)
k = s i t (k . (j :))} ; e = map (take 4) . take 4 . iterate (drop 4)
l (y : z) x | (_ : _) <- filter (== 12) (concat x) = q x >> putStrLn "You won!"
  | True = do{q x ; getLine >>= l z . e . h y . concat . f x . head}
main = print "keys: hjkl">>(l (cycle [3,14,15,9,2,65,3,5]) . e . h 2 . repeat) 0
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-base/log2048 (Lysxia), ghc 9.2.5

runghc hallway-to-hell.hs

A clone of the game 2048

Goal: Combine the tiles to get logBase 2 2048!
Controls: hjkl
  h - left
  j - down
  k - up
  l - right

-}
