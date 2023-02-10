{main=do{q"Seed:\n";n<-readLn;o.m(u n s)[].head.l(u n i)(w n s)$p 9(p 9(1>0,'.')
)};x=zipWith;q=putStr;o g=do{q.unlines.z.d[p 13'-'].c$b(z.z.d["|"].c.b r)g;x:y:c
:_<-getLine;o.j.b(b((,)(1>0).snd))$v(read[x]-1,read[y]-1)g c};d x y=x:h(\z r->z:
x:r)[]y;h=foldr;j=z.b(t.z.b c).c.b k.z.b(b z.c.t).c.t.b k.t.b k;k g=b(\(h,x)->(x
<'0'||h&&2>length(filter(elem x)g),x))g;t=h(x(:))$p 9[];c(x:y:z:r)=[x,y,z]:c r;c
[]=[];s=b(,)f<*>f;f=[0..8];a=all(all fst).j;b=map;l _[]g=[g];l f(p:r)g=[j|h<-v p
g<$>f,a h,j<-l f r h];p=replicate;m(p:r) q g=last$g:[m r(p:q)h|let h=v p g '.',[
_]<-[l i(p:q)h]];v(x,y)g d=e x(e y(d<$))g;z=concat;e 0 f(x:r)=f x:r;e n f(x:r)=x
:e(n-1)f r;u _[]=[];u n x=let y:z=w n x in y:u(0xe817fb2d*n)z;i=['1'..'9'];r(h,x
)|h=[x];r(_,x)="\27[31m"++x:"\27[0m";w n y=x const(drop(n`mod`81)$cycle y)y}{--}
-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/sudoku (elderephemera), ghc 9.2.5

This is a Sudoku puzzle generator and interactive solver. Sudokus are solved by
filling in a 9x9 grid with digits 1 through 9 such that each of the 9 columns, 9
rows, and 9 3x3 regions contain each digit exactly once. The puzzles generated
by this program have a unique solution. Additionally, while solving, repeated
digits are highlighted red to allow the solver to catch mistakes early.

This program can be run with `runghc sudoku.hs`. This should just work on any
platform, though if your terminal does not support VT100 codes the highlighting
will not work (on windows this must be enabled).

To use the interactive solver, first enter a seed to start the generating a
Sudoku. You can just mash on the number keys; as long as you enter a valid
integer it will work. Generation usually takes around 15 seconds or less, but
can take a couple minutes, maybe more. Feel free to restart with a different
seed if you're impatient. To solve the puzzle, use three character commands
where the first character represents a row, the second is the column, and the
third is the digit to insert (or '.' for erasing a digit). For example, entering
"641" will put the digit '1' in row 6 column 4 (rows start from the top, columns
from the left).

The implementation keeps state as a grid of characters tagged with whether or
not they are repeated (the type is `[[(Bool, Char)]]`) with blank cells
represented by the `'.'` character. This same representation is used during
generation as well. The generator starts with a blank board and a randomized
(based on the given seed) digit priority and starting position. Then the digits
are filled in order by a simple backtracking solver to obtain a completed Sudoku
board. Then, cells are emptied in a random order as long as there continues to
be a single valid way to solve the puzzle (checked using the same solver).
-}
