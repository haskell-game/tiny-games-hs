{import Data.Char;import Data.List;import Control.Monad;import System.Process;
import System.Environment;import GHC.IO.Handle;y=True;infixr 1?;(True?x)_=x;(_?_
)y=y;j=intercalate;n=length;s=map show;e s="\27["++s++"m";m s c=n c==1?j""(map e
.filter(/="0")$s)<>c<>e"0"$c;r p i j=floor$sin(p*i+j*pi*2/3)*127+128;o=cycle[(p,
g,e)|p<-[1/9,1/3],g<-s[38,48],e<-s[0,1,3,4,24,5]];l(p,g,e)=[m[g<>";2;"<>j";"(s.
map(r p i)$[0..2]),e]|i<-[0..]];f 1_[]=[];f 1_(c:s)|c/='\27'=[[c]]++f 1[]s|y=f
2[c]s;f 2t(c:s)|isLetter$c=[t++[c]]++f 1[]s|y=f 2(t++[c])s;p h s=hIsClosed h>>=
flip unless(do{c<-f 1[]<$>hGetContents h;mapM putStr(zipWith($)s c);p h(drop(n c
)s);});main=do{(_:a)<-getArgs;(_,Just h,_,_)<-createProcess(proc"./play"(
dropWhile(=="lol")a)){std_out=CreatePipe};p h$l$o!!(max(n a-1))0}}
{-default-10-80/lol (hellwolf), ghc 9.4.2

= LOL - the meta tiny game

Play tiny games with lols by simply inserting as many lols as you'd like to
after the ~play~ command.

1) Print help in lols: `./play lol`
2) Play lolski: `./play lol ski`
3) Reading peyton's help with many lols: `./play lol lol lol peyton-says --help`
4) Whatever does ~CannotGetDisplaySize~ mean for some games.
5) Insert as many lols as you wish: `./play $(yes lol|head -n 42) flower-seeds`
6) The legend says that if you insert too many lols, a wormhole might be created.
9000+) Keep tiny and love Haskell.

(Courtesy to the original lolcat program: https://github.com/busyloop/lolcat/)

-}
{-
Local Variables:
fill-column: 80
End:
-}
