main=do{let{i a b c=if a then b else c;m=map;f=filter;k=[0..7];r=[-1..1];j x=x>=
0&&x<=7;l(x,y)=8*y+x;o 1=2;o _=1;c=(length.).f.(==);g w i b=take i b++w:drop(i+1
)b;s=m show k;u=(putStrLn.).foldl(++);v k(a@(b,w),c)p@(x,y)q@(m,n)s=let{r=j x&&j
y;t=l p;e=b!!t;f=v k((g w t b,w),c+1)(x+m,y+n)q;h|s==0=i(e==0)(f 1)k|s==1=i(r&&e
==o w)(f 2)k|s==2=i(not r||e==0)k(i(e==w)(a,c+1)(f 2))}in h;p a c=foldr(\d k->v
k k c d 0)(a,0)[(i,j)|i<-r,j<-r];n 0="_";n 1="X";n 2="O";y([],_)_=pure();y(a,b)k
=u(k!!0)(m n a)>>t b(drop 1 k);q a d=let((b,w),c)=p a d in i(c==0)a(g w(l d)b,o
w);z h a@(b,w)=print(n w,m(`c`b)[0..2])>>u" "s>>t b s>>i(w==h)(getLine>>=z h.q a
.read)(z h(e a));t=y.splitAt 8;e a=q a.snd.head.f((>0).snd.fst).m((,)=<<p a)$[(i
,j)|i<-k,j<-k]};z 1(g 1 35.g 1 28.g 2 27.g 2 36$replicate 64 0,1)}
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-prelude/mini-othello (hellwolf), ghc 9.4.2
https://hackage.haskell.org/package/base/docs/Prelude.html

= Description

This is a minimum Othello implementation with greedy "AI" opponent using GHC 9.X
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

1) By default, AI will play the white side. You may change this by altering how
   @z@ function is invoked.
2) The game is equipped with a AI with greedy strategy, which is to say, not so
   smart. If you wish to write your own, change @e@ function, but we have run
   out of lines...
3) There is no error handling in general, any unexpected input may crash the
   program or result in unexpected state.
4) The program is tested with runghc-9.4.2.

== Initial Screen

@
("X",[60,2,2])
 01234567
0________
1________
2________
3___OX___
4___XO___
5________
6________
7________
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

You are expected to type a input conforming to @read::(Integer,Integer)@ as the
coordinate where you wish to put your piece to.

For instance, you make a move at @(3,2)@ which then should progress the game to
next turn:

@
(3,2)
("O",[59,4,1])
 01234567
0________
1________
2___X____
3___XX___
4___XO___
5________
6________
7________
@

AI should make a move next, and then it should be back to you:

@
("X",[58,3,3])
 01234567
0________
1________
2__OX____
3___OX___
4___XO___
5________
6________
7________
@

== Game Ending

You should keep making moves until you cannot.

1) The game status line should indicate who has the most pieces on the board.
2) AI may run out of moves, and it may simply crash the program :/.
3) The game won't announce the winner automatically, don't be upset :).

An example ending:

@
("O",[1,53,10])
 01234567
0XXOXXXXX
1XXXOXXXX
2XXXXXXXX
3XXXXOXXX
4XOOXXOXX
5XOOXXXOO
6XXXXXXX0
7XXXXXXXX
@

= Technical Notes

-- | Game state type alias
type GameState = (Board, Side)

-- | Check number of flips for one single direction
v :: GameState -> (GameState, Int) -> Coordinate -> StepCoordinate -> State
  -> (GameState, Int)
v savedGameState (currentGameState, nFlips) cor stepCor state
  -> (newGameState, nFlips)

-- | Trial play
p :: GameState -> Coordinate -> (GameState, Int)
p inGameState -> cor -> (outGameState, nFlips)

-- | Play and move to next round
q :: GameState -> Coordinate -> GameState
q currentGameState -> cor -> nextRoundGameState

-- | Start game
z :: Side -> GameState -> IO ()
z humanSide (initialBoard,currentSide)

-- | Strategy function!
e :: GameState -> GameState

-- | Greedy strategy
e a=q a.snd.head.f((>0).snd.fst).map((,)=<< p a)$[(i,j)|i<-k,j<-k]
------------------------------------------------------------------

-}
{-
Local Variables:
fill-column: 80
End:
-}
