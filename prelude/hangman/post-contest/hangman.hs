o n l=(>>=(\x->(mapM id.take n.repeat$l)!!((ḟ x)-272)));d=o 3$ϕ++" /?.:YWEPCB";
z=zipWith;main=h 0;p=putStrLn;r=p.d;t=pure;f x a '.'|a==x=a|j='.';f _ _ b=b;
(#)=elem;ḟ=fromEnum;ţ=toEnum;m=d"ēᆊǉƦĖĐொ⟌Ś㚕ĒĐĶ௨Đ";j=1>0;u k a b|b<ţ(k+98)=a\
|j=' ';h n|n<ą=do{g 0('.'<$e n)(e n);q<-b"롹蔪℮䪻蕜"['y','n'];case q of 'y'->\
h$n+1;_->t()}|j=r"델泩蹐Ґ䞐酎ൎ棋磍㫕";b p q=do{r p;u<-getLine;case u of(l:[])|l#\
['A'..'Z']->t.ţ.(+32).ḟ$l|l#ϕ->t$l;_->b p q};g n a v=do{p$"\ESC[2J"++(z(u n)(o 5
"_ \n|\\o+-/""ᶊ㠨烏᷸쟎嘺ẐᶍŬ")m)++a;p$d"꺳䞍␎揰旂"++(show n)++"/11.\n";if|n==11->r\
"꣱趿戃"|'.'#a->do{q<-b"덽ᤃӝ᥆ᤆ"ϕ;g(n+1-(fromEnum$q#v))(z(f q)v a)v}|j->r"꣱轐䫠"};e n=\
[y|y<-w,notElem y$e<$>[0..n-1]]!!(read[y|y<-__TIME__,y<':']`mod`ą-n);ą=length w
w=words.d$"扩Ბᨿӆ蕀ᚇ✤貺˱杙䉦帀ᨸ䳿䍍䳤貉䜕泂跤䚘賧䛲乽͊㴍ϗ爋ٶᩈː躴䝃Ⅎᩁː躝滋䝃⌹ƙ剾ᤃ㌹㜶贌ⱋ跤䢣ᓲŮ淚懲ⳇ仡";ϕ=['a'..'z']
-- ^10 ------------------------------------------------------------------ 80> --
{- prelude-10-80/hangman (kukimik)

Running: runghc -XCPP -XMultiWayIf hangman.hs

It' just a simple hangman word guessing game. Could be golfed some more to
include extra words. I'm just super short on time when writing this. :-)

Controls:
You should enter a single letter, press Enter/Return, see what happens,
and repeat. Care is taken of handling the user input: character case is ignored;
non-letter guesses are ignored; multicharacter guesses are ignored.

Interesting tricks:
 - using the __TIME__ macro to achieve a poor man's randomness effect
 - unicode packing of strings
-}