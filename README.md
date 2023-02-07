# Haskell Tiny Game Jam

Inspired by the [BASIC 10Liner contest](https://www.homeputerium.de) (see their english rules at the bottom):
the first Haskell tiny games contest runs through February 2023!

[Matrix]: https://matrix.to/#/#haskell-game:matrix.org
[IRC]:    https://web.libera.chat/#haskell-game

Submit your entries now, here or in the #haskell-game chat ([Matrix] or [IRC]).
The prize.. glory! <!-- and advancing the Haskell game dev craft -->
f-a and sm are your judges, informed by #haskell-game.
Here are the categories, rules and entries for February.

## prelude (gam-10-80-hs-prelude)

- Write a playable game in haskell, in one file containing up to 10 lines of up to 80 characters each.
- This can be a stack, cabal, or runghc script. runghc scripts must note the ghc version tested with.
- Only the standard prelude may be used (no imports).
- The game should just work, ideally on all major platforms.
- The game must be accompanied by a small square screenshot.

## base (gam-10-80-hs-base)

- As above, but imports from the base package may be used.

[<img src="base/guess1.png" width=100 height=100><br>guess1](base/guess1.hs)

## default (gam-10-80-hs-default)

- As above, but a second file named Import.hs may be used, to gather imports and re-exports (only).
- All packages installed by default with the tested ghc version may be used.

[<img src="default/guess2.png" width=100 height=100><br>guess2](default/guess2.hs)

## hackage (gam-10-80-hs-hackage)

- As above, but all packages released on Hackage may be used.

