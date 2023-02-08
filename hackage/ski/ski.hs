#!/usr/bin/env stack
-- stack script --compile --resolver=lts-20.10 --package random
import Import;s=78;ll=6;rl=s-6;c=s`div`2;w=24;m=2;t='🌲';h=(`div`2);q=p.show
ra=randomRIO;rp=replicate;rm=replicateM_;d=threadDelay 50000;p s=putStrLn s>>d
sc=rm 10$p"";main=hSetEcho stdin False>>hSetBuffering stdin NoBuffering>>p"Ski!"
 >>lp 0 c c;lp o x c=do{let{l0=c-h w;(l,ml)=if l0<ll then(ll,0)else(l0,m);r0=c+h
w+1;(r,mr)=if r0>rl then(rl,0)else(r0,m);};j<-hReady stdin;i<-(if j then getChar
else return '-');let{lt=h$l-1;rt=h$s-r-1;ls=x-lt*2;rs=s-rt*2-x-1;k=if min ls rs
<1 then"*"else"V"} in do {p(take s$rp lt t++rp ls ' '++k++rp rs ' '++rp rt t);if
k/="*"then lp(o+1)(case i of ','->x-1;'.'->x+1;_->x).(c+)=<<ra(-ml,mr)else q o}}
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-hackage/ski (sm). Avoid trees. Player controls: , . 

NB: for me the 🌲 emoji renders very slowly in some terminals (iTerm, Terminal),
but normally in VS Code terminal.

Legend
s:  screen width
ll: left path limit
rl: right path limit
c:  path center position
w:  path width
m:  maximum path center change
t:  character for rendering trees
h, q, ra, rp, rm, d, p, sc: utilities
  h:  halve
  q:  convert to string and print
  ra: random
  rp: repeat a value
  rm: repeat an action
  d:  delay
  p:  print and delay
  sc: scroll up
lp: game loop
  o:     score
  ml,mr: max left,right path movement
  l,r:   left,right path edge positions
  lt,rt: left,right number of (double-width) trees
  x:     player position
  ls,rs: left,right space around player
  k:     character for rendering player
  j:     does stdin have input ready ?
  i:     input character or '-' if there was none
-}
