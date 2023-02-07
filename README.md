# Haskell Tiny Game Jam

Inspired by the [BASIC 10Liner contest](https://www.homeputerium.de) (see their english rules at the bottom):
the first Haskell tiny games contest runs through February 2023!
The prize.. glory! <!-- and advancing the Haskell game dev craft -->

[Matrix]: https://matrix.to/#/#haskell-game:matrix.org
[IRC]:    https://web.libera.chat/#haskell-game

Submit your entries now (as many as you like) to this repo,
or paste in the #haskell-game chat ([Matrix] or [IRC]).
sm and f-a are your judges, informed by #haskell-game.
Here are the general rules for February:

- Make a playable game in one haskell file of up to 10 lines of up to 80 characters each.
- This can be a runghc, stack, cabal script.. non-stack/cabal scripts should mention the GHC version tested with.
  Some templates are provided but you needn't use them. 
- The game should reliably just work, ideally on all major platforms.
- The game should include its category/name, and optionally author info (abbrevs. ok).
- The game must be accompanied by a small square screenshot.
- Contest entries will be collected in this repo.

Compete in any or all of these categories:

## prelude (gam-10-80-hs-prelude)

- Only the standard prelude may be used (no imports). ([template1](prelude/template1.hs))

[<img src="prelude/guess1.png" width=100 height=100><br>guess1](prelude/guess1.hs) (sm)

## base (gam-10-80-hs-base)

- Imports from the base package may be used. ([template1](base/template1.hs))

## default (gam-10-80-hs-default)

- All packages installed by default with the tested ghc version may be used. ([template1](default/template1.hs))
- A second file named Import.hs may be used, to gather imports and re-exports (only).

[<img src="default/guess2.png" width=100 height=100><br>guess2](default/guess2.hs) (sm)

## hackage (gam-10-80-hs-hackage)

- As above, but all packages released on Hackage may be used. ([template1](hackage/template1.hs))

