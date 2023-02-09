#!/usr/bin/env -S runghc-9.2 -XUnicodeSyntax
module Main where

import System.Exit
import System.IO

{replicate} = replicate
{putStr} = putStr
{mod} = mod
{stdin} = stdin
{pure} = pure

main = do
  {putStr}
    ( unlines
        ( ({replicate} 40 '$blank' ++ "$avatar" ++ {replicate} 39 '$blank')
            : {replicate} $before_depth ({replicate} 80 '$blank')
        )
    )
  hSetEcho {stdin} False
  hSetBuffering {stdin} NoBuffering
  {loop} (0, $map, $enemies : repeat [], 40)

{loop} ({iteration}, {random}, {enemies}, {hero}) = do
  let
    {moreEnemies} =
      zipWith
        (\{index} {enemy} → (((({random} `div` 3 ^ {index}) `{mod}` 3) - 1) + {enemy}) `{mod}` 80)
        [1 ..]
        ({enemies} !! 0)
        ++ if {random} `{mod}` $odds_of_new_enemy_denominator < $odds_of_new_enemy_numerator
          then [{random} `{mod}` 80]
          else []
    {updatedEnemies} =
      if {random} `{mod}` $odds_of_enemy_death_denominator < length {moreEnemies} * $odds_of_enemy_death_numerator
        then tail {moreEnemies}
        else {moreEnemies}

  input ← getChar

  {updatedHero} ← fmap (`{mod}` 80) $ case input of
    'a' → {pure} ({hero} - 1)
    'd' → {pure} ({hero} + 1)
    '\ESC' → {score} {iteration}
    _ → {pure} {hero}

  {putStr}
    ( "\^[[${depth}A\^[["
        ++ show ({hero} + 1)
        ++ "G.\^[[B\^[["
        ++ show ({updatedHero} + 1)
        ++ "G$avatar\^[[${before_depth}E"
    )
  {putStr}
    ( fmap
        ( \{block} →
            if {block} `elem` {enemies} !! 0 || {block} `elem` {enemies} !! 1
              then '$enemy'
              else '$blank'
        )
        [0 .. 79]
        ++ "\n"
    )

  if {updatedHero} `elem` {enemies} !! $before_depth || {updatedHero} `elem` {enemies} !! $depth
    then {score} {iteration}
    else
      {loop}
        ( {iteration} + 1
        , 13 * {random} `{mod}` (2 ^ 31 - 1)
        , take $after_depth ({updatedEnemies} : {enemies})
        , {updatedHero}
        )

{score} {iteration} = {putStr} "Score: " >> print {iteration} >> exitSuccess
-- ^10 ------------------------------------------------------------------ 80> --
-- base-10-80/$name (Kindaro), ghc 9.2
