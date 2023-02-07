# Haskell Tiny Game Jam

Inspired by the [BASIC 10Liner contest](https://www.homeputerium.de) (see their english rules at the bottom):
the first Haskell tiny games contest runs through February 2023!
The prize.. glory! <!-- and advancing the Haskell game dev craft -->

[Matrix]: https://matrix.to/#/#haskell-game:matrix.org
[IRC]:    https://web.libera.chat/#haskell-game

Submit your entries now (as many as you like) to this repo,
or paste in the #haskell-game chat ([Matrix] or [IRC]).
f-a and sm are your judges, informed by #haskell-game.
Here are the categories, rules and entries for February.

## prelude (gam-10-80-hs-prelude)

- Write a playable game in haskell, in one file of up to 10 lines of up to 80 characters each,
  using only the standard prelude (no imports).
- This can be a runghc, stack, or cabal script. runghc scripts should mention the GHC version they were tested with.
- Scripts should include their category/name, and optionally author info (abbrevations ok).
- The game should just work, ideally on all major platforms.
- The game must be accompanied by a small square screenshot.
- Contest entries will be collected in this repo.

[<img src="prelude/guess1.png" width=100 height=100><br>guess1](prelude/guess1.hs) (sm)

## base (gam-10-80-hs-base)

- As above, but imports from the base package may be used.

## default (gam-10-80-hs-default)

- As above, but all packages installed by default with the tested ghc version may be used.
- A second file named Import.hs may be used, to gather imports and re-exports (only).

[<img src="default/guess2.png" width=100 height=100><br>guess2](default/guess2.hs) (sm)

## hackage (gam-10-80-hs-hackage)

- As above, but all packages released on Hackage may be used.

