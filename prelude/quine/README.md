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
-- SPDX-License-Identifier: CC-BY-4.0

rot13 :: Int -> Int
rot13 x | x - 97 < 26 && x - 97 >= 0 = 97 + rem (x - 84) 26
        | otherwise = x

newLine, quote, backSlash :: Char
newLine = toEnum 10
quote = toEnum 34
backSlash = toEnum 92

fmt :: String -> String
-- Insert last quote and comment
fmt [] = quote : newLine : "-- prelude-10-80/quine (tristanC)"
-- Insert initial quote
fmt ('#': '!': y) = quote : '#' : '!': fmt y
fmt (c:rest)
  | -- Escape new line
    c == newLine = backSlash : 'n' : backSlash : newLine : backSlash : fmt rest
  | -- Escape quote
    c == quote = backSlash : quote : fmt rest
  | otherwise = c : fmt rest

main :: IO ()
main = putStrLn ((toEnum . rot13 . fromEnum <$> s) ++ fmt s)
  where
    s = "<insert-rot13-source-here>"
```
