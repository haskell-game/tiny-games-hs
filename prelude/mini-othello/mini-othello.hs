main=do{let{infixr 1?;(True?x)_=x;(_?_)y=y;k=(<*>)=<<((,)<$>);f=foldl;o=1:2:o;(&
)=map;r=[0..7];c=(length.).filter.(==);s=show&r;l(x,y)=8*y+x;(w^i)b=take i b++w:
drop(i+1)b;u=(putStrLn.).f(++);t=y.splitAt 8;y([],_)_=u" "s;y(a,b)k=u(k!!0)[(n!!
)&a]>>t b(drop 1k);n="_XO";a%c=f(\a d->v a a c d 0)(a,0)(k[-1..1]);v k(a@(b,w),c
)p@(x,y)q@(m,n)s=let{j x=x>=0&&x<8;r=j x&&j y;t=l p;e=b!!t;g=v k((w^t$b,w),c+1)(
x+m,y+n)q}in s==0?(e==0?g 1$k)$s==1?(r&&e==o!!w?g 2$k)$not r||e==0?k$e==w?(a,c+1
)$g 2;q a d|((b,w),c)<-a%d=(c==0?b$(w^l d$b),o!!w);z h a@(b,w)=print(n!!w,(`c`b)
&[0..2])>>t b s>>(w/=h?z h(e a)$getLine>>=z h.q a.read);i=fst;j=snd;g h a=f(\c e
->i e>i c?e$c)(-65*h,(0,0))$(\((b,p),d)->(h*(h*p==0?j a`c`i b$i$g(div h(-2))b),d
))&(((,)=<<(a%))&k r);e a=q a.j$g 4a};z 1(1^35$1^28$2^27$2^36$replicate 64 0,1)}
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-prelude/mini-othello (hellwolf), ghc 9.4.2
https://hackage.haskell.org/package/base/docs/Prelude.html

= Description

This is a minimum Othello implementation with MiniMax "AI" opponent using GHC 9.X
with only prelude.

(Taken from its [wikipedia](https://en.wikipedia.org/wiki/Reversi) entry.)

About Othello(Reversi): Reversi is a strategy board game for two players, played
on an 8×8 uncheckered board. It was invented in 1883. Othello, a variant with a
fixed initial setup of the board, was patented in 1971.

There are sixty-four identical game pieces called disks, which are light on one
side and dark on the other. Players take turns placing disks on the board with
their assigned color facing up. During a play, any disks of the opponent's color
that are in a straight line and bounded by the disk just placed and another disk
of the current player's color are turned over to the current player's color. The
objective of the game is to have the majority of disks turned to display one's
color when the last playable empty square is filled.

= How To Play

== Game Setup

1) By default, AI will play the white side. You may change this by altering the
   first argument to which @z@ function is invoked.
2) The game is equipped with a AI with MiniMax strategy. You may also alter game
   difficulties by tuning @g 4a@ to @g 8a@, @g 16a@, etc. If you wish to write
   your own, change @e@ function.
3) There is no error handling in general, any unexpected input may crash the
   program or result in unexpected state.
4) The program is tested with runghc-9.4.2.

== Initial Screen

@
("X",[60,2,2])
0________
1________
2________
3___OX___
4___XO___
5________
6________
7________
 01234567
@

1) The first line @("W",[60,2,2])@ is "game status line":
  * Whose turn? The game always starts from the black side, where 'X' means
    black side's turn, 'O' means white side's turn.
  * How many empty spots left? It starts with 60.
  * How many black pieces on the board? 2.
  * How many white pieces on the board? 2.

2) The second line is for values of the x-axis.

3) The rest is the printout of the board:
  * The first column is for values of the "y-axis".
  * The rest are the cells with pieces: "X" means a black piece, "O" means a
    white piece, and "_" means empty cells.

== Make A Move

1) You are expected to type a input conforming to @read::(Integer,Integer)@ as the
coordinate where you wish to put your piece to.

2) For instance, you make a move at @(3,2)@ which then should progress the game to
next turn:

@
(3,2)
("O",[59,4,1])
0________
1________
2___X____
3___XX___
4___XO___
5________
6________
7________
 01234567
@

3) If you make an invalid move, it is considered to yield the turn. You may be
forced to do so in some cases to move the game forward.

4) AI should make a move next, and then it should be back to you:

@
("X",[58,3,3])
0________
1________
2__OX____
3___OX___
4___XO___
5________
6________
7________
 01234567
@

== Game Ending

You should keep making moves until you cannot.

1) The game status line should indicate who has the most pieces on the board.
2) AI may run out of moves, and it may simply crash the program :/.
3) The game won't announce the winner automatically, don't be upset :).

An example ending:

@
("O",[1,53,10])
0XXOXXXXX
1XXXOXXXX
2XXXXXXXX
3XXXXOXXX
4XOOXXOXX
5XOOXXXOO
6XXXXXXX0
7XXXXXXXX
 01234567
@

= Technical Notes

@
-- | Game state type alias
type GameState = (Board, Side)

-- | Check number of flips for one single direction
v :: GameState -> (GameState, Int) -> Coordinate -> StepCoordinate -> State
  -> (GameState, Int)
v savedGameState (currentGameState, nFlips) cor stepCor state
  -> (newGameState, nFlips)

-- | Trial play
(%) :: GameState -> Coordinate -> (GameState, Int)
(%) inGameState -> cor -> (outGameState, nFlips)

-- | Play and move to next round
q :: GameState -> Coordinate -> GameState
q currentGameState -> cor -> nextRoundGameState

-- | Start game
z :: Side -> GameState -> IO ()
z humanSide (initialBoard,currentSide)

-- | Strategy function!
e :: GameState -> GameState

This generates a sequence of [(nFlips, (x,y)), ...]
((,)=<<snd.(a%))&k r

-- | Naive strategy

e a=q a.snd.head.f((>0).fst).m((,)=<<snd.(a%)$k r
-------------------------------------------------

-- | Greedy strategy
e a=q a.snd.f(\c@(w,_)e@(d,_)->d>w?e$c)(0,(0,0)).m((,)=<<snd.(a%))$k r
-----------------------------------------------------------------------

-- | MiniMax strategy
i=fst;j=snd;
g h a=f(\c e->i e>i c?e$c)(-65*h,(0,0))$
        (\((b,p),d)->(h*(h*p==0?j a`c`i b$i$g(div h(-2))b),d))&
        (((,)=<<(a%))&k r);
e a=q a.j$g 4a

-- Other optimizable statements?
@

-}
{-
Local Variables:
fill-column: 80
End:
-}
