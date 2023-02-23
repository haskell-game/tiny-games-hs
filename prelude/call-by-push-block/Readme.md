# Call-by-push-block

Call-by-push-block is a sokoban game written in 10 lines of Haskell for the Feb
'23 [Haskell Tiny Game Jam](https://github.com/haskell-game/tiny-games-hs). It
is for the Prelude category and so does not use any imports.

In Call-by-push-block, you are code golfing. To clear a level, you must move the
lambda (`λ`) to push a block (`o`) into every hole (`_`).

Your score is the number of moves you take. Like in real golf, a lower
score is better, but make sure you can complete the level first before you
try to get the best score.

There are 14 levels of increasing difficulty. They will take around an hour
to complete, depending on experience. Your scores for each level are given
at the end: compete with your friends to see who can get the lowest scores!

## External links

I wrote a blog post about the process of creating this submission, which you can
find [on my website](https://www.cole-k.com/2023/02/21/tiny-games-hs/).

A potentially more updated version lives [on my
GitHub](https://github.com/cole-k/call-by-push-block).

## General advice

- You need to press Enter to submit your move (a quirk of this entry being in
the Prelude category).
- Try everything! You can always undo or reset if you reach an unsolvable
state.
- Read the [Controls in detail](#controls-in-detail) section if you're confused by the controls.

## The cast

- `λ`: The player character.
- `o`: A block you can push.
- `_`: The hole you need to push a block into.
- Joined by several others!
  
## Scoring

- Your score is displayed beneath the level number, starting at 1.
- It increments for every move and undo you make and resets whenever you
reset the level.
- A lower score is better.

## Controls in detail

Note that you need to press Enter in order to make a move.
- Movement: <kbd>wasd</kbd>
  - <kbd>w</kbd>: up
  - <kbd>s</kbd>: down
  - <kbd>a</kbd>: left
  - <kbd>d</kbd>: right
- Reset: <kbd>x</kbd>
  - Resets the level. Also resets your score.
- Undo: <kbd>u</kbd>
  - Undoes one move. This feature is added for convenience since moves must
    be sent using the Enter key (and thus it takes longer to get back where
    you were if you make a mistake) and incurs a small score penalty.
- Additional notes
   - When prompted with `↩`, press Enter to continue.
   - Technically, all keys map to one of the above controls. If you find that
     your game is behaving in unexpected ways, you might be pressing keys
     outside of the prescribed ones.
