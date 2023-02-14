# pong2

Bounce the ball to achieve a high score.

Keys: `,` to move left, `.` to move right, `q` to quit.

Several versions are here, including some old ones for comparison:

- [pong2.0-metapong.hs](pong2.0-metapong.hs) - the original metapong.hs this was distilled from
- [pong2.1-compact.hs](pong2.1-compact.hs)   - first pass at squashing it to mostly one-line functions. The where clause was difficult to squash.
- [pong2.dev.hs](pong2.dev.hs)               - terse version; close to the final minifaction but still maintainable, one line per function. This is the master source.
- [pong2.hs](pong2.hs)                       - contest entry, minified from pong2.dev.hs

A first version.
There are some rendering and bouncing glitches.

Also, you will be very tempted to hold down a key to move faster,
but this unfortunately speeds up the game loop, making play difficult.
