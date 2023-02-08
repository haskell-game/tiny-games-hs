# Haskell Tiny Game Jam

Inspired by the [BASIC 10Liner contest](https://www.homeputerium.de) (see their english rules at the bottom):
the first Haskell tiny games contest runs through February 2023!
The prize.. glory! <!-- and advancing the Haskell game dev craft -->

[Matrix]: https://matrix.to/#/#haskell-game:matrix.org
[IRC]:    https://web.libera.chat/#haskell-game

Submit your entries now (as many as you like) to this repo
(push if you have access, or send a PR),
or paste in the #haskell-game chat ([Matrix] or [IRC]) and we'll commit for you.
sm and f-a are your judges, informed by #haskell-game.
Here are the general rules for February:

- Make a playable game in one haskell file of up to 10 lines of up to 80 characters each.
- This can be a [runghc], [stack] or [cabal] script, or a small haskell program, but not a multi-file project.
  Some templates are provided to give ideas.
- The script or program must run reliably (eg like a stack script),
  or contain reliable build instructions (eg a ghc command line with all required package options).
  This is a requirement and helps ensure a good experience for all.
  Our ideal is a 10 line program that just works, like BASIC.
- The game must be accompanied by a small square screenshot; this is a requirement.
- The game should ideally run on all major platforms.
- Contest entries will be collected in this repo.

[runghc]: https://downloads.haskell.org/ghc/latest/docs/users_guide/runghc.html
[stack]:  https://docs.haskellstack.org/en/stable/script_command
[cabal]:  https://cabal.readthedocs.io/en/3.6/cabal-commands.html#cabal-v2-run

Compete in any or all of these categories:

## prelude (gam-10-80-hs-prelude)

- Only the standard prelude may be used (no imports). ([template1](prelude/template1.hs))

<table><tr>
<td><a href="prelude/guess1.hs"><img src="prelude/guess1.png" width=100 height=100><br>guess1</a><br>(sm)</td>
</tr></table>

## base (gam-10-80-hs-base)

- Imports from the base package may be used. ([template1](base/template1.hs))

<table><tr>
<td><a href="base/timing"><img src="base/timing/timing.png" width=100 height=100><br>timing</a><br>(TravisCardwell)</td>
</tr></table>

## default (gam-10-80-hs-default)

- All packages installed by default with the tested ghc version may be used. ([template1](default/template1.hs))
- A second file named Import.hs may be used, to gather imports and re-exports (only).

## hackage (gam-10-80-hs-hackage)

- As above, but all packages released on Hackage may be used. ([template1](hackage/template1.hs))

<table>
<tr>
<td><a href="hackage/guess2.hs"><img src="hackage/guess2.png" width=100 height=100><br>guess2</a><br>(sm)</td>
<td><a href="hackage/wordle.hs"><img src="hackage/wordle.png" width=100 height=100><br>wordle</a><br>(halogenandtoast)</td>
<td><a href="hackage/ski/ski.hs"><img src="hackage/ski/ski.png" width=100 height=100><br>ski</a><br>(sm)</td>
<td><a href="hackage/guesscolor"><img src="hackage/guesscolor/guesscolor.png" width=100 height=100><br>guesscolor</a><br>(TravisCardwell)</td>
</tr>
<tr>
<td><a href="hackage/bulls-n-cows.hs"><img src="hackage/bulls-n-cows.png" width=100 height=100><br>bulls-n-cows</a><br>(akadude)</td>
</tr>
</table>

## Running the games

You will need a suitable version of GHC (8.10.7+, 9.2.5+, or 9.4.4+ are good bets), and stack (or cabal).
See <https://www.haskell.org/get-started/>.
Once Haskell is installed, if you have `bash` you can run the games easily by running `./play` in this repo.
If you don't have bash, cd into each game's directory and try running the game's .hs file.
If that fails, look for run/build instructions in the file or a nearby readme.
