#!/usr/bin/env stack
-- stack script --resolver=lts-20
at [c,r] f = fmap reverse.traverse (\(j,row) -> traverse (\(i,p) -> if [i,j]==[c
  ,r] then f p else pure p) (zip ['a'..] row)) . zip ['1'..].reverse
([fc,fr]>-[tc,tr])b=(head.at[fc,fr](pure.const '⋅').head.at
  [tc,tr](pure.const(head(fst(at[fc,fr](flip(,)' '.pure) b)))))b
num b = l:h:(reverse.zipWith(\r s->(r:'|':s)++['|',r])['1'..].reverse)b++[h,l]
  where l="  "++(fst<$>zip['a'..](head b))++"  "; h=const '—'<$>l
run b = (putStrLn.unlines.num)b>>putStr "Enter move (e.g. e2-e4): ">>getLine>>=
  \i->case i of {[x,y,'-',u,v]->run (([x,y]>-[u,v]) b); _ -> run b}
main=run$["♜♞♝♛♚♝♞♜","♟♟♟♟♟♟♟♟"]++replicate 4"⋅⋅⋅⋅⋅⋅⋅⋅"++["♙♙♙♙♙♙♙♙","♖♘♗♕♔♗♘♖"]
