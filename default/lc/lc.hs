{import Import;data L=K Char|V Int|L L|A L L deriving(Eq);e=maybe;f g=fmap g;c=
char;j x=pure x;p=f fst.listToMaybe.reverse.filter(null.snd).readP_to_S l;a=f(V.
read.(:[]))(satisfy isDigit)<++(c '\\'*>f L l)<++(c '('*>l<*c ')')<++f K get;l=
chainl1 a(j A);s _(A(L f)x)=j(b 0 x f);s m(A g x)=(f A(s m g)<*>j x)<|>f(A g)(s
m x);s m(K x)=m!?x;s _ l=mzero;b _ _(K c)=K c;b i x(V j)|i==j=x|True=V j;b i x(L
l)=L(b(i+1)x l);b i x(A l r)=A(b i x l)(b i x r);r m l=e l(r m)(s m l);d l m q=j
(r m(foldl A l(f K i)))==p t where{(i,_:t)=break(=='=')q};z=putStr;y m q@((c,u):
v)=(z.unlines$f(c:)u)>>getLine>>= \i->case i of{(x:'=':w)->e(y m q)(\t->(\n->y n
(bool q v(e False(\l->all(d l n)u)(n!?c))))(insert x t m))(p w);_->y m q};y m _=
z"🏆";main=y empty[('z',["SZ=Z"]),('o',["SZ=SZ"]),('s',["zSZ=SZ","oSZ=S(SZ)"])]}
-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/lc (byorgey), ghc 9.2.5

See the accompanying README.md for details on how to play.

------------------------------------------------------------

Below is an unminified version of the code, with some extra bonus levels!

import           Import
data L = K Char | V Int | L L | A L L deriving (Eq)

p :: String -> Maybe L
p = fmap fst . listToMaybe . reverse . filter (null.snd) . readP_to_S l

int :: ReadP Int
int = read . (:[]) <$> satisfy isDigit

a :: ReadP L
a = (V <$> int) <++ (char '\\' *> (L <$> l)) <++ (char '(' *> l <* char ')') <++ (K <$> get)

l :: ReadP L
l = chainl1 a (pure A)

step :: Map Char L -> L -> Maybe L
step _ (A (L f) x) = Just (subst 0 x f)
step m (A f x)     = (A <$> step m f <*> pure x) <|> (A f <$> step m x)
step m (K x)       = m !? x
step _ l           = Nothing

subst :: Int -> L -> L -> L
subst _ _ (K c) = K c
subst i x (V j)
  | i == j = x
  | otherwise = V j
subst i x (L l) = L (subst (i+1) x l)
subst i x (A l r) = A (subst i x l) (subst i x r)

reduce :: Map Char L -> L -> L
reduce m l = maybe l (reduce m) (step m l)

------------------------------------------------------------

type Challenge = (Char, [String])

challenges :: [Challenge]
challenges =
  [ ('f', ["TF=F"])
  , ('t', ["TF=T"])
  , ('!', ["tTF=F", "fTF=T"])
  , ('&', ["ttTF=T", "tfTF=F", "ftTF=F", "ffTF=F"])
  , ('|', ["ttTF=T", "tfTF=T", "ftTF=T", "ffTF=F"])
  , ('z', ["SZ=Z"])
  , ('o', ["SZ=SZ"])
  , ('s', ["zSZ=SZ", "oSZ=S(SZ)"])
  , ('w', ["SZ=S(SZ)"])
  , ('+', ["zzSZ=Z", "ooSZ=S(SZ)", "woSZ=S(S(SZ))"])
  , ('*', ["zoSZ=Z", "ooSZ=SZ", "wwSZ=S(S(S(SZ)))"])
  , ('h', ["SZ=S(S(SZ))"])
  , ('^', ["woSZ=SZ", "whSZ=S(S(S(S(S(S(S(SZ)))))))"])
  ]

check :: Map Char L -> Challenge -> Bool
check m (n,cs) = maybe False (\l -> all (checkOne l m) cs) (m !? n)

checkOne :: L -> Map Char L -> String -> Bool
checkOne cand m test = reduce m (foldl' A cand (map K ins)) == fromJust (p l)
  where
    (ins, _:l) = break (=='=') test

------------------------------------------------------------

showChallenge :: Challenge -> String
showChallenge (n, cs) = unlines $ map (n:) cs

play :: Map Char L -> [Challenge] -> IO ()
play m [] = putStrLn "You win!"
play m (c:cs) = do
  putStr $ showChallenge c
  putStr "> "
  inp <- getLine
  case inp of
    (x : '=' :rest) -> case p rest of
      Nothing -> putStrLn "Parse error" >> play m (c:cs)
      Just t  -> do
        let m' = insert x t m
        case check m' c of
          True  -> putStrLn "Yay!" >> play m' cs
          False -> putStrLn "Boo" >> play m' (c:cs)
    _ -> putStrLn "Parse error" >> play m (c:cs)
  return ()

main :: IO ()
main = play empty challenges

------------------------------------------------------------
-- For debugging / development only

pretty :: L -> String
pretty = prettyP 0
  where
    prettyP _ (K c)   = [c]
    prettyP _ (V n)   = show n
    prettyP p (L l)   = parens (p > 0) ('λ' : prettyP 0 l)
    prettyP p (A l r) = parens (p > 1) (prettyP 1 l ++ prettyP 2 r)

parens True  = ("("++) . (++")")
parens False = id


-}
