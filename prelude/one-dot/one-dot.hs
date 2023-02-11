#!/usr/bin/env runghc
i=5;e=i+2;main=interact$u 0 s;d l=fst<$>filter(uncurry(/=))(zip l(tail l));j=i^2
f 'o'='-';f '-'='o';a p g=let(x,y:z)=splitAt p g in x++f y:z;c=d$p<$>iterate r 1
p r=let(x,y)=quotRem(quot(r*i^2)m)i in l(x+1)$y+1;m=65521;r=(`rem`m).(2469*);k=
 ' ':take i['a'..]++"\n";n p=let(y,x)=quotRem p e;r z=[z-1..z+1]in l<$>r x<*>r y
b z d f=if z>0&&z<=i then f z else d;s=(foldr1(.)$h<$>take j c)t;l x y=x+y*e;
t=let z=quot e 2 in a(l z z)$replicate(e^2)'-';h=foldr1(.).map a.n;o _""=k++"> "
o z g=let(r,t)=splitAt e g in r++b z""((' ':).show)++'\n':o(z+1)t;u _""_="X\n"
u c g~(x:y:_:z)="\ESCc"++k++o 0 g++if filter(=='o')g=="o"then show(j-c)++"!\n"
 else b(fromEnum x-96)"X\n"$flip(u$c+1)z.b(fromEnum y-48)"".(\v w->(`h`g)$v w).l
{-
Author: Ose Pedro, https://github.com/OsePedro
Category: prelude-10-80

================================================================================
                                HOW TO PLAY
================================================================================
The goal of the game is to flip 3*3 blocks of dots 'o' and dashes '-' until the
board contains exactly one dot. You pick a block by typing its central
coordinates in the format <column letter><row number><enter>. E.g. given the
following 5*5 board:

-----
-ooo- 1
-o-o- 2
-ooo- 3
-----
 abc

you could win the game in one move by flipping the middle block. To do this,
you'd type "b2" and <enter>, giving:

-----
----- 1
--o-- 2
----- 3
-----
 abc

Be careful when you type; the game will print "X" and terminate if you type
invalid input (sorry!). Backspace works though, so you can at least change what
you've typed before you press <enter>.

When the game ends, your score is printed. Your score is j-m, where m is the
number of moves you made, and j is the number of moves that were used to
construct the starting board. So positive scores are good and negative scores
show room for improvement. I've achieved a score of 14 on the 7*7 version that
I'm committing. See if you can beat me!

You can change the board size by changing the i variable (at the start of line
2) to any value in [2..9]. This controls the size of the board's interior. Note
that j=i^2, so for a 7*7 board, i=5 and the game can be won in at most 5^2=25
moves.

It is always possible to win with a dot in the middle of the board, but there
may be other solutions (I haven't checked though, so I'm not sure). If you try
an even board size (see below), you can see where the "middle" dot is by loading
this file in GHCi and running "putStrLn $ o 0 t".


================================================================================
                                DOCUMENTATION
================================================================================

This is an alphabetical listing of all of the functions and constants that I
wrote:

a :: Int -> String -> String
  *Applies* f to the Char at the given index (i.e. it flips that symbol).

b :: Int -> a -> (Int -> a) -> a
  A *Branch* function. (b z d f) returns (f z) if z is in [1..i], otherwise it
  returns d.

c :: [Int]
  Pseudorandom linearised *Coordinates* in the board's interior.

d :: [Int] -> [Int]
  *Deduplicates* sequences of repeated values in the list. Drops the last
  repeated sequence.

e :: Int
  The width/height of the board's *Exterior*, i.e. i+2.

f :: Char -> Char
  *Flips* 'o' to '-' and vice-versa.

h :: Int -> String -> String
  Flips the *neighbourHood* of the given linearised point.

i :: Int
  The width/height of the board's *Interior*. Must be in [2..9].

j :: Int
  The number of times the target board is *Jumbled* by randomly flipping
  neighbourhoods, in order to produce the start board.

k :: String
  The *Keys* that you should type to pick a column.

l :: Int -> Int -> Int
  (l x y) *Linearises* 2D coordinate (x,y). I.e. it turns it into an index in
  [0..e^2-1]. x and y must be in [0..e-1].

m :: Int
  LCG (linear congruential generator) *Modulus*.

n :: Int -> [Int]
  Maps a linearised point to its 3*3 *Neighbourhood*.

o :: Int -> String -> String
  Formats the given board for *Output*. The Int is the index of the String's
  initial row.

p :: Int -> Int
  Maps a value in [0..m-1] (i.e. an LCG output) to a linearised *Point* in the
  board's interior.

r :: Int -> Int
  Returns the next number in an LCG *pseudoRandom* sequence.

s :: String
  The *Start* board.

t :: String
  The *Target* board. This is not necessarily the only solution, but it is a
  known solution.

u :: Int -> String -> String -> String
  The *User* input processing loop. (u moveCount gameBoard input) reads the
  first two characters and '\n' character from input, interprets the first two
  characters as coordinates, flips the neighbourhood of the coordinates and
  loops until there's one dot left, or until you type invalid input.
-}
