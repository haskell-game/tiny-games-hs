main=do{let{m=map;f=filter;k=[0..7];r=[-1..1];t=y.splitAt 8;l(x,y)=8*y+x;o 1=2;o
_=1;g w i b=take i b++w:drop(i+1)b;j x=x>=0&&x<=7;c=(length.).f.(==);s=m show k;
u=(putStrLn.).foldl(++);v k(a@(b,w),c)p@(x,y)q@(m,n)s=let{i=j x&&j y;t=l p;e=b!!
t;f=v k((g w t b,w),c+1)(x+m,y+n)q;h|s==0=if e==0 then f 1 else k|s==1=if i&&e==
o w then f 2 else k|s==2=if not i||e==0 then k else if e==w then(a,c+1)else f 2}
in h;q a d=let((b,w),c)=p a d in if c==0 then a else(g w(l d)b,o w);p a c=foldr(
\d k->v k k c d 0)(a,0)[(i,j)|i<-r,j<-r];y([],_)_=pure();y(a,b)k=u(k!!0)(m show
a)>>t b(drop 1 k);z h a@(b,w)=print(w,m(`c`b)[0..2])>>u" "s>>t b s>>if w==h then
getLine>>=z h.q a.read else z h(e a);e a=q a.snd.head.f((>0).snd.fst).m((,)=<<p
a)$[(i,j)|i<-k,j<-k]};z 1(g 1 35.g 1 28.g 2 27.g 2 36$replicate 64 0,1)}
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

== Initial Screen

@
(1,[60,2,2])
 01234567
000000000
100000000
200000000
300021000
400012000
500000000
600000000
700000000
@

1) The first line @(1,[60,2,2])@ is "game status line":
  * Whose turn? The game always starts from the black side, where 1 means black
    side, 2 means white side.
  * How many empty spots left? It starts with 60.
  * How many black pieces on the board? 2.
  * How many white pieces on the board? 2.
2) The second line is for values of the x-axis.
3) The rest is the printout of the board:
  * The first column is for values of the "y-axis".
  * The rest are the cells with pieces: 1 means black side, 2 means white side,
    and 0 means empty cells.

== Make A Move

You are expected to type a input conforming to @read::(Integer,Integer)@ as the
coordinate where you wish to put your piece to.

For instance, you make a move at @(3,2)@ which then should progress the game to
next turn:

@
(3,2)
(2,[59,4,1])
 01234567
000000000
100000000
200010000
300011000
400012000
500000000
600000000
700000000
@

AI should make a move next, and then it should be back to you:

@
(1,[58,3,3])
 01234567
000000000
100000000
200210000
300021000
400012000
500000000
600000000
700000000
@

== Game Ending

You should keep making moves until you cannot.

1) The game status line should indicate who has the most pieces on the board.
2) AI may run out of moves, and it may simply crash the program :/.
3) The game won't announce the winner automatically, don't be upset :).

An example ending:

@
(7,7)
(2,[1,53,10])
 01234567
011211111
111121111
211111111
311112111
412211211
512211122
611111110
711111111
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
