#!/usr/bin/env runghc
p=putStrLn;s=show;r=repeat 0;l=toInteger.length;main=h 1 1;b=zipWith;h t n=do
{p$"target = "++s t;p$"n = "++s n;i<-getLine;let{
a=v n (take 12 i) r};putStr$if l i>12 then"cmds after 12th ignored\n"else"";
p$"= "++s a;if a==t then p "">>h (t+1) (l i)else p$"score: "++s (t-1)}
v n[]s=head s;v n(c:k)s@(x:y:z)=v n k (case c of{'n'->n:s;'+'->y+x:z;'-'->y-
 x:z;'*'->y*x:z;'/'->y`div`x:z;'%'->y`mod`x:z;'f'->sum(f((==0).mod x)
[1..x])*signum x:y:z;'c'->g x:y:z;'i'->iterate g y!!fromInteger (abs x):z;
't'->l(f((==1).u x)[1..x]):y:z;_->s});u 0 n=n;u m n=u(n`mod`m)m;f=filter;
g x=if even x then x`div`2 else 3*x+1
-- ^10 ------------------------------------------------------------------ 80> --
-- prelude-10-80/expressit (Greg B.)
-- Try to make an expression for the given target using your RPN calculator.
-- the calculator evaluates a string of up to 12 commands.
-- commands:
-- n -> push n to the stack
-- + : add
-- - : subtract
-- * : multiply
-- / : divide
-- % : modulus
-- f : sum of factors. f 6 = 1 + 2 + 3 + 6 = 12. f 7 = 1 + 7 = 8
-- c : collatz function. c (n even) = n/2; c (n odd) = 3*n + 1
-- i : iterated collatz function. "xyi" is the collatz funciton applied to x y times.
-- t : totient function
-- other: do nothing. NOTE: 0,1..9 fall under "other"
--
-- a few tips:
-- f and t behave predictably for prime numbers.
-- Plan ahead! The way you solve each target determines the next n you get.
-- Try to figure out a few idioms. For example, see if you can figure out
--    an expression that returns 2 no matter what n is.
-- You probably don't need the i function
--
-- a few examples:
-- target = 1
-- n = 1
-- 1
-- = 0
-- score: 0
-- Unfortunately, the calculator doesn't support digits.
--
-- target = 3
-- n = 4
-- nnn/-
-- = 3
-- after nnn, the stack is [4,4,4]. After /, it is [1, 4]. After -, it is [3].
-- note the order for subtraction, which is also used for / and %.
--
-- target = 13
-- n = 3
-- nn*f
-- = 13
-- here, n = 3, so (nn*) = 9. 9f = sum of factors of 9 = 9 + 3 + 1 = 13
--
-- target = 16
-- n = 10
-- ncc
-- = 16
-- we first push 10. c 10 = 10 / 2 = 5. c 5 = 5 * 3 + 1 = 16.
--
-- target = 17
-- n = 5
-- ntfnn++
-- = 17
-- 5t = 4, as (1,2,3,4) are all relatively prime with 5. 4f = 4 + 2 + 1 = 7. 7 + 5 + 5 = 17
--
-- target = 40
-- n = 7
-- nnfi
-- = 40
-- n = 7, nf = 8. 8 iterations of the collatz function turns 7 into 40.
