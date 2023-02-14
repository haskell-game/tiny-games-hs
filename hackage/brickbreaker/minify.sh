#!/bin/sh

set -e

runhaskell minify.hs < brickbreaker.unminified.hs > brickbreaker.hs

cat >> brickbreaker.hs <<EOF
-- ^10 ------------------------------------------------------------------ 80> --
{- hackage-10-80/brickbreaker (fgaz)

EOF

tail -n+3 README.md >> brickbreaker.hs

cat >> brickbreaker.hs <<EOF

Unminified version:

EOF

cat brickbreaker.unminified.hs >> brickbreaker.hs

cat >> brickbreaker.hs <<EOF

-}
EOF
