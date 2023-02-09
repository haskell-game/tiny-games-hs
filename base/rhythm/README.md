# Rhythm

A simple rhythm game.

* Category: `gam-10-80-hs-base`
* Tested with: GHC 9.0.2 and 9.2.2 on Linux
* Author: ElderEphemera (Josh Price)

![Playing the game](rhythm.gif)

## Running the Game

The game should work with any VT100 compatible terminal. I have not tested on
MacOS, but I don't know of any reason why it shouldn't work.

### Linux

On Linux simply run `./rythm.hs`.

### Windows

If you have WSL handy I'd recommend just using that, although you can run the
game on windows. Due to GHC issue #2189 the game must be compiled with the
native IO manager as follows: `ghc -with-rtsopts --io-manager=native rythm.hs`.

Additionally, VT100 codes are not enabled by default. You can enable them with
the command `reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1`.
The game is playable without them but is pretty cluttered.

## Playing the Game

You play the game by pressing the indicated key when it is just below the hit
bar (shown as `-O-O-O-O-`). To the right of this bar is your score. Hitting a
note gives you a point and missing a note or pressing a key when there is no
note loses a point.

Hitting 10 notes in a row activates a streak (indicated by an asterisk next to
your score) during a streak, points are doubled. The streak is ended when a note
is missed.

The game has 10 difficulty levels (0-9) and 3 Keysets to chose from. Keyset 0 is
WADS, 1 is JKL;, and 2 is 8462 (intended for numpads).
