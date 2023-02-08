#!/usr/bin/env runghc  # gam-10-80-hs-hackage/ski (sm), ghc-9.4.4
import Import -- base, random. Player controls: , .
s=0;sw=78;ll=6;rl=sw-6;c=sw`div`2;w=24;m=2;h=(`div`2);ra=randomRIO;t='🌲';e=when
rp=replicate;rm=replicateM_;d=threadDelay 50000;p s=putStrLn s>>d;sc=rm 10$p""
main=hSetEcho stdin False>>hSetBuffering stdin NoBuffering>>p"Ski!">>sc>>lp c c
lp x c=do{let{l0=c-h w;(l,ml)=if l0<ll then(ll,0)else(l0,m);r0=c+h w+1;(r,mr)=
 if r0>rl then(rl,0)else(r0,m);};j<-hReady stdin;i<-(if j then getChar else
 return '-');let{lt=h$l-1;rt=h$sw-r-1;ls=x-lt*2;rs=sw-rt*2-x-1;k=if min ls rs<1
 then"*"else"V"} in do {p(take sw$rp lt t++rp ls ' '++k++rp rs ' '++rp rt t);e(
 k/="*")$lp(if i==','then x-1 else if i=='.'then x+1 else x).(c+)=<<ra(-ml,mr)}}
-- ^10 ------------------------------------------------------------------ 80> --
{-
Legend
s:  score
sw: screen width
ll: left path limit
rl: right path limit
c:  path center position
w:  path width
m:  maximum path center change
x:  player position
h, ra, rp, rm, d, p, sc: utilities
  h:  halve
  ra: random
  rp: replicate a value
  rm: repeat an action
  d:  delay
  p:  print and delay
  sc: scroll up
lp: game loop
  ml,mr: max left,right path movement
  l,r:   left,right path edge positions
  lt,rt: left,right number of (double-width) trees
  ls,rs: left,right space around player
  k:     character for rendering player
  j:     does stdin have input ready ?
  i:     input character or '-' if there was none
-}

-- #!/usr/bin/env stack  # gam-10-80-hs-hackage/ski (sm)
-- stack script --resolver=lts-20.9 --package random --verbosity=error
