#!/usr/bin/env runghc -XLambdaCase
{-# LANGUAGE LambdaCase #-}

m = ["Adam ", "Bela ", "Csaba", "David", "Edgar", "Felix", "Geza ", "Hugo ", "Imre "]

f = ["Judit", "Klara", "Lujza", "Maria", "Nora ", "Oxana", "Paula", "Rozsa"]

z b x y =
  if b
    then x
    else y

h m f l = y (++) (a 6 "     " ++ m) $ p (s ' ') $ x (y (:)) (a 5 "") f ++ "" : p (p (" .v" !!)) l

d x = c . takeWhile ((x /=) . head)

e i = (\(l, _:r) -> l ++ r) . t i

w m f l =
  let q = getLine >>= \r@(~[y, x]) -> (\i j -> z (c r /= 2 || l !! j !! i < 2) q $ w (e j m) (e i f) (e i `p` e j l)) (d x f) (d y m)
   in z (all (all (2 >)) l) (b $ z (f == []) "SUCCESS" "FAIL") $ mapM b (h m f l) >> q

i j c = ((\(l, v:r) -> l ++ c v : r) .) . t . mod j

g (o:p:q:r) l =
  z (mod o 10 == 0 && all (\s -> c [k | k <- l, any ((1 <) . (k !!)) s] >= c s) (x (\r -> (>>= \q -> [r : q, q])) [[]] [0 .. 7])) (l, r) $
  g r $ i p (i q (\_ -> 2) 8) 9 l

main =
  let n r = (\(l, q) -> w m f l >> b (a 40 '=') >> n q) $ g r $ a 10 $ a 8 1 ++ [0]
   in n $ p (`div` 2 ^ 16) $ iterate (\k -> mod (k * 22695477 + 1) (2 ^ 32)) 9

a = replicate

b = putStrLn

c = length

p = map

t = splitAt

y = zipWith

x = foldr

s c = (c :) . (>>= (: [c]))
