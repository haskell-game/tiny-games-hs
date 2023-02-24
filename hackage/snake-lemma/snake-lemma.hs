#!/usr/bin/env -S stack script --resolver=lts-20.10 --package ansi-terminal-game
import Import;main=(b=<<)$playGameS$Game 10((12,)<$>[10..16],(0,-1),(16,21),99,0
 )l g e;e((p@(y,x):s),_,_,_,_)=or[y<2,y>23,x<1,x>39,p`elem`s];l _(s@((y,x):_),
 d@(j,i),f,r,z) e|h==f=c((v,u):s,d',(v,u),r,z+1)|o=c((v,u):init s,d',f,r,z)where
 {h@(v,u)=(y+j,x+i);d'|KeyPress k<-e=m d k|o=d};m(0,_)'i'=(-1,0);m(_,0)'j'=(0,-1)
m(0,_)'k'=(1,0);m(_,0)'l'=(0,1);m d _=d;g _(s,_,f,_,z)=mergePlanes(box 80 24 '█')
 $((2,2),blankPlane 78 22):((2*)<$>f,word$u z):[((2*)<$>s,word w)|(w,s)<-zip("⌀⌀"
 :repeat "▒▒")s];b(_,_,_,_,z)=printf"You proved %d theorems!\n"z;o=True;c q@(s,d,
 f,r,z)|f`elem`s=c(s,d,(2+y`rem`20,2+x),r',z)|o=q where{r'=r`div`2`xor`bool 0
 0xe08(odd r);(y,x)=r`divMod`38};u z=take 2.drop (3*z).cycle$"∀∃⊥⊢⊤⊨∨∧⇒λ→ΣΠη"
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/snake-lemma (gergoerdi)

Solve as much theorems as you can with the Snake Lemma! Change
direction with `ijkl`.

-}
