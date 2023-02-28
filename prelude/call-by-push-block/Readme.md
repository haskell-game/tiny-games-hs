# Call-by-push-block

Call-by-push-block is a sokoban game written in 10 lines of Haskell for the Feb
'23 [Haskell Tiny Game Jam](https://github.com/haskell-game/tiny-games-hs). It
is for the Prelude category and so does not use any imports.

In Call-by-push-block, you are code golfing. To clear a level, you must move the
lambda (`λ`) to push a block (`o`) into every hole (`_`).

Your score is the number of moves you take. Like in real golf, a lower
score is better, but make sure you can complete the level first before you
try to get the best score.

There are 15 levels of roughly increasing difficulty. They will take around an
hour to complete, depending on experience. Your scores for each level are given
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
- Read the "Hints" section if you get stuck.

## The cast

- `λ`: The player character.
- `o`: A block you can push.
- `_`: The hole you need to push a block into.
- Joined by several others!
  
## Scoring

- Your score is displayed beneath the level number, starting at 1.
- It increments for every move and undo you make and resets whenever you
reset the level.
- A lower score is better, except for a score of 0 which indicates an
  incompleted level.

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
   - Technically, all keys map to a control. Try to avoid pressing an
     unlabeled key as you can accidentally skip a level this way.


## Hints
***WARNING**: Do not read this in plaintext, as the hints are "hidden" using
`<details>` tags. Read the comments in `call-by-push-block.hs` for rot-13
enciphered hints.

I recommend revealing them in order until you find one that helps. If you
are completely stuck on a level, there is a level skip code at the end.

- Levels 1-5
  - <details><summary>Spoiler</summary>You can direct the player character off
    the grid. This will require you to reset in order to beat the
    level.</details>
  - <details><summary>Spoiler</summary>The hash is a static obstacle. Like a
    hole, it cannot be moved or passed through. You also cannot push blocks into
    it.</details>
  - <details><summary>Spoiler</summary>You can push multiple blocks at a
    time.</details>
  - <details><summary>Spoiler</summary>You can push blocks off of the grid. Be
    careful not to push a block you need off the grid.</details>
  - <details><summary>Spoiler</summary>You need an empty tile adjacent to a
    block in order to push it. For example, to push a block down, it needs an
    empty tile above it. Keep this in mind even for later levels since it will
    allow you to identify holes that are inaccessible to certain
    blocks.</details>
- Levels 5-8
  - <details><summary>Spoiler</summary>The first hint is no longer true: there
    are conditions where pushing a player character off the grid is necessary.
    Remember: you only need to push a block into each hole.</details>
  - <details><summary>Spoiler</summary>The order you try things in often
    matters. Sometimes you may have the right idea but wrong execution
    order.</details>
  - <details><summary>Spoiler</summary>Reset or undo early if you realize you
    are in an unwinnable state. A quick trick to determine whether you are in
    one is to count the number of remaining holes and check if there is a block
    that can be pushed into each. Refer also to the last hint of the previous
    section.</details>
- Levels 9-15
  - <details><summary>Spoiler</summary>The plus is a tile that destroys both
    player characters and blocks alike. When a block is pushed into it or a
    player character moves into it, both the plus and the object encountering it
    are replaced with an empty tile.</details>
  - <details><summary>Spoiler</summary>Take advantage of hashes or holes to move
    some player characters will keeping others stationary.</details>
  - <details><summary>Spoiler</summary>Elaborating on the above hint, you will
    find that some things which seem impossible are only so because your player
    characters are not coordinated in space properly. Sometimes you need to
    coordinate them by moving one and keeping another stationary. Other times
    they will be separated in an unwinnable state.</details>
- Level skip cheat code
  - <details><summary>Spoiler</summary>Type "Cheat Code" (case sensitive) and
    press enter to skip the level. This will confer a score of 0, indicating the
    level was skipped. If you are playing on the unbuffered version, just typing
    the first letter will suffice.</details>
  
## Acknowledgements
- Golfing: I've learned a bunch about code golfing in Haskell from various
tips and threads I've read from inumerably many people. I got some
explicit help from The Ninteenth Byte on Stack Exchange with shaving
characters off. Thank you!
- Testing and design: I solicited help from a bunch of people who
graciously lent me their time and feedback. Thank you!
- The jam and feedback: #haskell-game and the organizers of The Haskell Tiny
  Game Jam. Thank you!
- Playing the game in the browser: [Radon](https://github.com/raxod502) and
  [Radian](https://radian.codes/) for creating and hosting Riju.
