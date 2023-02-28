{import Import;m=asum.map try;main=do{hSetBuffering i NoBuffering;hSetEcho i(1<0
);0!(('>':r 79' '):r 9(r 80' '))};l q|q=getChar<*g;l _=pure '#';g=l=<<hReady i;n
=string;k=pure<$>e;n!s=do{putStr$"\27[2J"++unlines(init<$>s)++"Score: ";print n;
w<-getMonotonicTimeNSec;threadDelay 50000;p<-g;(n+c 'X's)!zipWith(changeLast.b(h
p$c '-'s<9))(t.map(b$v p)$t s)(chr.fromEnum.(`mod`150)<$>iterate(0xe817fb2d*)w)}
;c x=count(x==).(init=<<);h ' 'f|f=j%">-"#y;h 'a'_=z%j#y;h 'd'_=j%z#y;h _ _=y;y=
m["- "%" X "<*f,(:u)<$>(n u*>f),"-"%" X"<*f,">"%"X "<*f,f$>u,"-"%" -"<*e,k];b r=
fold.fold.parse(many r)"";e=anyChar;v 's'=j%z#p;v 'w'=z%j#p;v _=p;p=m["X"%u,"/>"
%" X","/"%" /"<*e,"/"%w<*eof,">\\"%"X ",e*>w%"\\ ",w%"/",k];j="> ";z=" >";u=" ";
p#f=try p<|>f;x%y=n x$>y;w="\\";i=stdin;t=transpose;r=replicate;f=oneOf"{[@\\/"}
-- ^10 ------------------------------------------------------------------ 80> --
{- default-10-80/shmupemup (elderephemera), ghc 9.2.5

A terminal shmup game. Tap the WASD keys to move and Space to fire. Shoot down
as many enemy space ships as you can before one hits you. Be careful not to let
your gun overheat!

On Linux and MacOS (untested, but it should work) you can run the game with
`runghc -package=ghc shmupemup` or if that doesn't work, with `stack runghc
--resolver lts-20.12 --package ghc-9.2.6 --package parsec shmupemup`. On
Windows, because of GHC issue #2189, the game must be compiled with the native
io manager which you can do with the command `ghc -with-rtsopts
--io-manager=native shmupemup.hs`. You will also have to enable VT100 support if
you don't want the screen to be repeated which you can do by running `reg add
HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1`.  There is also jitter
on Windows, Command Prompt seems to have less jitter than PowerShell or Windows
Terminal though.

The game state is just a list of lines (i.e. `[String]`) that is transformed
every frame by two Parsec parsers, one for horizontal interactions, and one for
vertical (handled by transposing the list, applying the parser, then transposing
back). The parsers look for specific patterns that get transformed according to
a set of rules. For example, the horizontal parser transforms `" @"` to `"@ "`,
causing that enemy to move forward and also `"-@"` to `" X"` causing the enemy
to by hit by the shot. These parsers also depend on the user input, e.g. if "w"
is pressed then the vertical parser will include a rule transforming `" >"` to
`"> "`, moving the player ship upwards.

Enemy spawning is handled by an non-rendered column of randomized characters on
the right of the screen. Whenever one of these characters happens to be one of
the characters that represent enemies, the interaction rules will move it to the
left so it is not deleted when the column is re-randomized. Scoring is handled
by simply counting the number of 'X's on the screen each frame and adding this
to the score.

Unminified Code:

import Data.Char (chr)
import Data.Foldable (asum, fold)
import Data.Functor (($>))
import Data.List (transpose)
import GHC.Clock (getMonotonicTimeNSec)
import GHC.Conc (threadDelay)
import GHC.Utils.Misc (changeLast, count)
import System.IO (hReady, hSetBuffering, hSetEcho, BufferMode(..), stdin)
import Text.Parsec ((<|>), anyChar, eof, many, oneOf, parse, string, try)

main = do
  hSetBuffering stdin NoBuffering
  hSetEcho stdin (1 < 0)
  loop 0 (('>' : replicate 79 ' ') : replicate 9 (replicate 80 ' '))

-- Renamed: !
loop score screen = do
  putStr $ "\27[2J" ++ unlines (init <$> screen) ++ "Score: "
  print score
  time <- getMonotonicTimeNSec
  threadDelay 50000
  input <- getInput
  loop (score + countOnScreen 'X'screen)
    $ zipWith
      (changeLast . runParser (horizontal input $ countOnScreen '-' screen < 9))
      (transpose . map (runParser $ vertical input) $ transpose screen)
    $ chr . fromEnum . (`mod` 150) <$> iterate (0xe817fb2d *) time

-- Renamed: g
getInput = go =<< hReady stdin where
-- Renamed: l
  go ready | ready = getChar <* getInput
  go _ = pure '#'

-- Renamed: c
countOnScreen char = count (char ==) . (init =<<)

-- Renamed: b
runParser parser = fold . fold . parse (many parser) ""

-- Renamed: m
options = asum . map try

p # f = try p <|> f

-- Renamed: %
x --> y = string x $> y

-- Renamed: f
enemy = oneOf "{[@\\/"

-- Renamed: h
horizontal ' ' fire | fire = "> " --> ">-" # horizontal'
horizontal 'a' _ = " >" --> "> " # horizontal'
horizontal 'd' _ = "> " --> " >" # horizontal'
horizontal _ _ = horizontal'
-- Renamed: y
horizontal' = options
  [ "- " --> " X " <* enemy
  , (:" ") <$> (string " " *> enemy)
  , "-" --> " X" <* enemy
  , ">" --> "X " <* enemy
  , enemy $> " "
  , "-" --> " -" <* anyChar
  , (:[]) <$> anyChar
  ]

-- Renamed: v
vertical 's' = "> " --> " >" # vertical'
vertical 'w' = " >" --> "> " # vertical'
vertical _ = vertical'
-- Renamed: p
vertical' = options
  [ "X" --> " "
  , "/>" --> " X"
  , "/" --> " /" <* anyChar
  , "/" --> "\\" <* eof
  , ">\\" --> "X "
  , anyChar *> "\\" --> "\\ "
  , "\\" --> "/"
  , (:[]) <$> anyChar
  ]

-}
