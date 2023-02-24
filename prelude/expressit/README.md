# Build instructions
just run it! You may need to run `chmod +x` first to enable execution.

# Goal
Try to make it to the highest round. 
At each round, you are given a 'target' value, and an 'n' value.
You must form a valid expression that creates the target using the given n.



# Using the calculator
The calculator is stack-based. `n` adds the current n to the stack. 
Other commands take operands from the stack and put back the result.
For example, evaluating `nn+n/` for `n = 3` causes thhe stack to evolve like so: 
`[] -> [3] -> `[3,3] -> [6] -> [3, 6] -> [2]`. Note the order that `/` works in.
The stack should always have enough elements for the current operation and only one element in the end.
Furthermore, you're limited to 12 commands per round.

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
stack empty
score: 0
```
Digits are not a recognized command. Therefore, they are ignored.
Since nothing was ever put on the stack, it's empty.

```
target = 1
n = 1
+
stack empty
score: 0
```
There should always be enough numbers on the stack for an operation.

```
target = 3
n = 3
nn
stack overfull
score: 2
```
At the end, the stack is [3,3]. There should not be more than one number left on the stack. 

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
