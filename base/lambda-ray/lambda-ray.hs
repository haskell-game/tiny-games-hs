import Control.Concurrent; import System.Posix.Internals;w=100;q=0.4;n=min;c=cos
p=[(x/w*2-1,(y/20*2-1)*0.2)| y<-[0..20], x<-[0..w+1]];t=max 0;o=True;a=abs;s=sin
main=go 0;r t (x,y,z)=(x*c t - y*s t, x*s t + y*c t, z);v=sqrt;u _(1.02,_)= '\n'
u t(x,y)=m t 0(10*x,10*y,-5);b h w(x,y,z)=v(t(a x-w)**2+t(a y-h)**2+t(a z-q)**2)
go n=puts("\ESCc"++(map (u(n/6))p))>>threadDelay 100000>>go(n+1);h p@(x,y,z)=let
 a=b 5q;l=(x+3,y,z);i|y>=0=a(r(-1)l)|o=9;j|y<0=a(r 1l)|o=9;k=a(r 1p)
 c|y>0=a(r(-1)p)|o=9;m=b 5 2(r 1(x-6,y,z));g s=b 6 0.2 (r(pi/2)(x-1,y+s*q,z))
 e=max m(n(g 1)(g(-1))) in n(n i j)(n e(n k c));m _ 20 _=' ';m t n(x,y,z)=let
 a=x*c(t)-z*s t;b=x*s t+z*c t;nz=h(a,y,b+q)-h(a,y,b-q);ny=h(a,y+q,b)-h(a,y-q,b)
 d=h(a,y,b);g|nz<0='o'|ny<0='>'|o='.';r|d<0.01=g|o=m t(n+1)(x,y,z+d);q=0.001in r
-- ^10 ------------------------------------------------------------------ 80> --
{- base-10-80/lambda-ray (tristanC)

Copyright 2023, Tristan de Cacqueray
SPDX-License-Identifier: CC-BY-4.0
-}
