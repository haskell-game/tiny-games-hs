#!/usr/bin/env runghc
main = w [] "hi!";t=curry;y=uncurry;
w a s = do {putStrLn$"> "++s; d<-getLine; let{f=(d,s):a;
 (g,h) = u(q d.snd) f};w f g};u a=snd.minimum.map(\s->(a s,s))
q xs ys = last (foldl(v ys)row0 xs)
 where{row0 = scanl(\w _->w+1)0 ys;z x l y lt t|x==y=lt|scs<=scr&&
 scs<=sca=scs|sca<=scr=sca|1>0=scr where{sca=l+1;scr=t+1;scs=lt+1};
 c x l=y(y(z x l));v ys da@(~(dn:ds))x=scanl(c x)(dn+1) (zip(zip ys da)ds)}


-- ^10 ------------------------------------------------------------------ 80> --
-- prelude-10-80/companion.hs (Greg B.)
-- A chatbot that learns to hold a dialogue. It "learns" to speak to you the way you speak to it.
-- To use it, simply start up a conversation. Be patient; the chatbot "knows" nothing at first.
-- The levenshtein distance implementation is taken from the 'levenshtein' package:
-- https://hackage.haskell.org/package/levenshtein-0.2.1.0/docs/Data-Foldable-Levenshtein.html
