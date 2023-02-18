# Play

The game is very simple, is a guessing-word game. 
You must type characters until you find out what word is it

# How it works

Picks a random word
Using recursion checks the given character
In case it is not completed yet keeps asking another character

## Non-minified version

```haskell
#!/usr/bin/env runhaskell
import System.Random (randomRIO)
game_words = ["cute","game","play","dream"]

ask wrd l = do
  putStrLn $ map (\i -> if i `elem` l then i else '_') wrd
  if length wrd == length l then putStrLn "You won!"
  else do
    input <- getLine
    let char = input !! 0
    if char `elem` wrd then do
      putStrLn "You got it"
      ask wrd (char : l)
    else do
      putStrLn "try again"
      ask wrd l

main = do
  putStrLn "Guess the word!"
  randomN <- randomRIO (0,length game_words - 1::Int)
  currW <- return $ game_words !! randomN
  ask currW []
```

# Experience

`first time using haskell lol`

Well, before this game jam I knew nothing about Haskell, 
but I gave it a try and I found that I liked it, so I'll keep learning. 
It felt tough at first, since I came from interpreted languages like JavaScript, Python, and Lua.
It was difficult to figure out what I was doing wrong, and I had to read a lot before getting a runnable program,
but I think I understand the point of a compiled language and a strong type system that those other languages don't have.
I'm looking forward to building more things in Haskell, like backend for web. 🙂
