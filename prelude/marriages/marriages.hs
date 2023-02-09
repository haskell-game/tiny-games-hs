#!/usr/bin/env -S runghc -cpp -DD=a=replicate;b=putStrLn;c=length;p=map;u=max(2)
main = n $ p (`div` 2 ^ 16) $ iterate (\k -> mod (k * 22695477 + 1) (2 ^ 32)) 9

n r = (\(l, q) -> w 8 l >> b (a 40 '=') >> n q) $ g r $ a 10 $ a 8 1 ++ [3]

g (o:p:q:r) l =
  z (o < 6555 && all (\s -> c [k | k <- l, any ((1 >) . (k !!)) s] >= c s) (foldr (\r -> (>>= \q -> [r : q, q])) [[]] [0 .. 7]))
    [g r $ i p (i q (* 0) 8) 9 l, (l, r)]

w n l = z (all (all (0 <)) l) [mapM b (h l) >> q n l, b $ z (n < 1) ["LOSS", "WIN"]]

z b = (!! fromEnum b)

h l = zipWith (++) (a 6 "     " ++ m) $ p (s ' ') $ f ++ "" : p (p ("X.O " !!)) l

d x = c . takeWhile (x /=)

q n l =
  getLine >>= \r@(~[y, x]) ->
    (\k j -> z (c r /= 2 || l !! j !! k > 0) [w (n - 1) (p (i k u 8) $ i j (p u) 9 l), q n l]) (d x $ f !! 0) (d y $ p (!! 0) m)

i j c = ((\(l, v:r) -> l ++ c v : r) .) . splitAt . mod j

f = y "JKLMNOPR\nuluaoxao\ndajrrauz\nirzianls\ntaaa aaa"

s c = (c :) . (>>= (: [c]))

m = y "Adam \nBela \nCsaba\nDavid\nEdgar\nFelix\nGeza \nHugo \nImre "

y = lines

--{-
a = replicate

b = putStrLn

c = length

p = map

u = max (2)
-- >>> fromEnum 'A'
-- 65
-- >>> fromEnum 'J'
-- 74
-- >>> :t (<$>)
-- (<$>) :: Functor f => (a -> b) -> f a -> f b
--
--}
