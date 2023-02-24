{import Import;y=1>0;j=intercalate;e s="\27["%s%"m";s=map show;n=length;(%)=(++)
;m s c=b(j""(map e.filter(/="0")$s)%c%e"0")c(n c>1);b=bool;c True p=";2;"%j";"(s
p);c _[r,g,b]=";5;"%show(16+v r*36+v g*6+v b);v x=div(x-35)40;l(p,g,e)t=[m[g%(c
t$map(\j->floor$sin(p*i/9+j*pi*2/3)*127+128)[0..2]),e]|i<-[0..]];f 1_[]=[];f 1_(
c:s)|c/='\27'=[[c]]%f 1[]s|y=f 2[c]s;f 2t[]=[t];f 2t(c:s)|isLetter$c=[t%[c]]%f 1
[]s|y=f 2(t%[c])s;p i h s=do{k<-unpack<$>hGetChunk h;let{q=hPutStr o.pack;c=f 1[
](i%k);(a,l)=splitAt(n c-1)c;o=stdout};b(q i)(q(j""(zipWith($)s a))>>hFlush o>>p
(last l)h(drop(n c)s))(k>"")};main=do{t<-(/="")<$>getEnvDefault"COLORTERM""";a<-
getArgs;(_,Just h,_,_)<-createProcess(proc"./play"(dropWhile(=="lol")a)){std_out
=CreatePipe};p[]h$l(((,,)<$>[1..]<*>s[38,48]<*>s[0,4,5])!!max(n a-2)0)t};}
-- ^10 ------------------------------------------------------------------ 80> --
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

= Known Bugs

1) On NixOS, running first time may encounter the following issue:

@
$ ./play lol ski
Selected resolver: lts-20.11
Using resolver: lts-20.11 specified on command line
Selected resolver: lts-20.11
Using resolver: lts-20.11 specified on command line
/usr/bin/env: ‘stack’: No such file or directory
@

The fix is to run the program again.

2) For some reason, running first time cannot detect COLORTERM correctly neither,
resulting 256 colors only. The fix is to run the program again.

= Notes

- https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
- https://stackoverflow.com/questions/12807669/how-to-convert-an-rgb-color-to-the-closest-matching-8-bit-color
- https://github.com/tmux/tmux/blob/dae2868d1227b95fd076fb4a5efa6256c7245943/colour.c#L57
- https://jdebp.uk/Softwares/nosh/guide/TerminalCapabilities.html

-}
{-
Local Variables:
fill-column: 80
End:
-}
