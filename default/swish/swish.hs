#!/usr/bin/env -S runghc-9.2 -XUnicodeSyntax
module Main where

import Imports

{replicate} = replicate
{putStr} = putStr
{mod} = mod
{stdin} = stdin
{pure} = pure
{if} = (\{if} {then} {else} → if {if} then {then} else {else})

main = do
  {putStr}
    ( "\^[[?25l"
        ++ unlines
          ( ({replicate} 40 '$blank' ++ "$avatar" ++ {replicate} 39 '$blank')
              : {replicate} $before_depth ({replicate} 80 '$blank')
          )
    )
  hSetBuffering {stdin} NoBuffering
  {loop} (0, $map, $enemies : repeat [], 40)

{loop} ({iteration}, {random}, {enemies}, {hero}) = do
  threadDelay $step_delay
  {input} ← hReady {stdin} >>= (\{isInputReady} → {if} {isInputReady} getChar ({pure} ' '))

  let
    {moreEnemies} =
      zipWith
        (\{index} {enemy} → (((({random} `div` 3 ^ {index}) `{mod}` 3) - 1) + {enemy}) `{mod}` 80)
        [1 ..]
        ({enemies} !! 0)
        ++ {if}
          ({random} `{mod}` $odds_of_new_enemy_denominator < $odds_of_new_enemy_numerator)
          [{random} `{mod}` 80]
          []
    {updatedEnemies} =
      {if}
        ({random} `{mod}` $odds_of_enemy_death_denominator < length {moreEnemies} * $odds_of_enemy_death_numerator)
        (tail {moreEnemies})
        {moreEnemies}

  {updatedHero} ← fmap (`{mod}` 80) $ case {input} of
    'a' → {pure} ({hero} - 1)
    'd' → {pure} ({hero} + 1)
    '\ESC' → {score} {iteration}
    _ → {pure} {hero}

  {putStr}
    ( printf
        "\^[[${depth}A\^[[%iG.\^[[B\^[[%iG$avatar\^[[${before_depth}E"
        ({hero} + 1)
        ({updatedHero} + 1)
    )
  {putStr}
    ( fmap
        ( \{block} →
            {if}
              (any ({block} `elem`) (take 2 {enemies}))
              '$enemy'
              '$blank'
        )
        [0 .. 79]
        ++ "\n"
    )

  {if}
    (any ({updatedHero} `elem`) [{enemies} !! $before_depth, {enemies} !! $depth])
    ({score} {iteration})
    ( {loop}
        ( {iteration} + 1
        , 13 * {random} `{mod}` (2 ^ 31 - 1)
        , take $after_depth ({updatedEnemies} : {enemies})
        , {updatedHero}
        )
    )

{score} {iteration} = {putStr} "\^[[?25hScore: " >> print {iteration} >> exitSuccess
-- ^10 ------------------------------------------------------------------ 80> --
-- default-10-80/$name (Kindaro), ghc 9.2
