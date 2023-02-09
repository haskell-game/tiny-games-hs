#!/usr/bin/env -S runghc -XPatternSynonyms -XLambdaCase
pattern N='\n';pattern S=' ';r g@(S:N:_)=g;r(S:x:y)=x:S:y;r(a:y)=a:r y;r[]=[]
l g@(N:S:_)=g;l(x:S:y)=S:x:y;l(a:y)=a:l y;l[]=[];o(S:a:b:c:N:d:y)=d:a:b:c:N:S:y
o(S:a:b:N:c:d:y)=d:a:b:N:c:S:y;o(S:a:N:b:c:d:y)=d:a:N:b:c:S:y
o(S:N:a:b:c:d:y)=d:N:a:b:c:S:y;o(a:y)=a:o y;o[]=[];q="\x1b[2J\x1b[H"
u[]=[];u(a:b:c:d:N:S:y)=S:b:c:d:N:a:y;u(a:b:c:N:d:S:y)=S:b:c:N:d:a:y
u(a:b:N:c:d:S:y)=S:b:N:c:d:a:y;u(a:N:b:c:d:S:y)=S:N:b:c:d:a:y
u(a:y)=a:u y;main=interact$g"1234\n5678\n9abc\nfde \n".(S:);g _[]=[]
g s(x:xs)=q++n++m s++v++g((case x of{'w'->o;'a'->r;'s'->u;'d'->l;_->id})s)xs
n="+----+\n";v=n++"[wasd] ";m=unlines.fmap(('|':).(++"|")).lines
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-prelude/fifteen (bradrn)

This is an implementation of the famous 'Fifteen Puzzle'. The goal is to
get all fifteen blocks in the puzzle (represented as hexadecimal digits)
into the correct order, using the single blank space to move them around.
Control using 'w'/'a'/'s'/'d' to move the appropriate block into the gap.
Use ^C to halt.

The implementation is fairly simplistic. User input is processed using the
same 'interact' trick as in TristanCacqueray's pure-doors. (Not that it's
much of a trick; this is just how 'interact' works! I've done something
very similar before in a different context.)

Game state is stored as a single string: e.g. the solved state would be
"1234\n5678\n9abc\ndef \n".  The bulk of the implementation is dedicated
to moving the blocks around. Judicious pattern-matching means we can permute
the relevant characters of the string and do bounds-checking at the same time!
This is possible because the game state string provides all the required
information: ' ' shows where the empty block is, and the newlines provide the
edges of the grid.
-}
