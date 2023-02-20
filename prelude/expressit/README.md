# Build instructions
just run it! You may need to run `chmod +x` first to enable execution.

# Goal
Make an expression for the given target using your RPN calculator. 
Try to continue for as long as you can.

each round, you'll be given a prompt of the form
```
target = x
n = y
```
this means that your expression should give the value `x`, and that the variable n has value `y`.

# Using the calculator
the calculator evaluates a string of up to 12 commands.
commands:
* `n` -> push n to the stack
* `+` : add
* `-` : subtract
* `*` : multiply
* `/` : divide
* `%` : modulus
* `f` : sum of factors. f 6 = 1 + 2 + 3 + 6 = 12. f 7 = 1 + 7 = 8
* `c` : collatz function. c (n even) = n/2; c (n odd) = 3*n + 1
* `i` : iterated collatz function. "xyi" is the collatz funciton applied to x y times.
* `t` : totient function
* other: do nothing. NOTE: 0,1..9 fall under "other"

a few tips:
f and t behave predictably for prime numbers.
Plan ahead! The way you solve each target determines the next value of n you get.
Try to figure out a few idioms. For example, see if you can figure out
    an expression that returns 2 no matter what n is.
You probably don't need the i function

a few examples:

```
target = 1
n = 1
n
= 1
```
Here, we just push n to the stack. Since n = 1, this is all we need. Easy!

```
target = 1
n = 1
1
= -1
score: 0
```
Digits are not a recognized command. Therefore, they are ignored.
Since nothing was put on the stack, you get an error code (-1)

```
target = 1
n = 1
+
= -1
score: 0
```
Using a command with insufficient arguments on the stack causes an error. 

```
target = 1
n = 1
nn
= -1
score: 0
```
Having too much on the stack at the end is also an error.

```
target = 3
n = 4
nnn/-
= 3
```
after nnn, the stack is [4,4,4]. After /, it is [1, 4]. After -, it is [3].
note the order for subtraction, which is also used for / and %.

```
target = 13
n = 3
nn*f
= 13
```
here, n = 3, so (nn*) = 9. 9f = sum of factors of 9 = 9 + 3 + 1 = 13

```
target = 16
n = 10
ncc
= 16
```
we first push 10. c 10 = 10 / 2 = 5. c 5 = 5 * 3 + 1 = 16.

```
target = 17
n = 5
ntfnn++
= 17
```
5t = 4, as (1,2,3,4) are all relatively prime with 5. 4f = 4 + 2 + 1 = 7. 7 + 5 + 5 = 17

```
target = 40
n = 7
nnfi
= 40
```
n = 7, nf = 8. 8 iterations of the collatz function turns 7 into 40.
