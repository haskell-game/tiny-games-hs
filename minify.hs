#!/usr/bin/env -S runghc -XUnicodeSyntax -XBlockArguments

import Data.Char
import Data.List
import System.Environment
import System.Exit
import System.FilePath

overlay function list =
  let pairs = fmap function (zip list (tail list))
   in (fst . head) pairs : fmap snd pairs

specialTokens =
  [ "("
  , ","
  , ")"
  , "{"
  , ";"
  , "}"
  , "["
  , "]"
  , "←"
  , "→"
  , "<-"
  , "->"
  , "∷"
  , "::"
  , "@"
  , "\\"
  ]

isAllowedInName = or . flip fmap [isAlphaNum, (== '_'), (== '\'')] . flip ($)

addWhiteRoom = overlay \(this, next) →
  if this `elem` specialTokens
    then (this, next)
    else
      if (isAllowedInName . last) this && (isAllowedInName . head) next
        then (this, " " <> next)
        else (this, next)

cut fit list = (last . filter (fit . fst)) (zipWith splitAt [0 ..] (replicate (length list + 1) list))

main = do
  target ← fmap (!! 0) getArgs
  if takeExtension target /= ".hs"
    then exitFailure
    else tailor target

tailor target = do
  cloth ← readFile target
  let
    (snowflakes, leftovers) = cut (all \line → (head line == '#')) (lines cloth)
    tokens = words (unlines leftovers)
    tokensWithWhiteRoom = addWhiteRoom tokens
    cuts = flip
      unfoldr
      tokensWithWhiteRoom
      \tokens →
        if null tokens
          then Nothing
          else let (chunk, leftovers) = cut (\chunk → sum (fmap length chunk) <= 80) tokens in Just (concat chunk, leftovers)
    shirt = unlines snowflakes <> unlines cuts
  if shirt == cloth
    then exitSuccess
    else writeFile (replaceExtension target ".minified.hs") shirt
