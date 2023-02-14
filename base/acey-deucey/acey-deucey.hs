#!/usr/bin/env runghc
import Control.Monad;import System.Exit;import GHC.Clock (getMonotonicTimeNSec);
g j k l b | j <= l && l <= k || j >= l && l >= k = ps "Win!" >> return (b * 2)
 |True=ps"Lose.">>return (-1 * b);d 0 n=[n];d e n=let (x, y)=divMod n (10 ^ e)
 in x:d (e - 2) y;ps=putStrLn;v b m=b<=m&&b>=20;c=['2'..'9']++"TJQKA";
game m =do{when (m == 0) (die "No more money!" );t <- getMonotonicTimeNSec;
let{r=fromIntegral.flip mod 13<$>d 4 t;j=head r;k=r!!1;l=r!!2};ps$"---\nHand:\n"
++show(c!!j)++" [?] "++show(c!!k);ps$"\nPlace a bet (min 20) [Bankroll: "++show
m++"]: ";b <- readLn;unless (v b m)(ps "Bad bet.">>game m);ps$"Dealer turned a "
++show(c !! l);x<-g j k l b;game $ m + x};main=game 1000
-- ^ 10 -------------------------------------------------------------------- 80>
{- base-10-80/acey_deucey (trevarj), ghc 9.2.4
https://hackage.haskell.org/package/base-4.17.0.0/docs/Text-Printf.html

This is a gambling game inspired by "acey deucey", also known as red dog or yablon
https://en.wikipedia.org/wiki/Yablon.

Run the game, look at the hand and enter a bet (minimum 20) based on whether the hidden
card will be between the two exposed cards.

When a good hand comes out (cards are far apart), take advantage of the odds and make a large bet.
When a bad hand comes out (cards are close together), make a small bet and move on.

Card ordering - 2 3 4 5 6 7 8 9 T J Q K A

Good hand example (lots of cards in between):
  2 [?] A 

Bad hand example:
  2 [?] 4


Expanded code: 
----------------
#!/usr/bin/env runghc
import Control.Monad
import GHC.Clock (getMonotonicTimeNSec)
import System.Exit

g j k l b
  | j <= l && l <= k || j >= l && l >= k = ps "Win!" >> return (b * 2)
  | True = ps "Lose." >> return (-1 * b)

d 0 n = [n]
d e n =
  let (x, y) = divMod n (10 ^ e)
   in x : d (e - 2) y

ps = putStrLn

v b m = b <= m && b >= 20

c = ['2' .. '9'] ++ "TJQKA"

game m = do
  when (m == 0) (die "No more money!")
  t <- getMonotonicTimeNSec
  let r = fromIntegral . flip mod 13 <$> d 4 t; j = head r; k = r !! 1; l = r !! 2
  ps $
    "---\nHand:\n"
      ++ show (c !! j)
      ++ " [?] "
      ++ show (c !! k)
  ps $
    "\nPlace a bet (min 20) [Bankroll: "
      ++ show
        m
      ++ "]: "
  b <- readLn
  unless (v b m) (ps "Bad bet." >> game m)
  ps $
    "Dealer turned a "
      ++ show (c !! l)
  x <- g j k l b
  game $ m + x

main = game 1000
-}
