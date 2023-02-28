# quine

A demo which produces its own source.

![Playing the game](quine.png)


## Playing

Replicate the code by running [./quine.hs](quine.hs).


## Documentation

Learn more about [Quine (computing)](https://en.wikipedia.org/wiki/Quine_(computing)).

Here is the less-minified version:

```haskell
#!/usr/bin/env runghc
-- | quine expanded
-- Copyright 2023, Tristan de Cacqueray
-- SPDX-License-Identifier: CC0-1.0

newLine, quote, backSlash :: Char
newLine = toEnum 10
quote = toEnum 34
backSlash = toEnum 92

sep, comment, license :: String
sep = "-- ^ 10 " ++ ['-' | _ <- [0..66]] ++ " 80> --"
comment = "{- prelude-10-80/quine (tristanC)"
license = "SPDX: CC0-1.0" ++ newLine : "-}"

fmt :: String -> String
-- Insert last quote and comment
fmt [] = quote : newLine : sep ++ newLine : comment ++ newLine : license
-- Insert initial quote
fmt ('#': '!': y) = quote : '#' : '!': fmt y
fmt (c:rest)
  | -- Escape new line
    c == newLine = backSlash : 'n' : backSlash : newLine : backSlash : fmt rest
  | -- Escape quote
    c == quote = backSlash : quote : fmt rest
  | otherwise = c : fmt rest

main :: IO ()
main = putStrLn (src ++ fmt src)
  where
    src = "<insert output of (fmt <$> readFile quine.hs)>"
```
