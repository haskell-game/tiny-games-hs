# Haskell Tiny Game Jam

Inspired by the [BASIC 10Liner contest](https://www.homeputerium.de) (english rules are at the bottom of that page):
the first Haskell tiny games contest runs through February 2023!
Your mission: make a playable game in 10 lines of 80 characters of Haskell.
The prize.. glory! 
Also fun, learning, and advancing Haskell's suitability for game dev and programming in the small.

<div align=center>

[Rules](#rules)
| [Games](#games)
| [Let's play!](#lets-play)
| [Development](#development)

</div>

[Matrix]: https://matrix.to/#/#haskell-game:matrix.org
[IRC]:    https://web.libera.chat/#haskell-game

## Rules

Submit your [entries](#games) between now and end of February!
sm and f-a will be your judges.
See the #haskell-game [Matrix] or [IRC] chat 
or this repo's [issue tracker](issues) for help/feedback/announcements.

Here are the contest rules for this round (HTG1):

1. You can submit any number of entries to the official repo, haskell-game/tiny-games-hs.
   Each should be a playable game in one haskell file
   of up to 10 lines of up to 80 characters each, in one of the following categories:
   - `prelude-10-80`, allowing no imports
   - `base-10-80`, allowing imports from the base package
   - `default-10-80`, allowing imports from GHC's default packages, 
     plus an optional Import.hs file to gather and re-export imports (only)
   - `hackage-10-80`, allowing imports from all of Hackage, and an Import.hs file.

2. The entry can be a script ([runghc], [stack], [cabal], ...)
   or a small program requiring compilation, but not a multi-file project.
   Our ideal is a self-contained executable 10 line program that just works, like BASIC programs.
   Here are some templates to give ideas:
   [prelude/template1](prelude/template1.hs),
   [base/template1](base/template1.hs),
   [default/template1](default/template1.hs),
   [hackage/template1](hackage/template1.hs)

3. Unlimited comments are permitted after line 11.
   The game's `category/gamename (author)` info should appear here,
   plus any essential info like player controls, so that the game is usable
   to someone seeing just this file.

4. Achieving programs that "just work" is a core principle and part of the challenge.
   The script or program must either
   be reliably runnable via shebang line (these use up your line count, but improve runnability; `env -S` is allowed)
   or contain a reliable build/run command line with all needed options, in the comments
   (the `play` script will use this).
   Games which aren't straightforward to run and enjoy are incomplete.
   See also the [runnability tips](#runnability-tips) below.

5. The game should be portable, running on all major platforms, ideally.

6. A small square screenshot must be provided, ideally static and non-gif.
   (Not animated, because Github's player overlay will obscure it.
   Not a gif, because you can't make those clickable on Github it seems.)

7. A README file is optional but makes browsing your game more pleasant for website visitors.
   Feel free to include animations, or discussion of the game/code/your experience.

8. An unminified version of the code, easier to read and learn from, is optional but welcome.

9. You can update your entries freely until the contest end, 2023-02-28 11:59:59 UTC,
   at which time they are frozen for posterity and judging (no exceptions).
   If you need to share post-contest improvements, you are welcome to publish as new files in the same directory.

[runghc]: https://downloads.haskell.org/ghc/latest/docs/users_guide/runghc.html
[stack]:  https://docs.haskellstack.org/en/stable/script_command
[cabal]:  https://cabal.readthedocs.io/en/3.6/cabal-commands.html#cabal-v2-run

## Games

Here are the entries received so far!

### prelude-10-80
<!-- (No imports) -->
<table>
<tr>
<td><a href="prelude/guess1"><img src="prelude/guess1/guess1.png" width=100 height=100><br>guess1</a><br>(sm)</td>
<td><a href="prelude/pure-doors"><img src="prelude/pure-doors/pure-doors.png" width=100 height=100><br>pure-doors</a><br>(tristanC)</td>
<td><a href="prelude/fifteen"><img src="prelude/fifteen/fifteen.png" width=100 height=100><br>fifteen</a><br>(bradrn)</td>
<td><img src="prelude/chess/chess.gif" width=100 height=100><a href="prelude/chess"><br>chess</a><br>(fizruk)</td>
<td><a href="prelude/sudoku"><img src="prelude/sudoku/sudoku.png" width=100 height=100><br>sudoku</a><br>(elderephemera)</td>
</tr>
<tr>
<td><img src="prelude/matchmaking/matchmaking.gif" width=100 height=100><br><a href="prelude/matchmaking">matchmaking</a><br>(migmit)</td>
<td><img src="prelude/tiny-brot/tiny-brot.gif" width=100 height=100><br><a href="prelude/tiny-brot">tiny-brot</a><br>(tristanC)</td>
<td><img src="prelude/mini-othello/mini-othello-1.gif" width=100 height=100><br><a href="prelude/mini-othello/mini-othello.hs">mini-othello</a><br>(hellwolf)</td>
<td><a href="prelude/one-dot"><img src="prelude/one-dot/one-dot.png" width=100 height=100><br>one-dot</a><br>(OsePedro)</td>
<td><a href="prelude/expressit"><img src="prelude/expressit/expressit.png" width=100 height=100><br>expressit</a><br>(Greg8128)</td>
</tr>
<tr>
</tr>
</table>

### base-10-80
<!-- (Just the base package) -->
<table>
<tr>
<td><a href="base/timing"><img src="base/timing/timing.png" width=100 height=100><br>timing</a><br>(TravisCardwell)</td>
<td><a href="base/shoot"><img src="base/shoot/shoot.png" width=100 height=100><br>shoot</a><br>(migmit)</td>
<td><img src="base/log2048/log2048.gif" width=100 height=100><a href="base/log2048"><br>log2048</a><br>(Lysxia)</td>
<td><img src="base/rhythm/rhythm.gif" width=100 height=100><a href="base/rhythm"><br>rhythm</a><br>(elderephemera)</td>
<td><a href="base/peyton-says"><img src="base/peyton-says/peyton-says.png" width=100 height=100><br>peyton-says</a><br>(gergoerdi)</td>
</tr>
<tr>
<td><a href="base/acey-deucey"><img src="base/acey-deucey/acey-deucey.png" width=100 height=100><br>acey-deucey</a><br>(trevarj)</td>
<td><a href="base/flower-seeds"><img src="base/flower-seeds/flower-seeds.png" width=100 height=100><br>flower-seeds</a><br>(tristanC)</td>
</tr>
</table>

### default-10-80
<!-- (Just the packages that come with GHC) -->
<table>
<tr>
<td><a href="default/type-and-furious"><img src="default/type-and-furious/type-and-furious.png" width=100 height=100><br>type-and-furious</a><br>(lsmor)</td>
<td><a href="default/shmupemup"><img src="default/shmupemup/shmupemup.png" width=100 height=100><br>shmupemup</a><br>(elderephemera)</td>
<td><img src="default/tsp/tsp.gif" width=100 height=100><br><a href="default/tsp">tsp</a><br>(tristanC)</td>
</tr>
</table>

### hackage-10-80
<!-- (All of Hackage) -->
<table>
<tr>
<td><a href="hackage/guess2"><img src="hackage/guess2/guess2.png" width=100 height=100><br>guess2</a><br>(sm)</td>
<td><a href="hackage/wordle"><img src="hackage/wordle/wordle.png" width=100 height=100><br>wordle</a><br>(halogenandtoast)</td>
<td><a href="hackage/ski"><img src="hackage/ski/ski.png" width=100 height=100><br>ski</a><br>(sm)</td>
<td><a href="hackage/guesscolor"><img src="hackage/guesscolor/guesscolor.png" width=100 height=100><br>guesscolor</a><br>(TravisCardwell)</td>
<td><a href="hackage/bulls-n-cows"><img src="hackage/bulls-n-cows/bulls-n-cows.png" width=100 height=100><br>bulls-n-cows</a><br>(akadude)</td>
</tr>
<tr>
<td><img src="hackage/hallway-to-hell/hallway-to-hell.gif" width=100 height=100><br><a href="hackage/hallway-to-hell">hallway-to-hell</a><br>(juliendehos)</td>
<td><a href="hackage/1234-hero"><img src="hackage/1234-hero/1234-hero.png" width=100 height=100><br>1234-hero</a><br>(gelisam)</td>
<td><img src="hackage/crappy-flappy/crappy-flappy.gif" width=100 height=100><br><a href="hackage/crappy-flappy">crappy-flappy</a><br>(gergoerdi)</td>
<td><a href="hackage/pong"><img src="hackage/pong/pong.png" width=100 height=100><br>pong</a><br>(gergoerdi)</td>
<td><a href="hackage/minesweeper"><img src="hackage/minesweeper/minesweeper.png" width=100 height=100><br>minesweeper</a><br>(Greg8128)</td>
</tr>
<tr>
<td><a href="hackage/pong2"><img src="hackage/pong2/pong2.png" width=100 height=100><br>pong2</a><br>(sm)</td>
<td><a href="hackage/brickbreaker"><img src="hackage/brickbreaker/brickbreaker.png" width=100 height=100><br>brickbreaker</a><br>(fgaz)</td>
<td><img src="hackage/lazy-march/lazy-march.gif" width=100 height=100><br><a href="hackage/lazy-march">lazy-march</a><br>(tristanc)</td>
<td><a href="hackage/balances"><img src="hackage/balances/balances.png" width=100 height=100><br>balances</a><br>(sm)</td>
<td><a href="hackage/vaders"><img src="hackage/vaders/vaders.png" width=100 height=100><br>vaders</a><br>(gergoerdi)</td>
</tr>
<tr>
<td><a href="hackage/tetris"><img src="hackage/tetris/tetris.png" width=100 height=100><br>tetris</a><br>(gergoerdi)</td>
</tr>
</table>

## Let's play!

You will need a suitable version of GHC (9.2.5+ or 9.4.4+ recommended), and stack (or cabal).
See <https://www.haskell.org/get-started/>.
Once Haskell is installed, and if you have bash, you can run `./play` in this repo:

![](play.dark.png)

or:

![](play-2.dark.png)

If you don't have bash, cd into each game's directory and try running the game's .hs file.
If that fails, look for running clues in that file or a nearby readme or the play script.

Additionally, you can also run `./play {game_name} --help` to view its source code and README
if available.

## Development

### Runnability tips

- Avoid requiring problematic GHC versions. In particular GHC <9.2 doesn't work well on mac.
   If you specify a GHC version/stackage snapshot, the current release is ideal (GHC 9.2, lts-20).
- env -S in the shebang line doesn't work on older GNU/Linux systems, but we allow it
   (see https://github.com/haskell-game/tiny-games-hs/issues/25).
- stack scripts can seem to hang at first startup while downloading snapshot info.
   For prelude/base/default categories, using --resolver=ghc-9.2.5 avoids this
   (see https://github.com/haskell-game/tiny-games-hs/issues/38).
- stack scripts can use --verbosity=error to silence the "Selected resolver" output.
  (Or --verbosity=info to show dependency building progress.)
- If using packages which require compilation (gloss), use stack script --compile.
   (And be aware a newer compiled binary can cause your source to be ignored.)
- cabal scripts are also welcome; they don't have --compile and require more lines (unless you use env -S)
- On mac, Terminal and iTerm 3.4 render emojis very slowly; iTerm 3.5 beta or VS Code terminal work better.

### Tools

Here are some minifiers you can try; either or both may be able to turn your game into
a brick of inscrutable code no more than 80 characters wide. Both require that you first
add curled braces and semicolons throughout your code to make it white space insensitive.

- [minify.hs](minify.hs) (from haskell-game/tiny-games-hs#14; contact @kindaro with issues/feedback)
- [hackage/brickbreaker/minify.hs](hackage/brickbreaker/minify.hs) (from haskell-game/tiny-games-hs#63; contact @fgaz)
