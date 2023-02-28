n="晘㋲㛻嚵ѫ盝㞝ቂ㝑߳ⳛ㎋拓㾋ⱘ孭ひ・励㓛⭭マᙲ㛾⃝㱛㚙㛨宪㕵㝘㋐⛎㫛ϛ㙉ኛ㙈ኛ涀ʶ氉Ⴖぉ㚛㛛ᇛⴙ䘈㭾⛛䉀媴㛛㫯ⶭッ㑍坝㚤㛛坓䥫㛚≫〃㾵㛝㛛囚㛛ڛ㛫⛛孭嫭"
e('λ':c)|(a,b)<-span(>'n')c=u(u a#m 1 b)%e(y b);e(c:d)=c:e d;e l=l;e&0=u.v;f&_=f
v=foldr(zipWith(:))a;main=print=<<(mapM o.zip[1..].r(h.words).lines$m 5.w.c=<<x)
e%f=e<>f;p=putStr;l=length;w n="λo .+#_\n"!!mod n 8:w(n`div`8);d=getLine;z=m 1.u
r=map;1?f=z;4?f=h[];5?f=y%z%z;i?f=(h.(f&i).r e.f.head)%id;q(x:_)=c x`mod`7;q _=0
g=print;o(n,x)|x==[]=h 0|any(elem '_')$x!!0=do{n!x;p"λ:wasd 🔄:x 🔙:u\n";i<-q<$>d;
o(n,i?([v.u,v,id,v,v,v,r u]!!i)$x)}|0<3=l x<$n!x<*p"↩"<*d;k="λ.";y=drop 1;m=take
n!x@(s:_)=p"\^[cLvl "*>g n*>g(l x)*>p(unlines s);c=fromEnum;[]#""=".";l#""=y l%k
n#"."=n%k;[]#"+"="..";l#"+"='.':y l%k;('o':r)#"_"='O':r%k;l#x=x%l%"λ";h x=pure x
a=[]:a;u=reverse;x=n%"ᅕ䤉喤孭坫㛚㫛㪛囃盃㞛⛳䞛⛳䨫❭ቫ⨉੫❍婫❍ቅ❙孫❅㛛盫棛⛜䛣✛㛛⛛卝⫩㘛⛃㫫❝桝⫌㛝竛㝭㛛㪛㛰㛃ᝪ㭫哈坛ë㝓坝烰"
-- ^10 ------------------------------------------------------------------ 80> --
{- gam-10-80-hs-prelude/call-by-push-block (cole-k), ghc 9.2.5

     λ.o.o.o.o.o._.o.o.o.o.o.λ Call-by-push-block λ.o.o.o.o.o._.o.o.o.o.o.λ

     Call-by-push-block is a sokoban game where you go code golfing. To clear a
     level, you must move the lambda (`λ`) to push a block (`o`) into every hole
     (`_`).

     Your score is the number of moves you take. Like in real golf, a lower
     score is better, but make sure you can complete the level first before you
     try to get the best score.

     There are 15 levels of roughly increasing difficulty. They will take around
     an hour to complete, depending on experience. Your scores for each level
     are given at the end: compete with your friends to see who can get the
     lowest scores!

   Running:
     - This program requires no additional arguments and can be run using
       `runghc`.

   General advice:
     - You need to hit enter to submit your move (a quirk of this entry being in
       the Prelude category).
     - Try everything! You can always undo or reset if you reach an unsolvable
       state.
     - Read the "Controls in detail" section if you're confused by the controls.
     - Read the "Hints" section if you get stuck.

   The cast:
     - λ: The player character.
     - o: A block you can push.
     - _: The hole you need to push a block into.
     - Joined by several others!

   Scoring:
     - Your score is displayed beneath the level number, starting at 1.
     - It increments for every move and undo you make and resets whenever you
       reset the level.
     - A lower score is better, except for a score of 0 which indicates an
       incompleted level.

   Controls in detail:
     Note that you need to press enter in order to make a move.
     - Movement: [wasd]
       - [w]: up [s]: down [a]: left [d]: right.
     - Reset: [x]
       - Resets the level. Also resets your score.
     - Undo: [u]
       - Undoes one move. This feature is added for convenience since moves must
         be sent using the enter key (and thus it takes longer to get back where
         you were if you make a mistake) and incurs a small score penalty.
     - Additional notes
        - You need to press enter in order to make a move.
        - When prompted with ↩, press enter to continue.
        - Technically, all keys map to a control. Try to avoid pressing an
          unlabeled key as you can accidentally skip a level this way.

   Hints:
     These hints all contain spoilers and as such are enciphered using rot-13.

     I recommend revealing them in order until you find one that helps. If you
     are completely stuck on a level, there is a level skip code at the end.
     - Levels 1-5
       - Lbh pna qverpg gur cynlre punenpgre bss gur tevq. Guvf jvyy erdhver lbh
         gb erfrg va beqre gb orng gur yriry.
       - Gur unfu vf n fgngvp bofgnpyr. Yvxr n ubyr, vg pnaabg or zbirq be
         cnffrq guebhtu. Lbh nyfb pnaabg chfu oybpxf vagb vg.
       - Lbh pna chfu zhygvcyr oybpxf ng n gvzr.
       - Lbh pna chfu oybpxf bss bs gur tevq. Or pnershy abg gb chfu n oybpx lbh
         arrq bss gur tevq.
       - Lbh arrq na rzcgl gvyr nqwnprag gb n oybpx va beqre gb chfu vg. Sbe
         rknzcyr, gb chfu n oybpx qbja, vg arrqf na rzcgl gvyr nobir vg. Xrrc
         guvf va zvaq rira sbe yngre yriryf fvapr vg jvyy nyybj lbh gb vqragvsl
         ubyrf gung ner vanpprffvoyr gb pregnva oybpxf.
     - Levels 5-8
       - Gur svefg uvag vf ab ybatre gehr: gurer ner pbaqvgvbaf jurer chfuvat n
         cynlre punenpgre bss gur tevq vf arprffnel. Erzrzore: lbh bayl arrq gb
         chfu n oybpx vagb rnpu ubyr.
       - Gur beqre lbh gel guvatf va bsgra znggref. Fbzrgvzrf lbh znl unir gur
         evtug vqrn ohg jebat rkrphgvba beqre.
       - Erfrg be haqb rneyl vs lbh ernyvmr lbh ner va na hajvaanoyr fgngr. N
         dhvpx gevpx gb qrgrezvar jurgure lbh ner va bar vf gb pbhag gur ahzore
         bs erznvavat ubyrf naq purpx vs gurer vf n oybpx gung pna or chfurq
         vagb rnpu. Ersre nyfb gb gur ynfg uvag bs gur cerivbhf frpgvba.
     - Levels 9-15
       - Gur cyhf vf n gvyr gung qrfgeblf obgu cynlre punenpgref naq oybpxf
         nyvxr. Jura n oybpx vf chfurq vagb vg be n cynlre punenpgre zbirf vagb
         vg, obgu gur cyhf naq gur bowrpg rapbhagrevat vg ner ercynprq jvgu
         na rzcgl gvyr.
       - Gnxr nqinagntr bs unfurf be ubyrf gb zbir fbzr cynlre punenpgref jvyy
         xrrcvat bguref fgngvbanel.
       - Rynobengvat ba gur nobir uvag, lbh jvyy svaq gung fbzr guvatf juvpu
         frrz vzcbffvoyr ner bayl fb orpnhfr lbhe cynlre punenpgref ner abg
         pbbeqvangrq va fcnpr cebcreyl. Fbzrgvzrf lbh arrq gb pbbeqvangr gurz ol
         zbivat bar naq xrrcvat nabgure fgngvbanel. Bgure gvzrf gurl jvyy or
         frcnengrq va na hajvaanoyr fgngr.
      - Level skip cheat code
        - Glcr "Purng Pbqr" (pnfr frafvgvir) naq cerff ragre gb fxvc gur yriry.
          Guvf jvyy pbasre n fpber bs 0, vaqvpngvat gur yriry jnf fxvccrq. Vs
          lbh ner cynlvat ba gur haohssrerq irefvba, whfg glcvat gur svefg
          yetter will suffice.

   Acknowledgements :
     - Golfing: I've learned a bunch about code golfing in Haskell from various
       tips and threads I've read from inumerably many people. I got some
       explicit help from The Ninteenth Byte on Stack Exchange with shaving
       characters off. Thank you!
     - Testing and design: I solicited help from a bunch of people who
       graciously lent me their time and feedback. Thank you!
     - The jam and feedback: #haskell-game and the organizers of The Haskell Tiny
       Game Jam. Thank you!
-}
