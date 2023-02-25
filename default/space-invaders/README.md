# space-invaders

A vastly inferior version of the classic
[Space Invaders](https://en.wikipedia.org/wiki/Space_Invaders).

## How to play

Use `runghc space-invaders.hs` to run the game. Tested with GHC 9.2.5.

![](space-invaders.png)

Press <kbd>a</kbd> to move left, <kbd>d</kbd> to move right, and
<kbd>Space</kbd> to shoot. You win if you destroy all the aliens. You lose if
you get hit by an alien or the aliens reach the row in front of you.

## Implementation

Nothing too unusual. The game state consists of a time counter, the movement
direction of the aliens, the position of the player, the positions of the
player's bullet, the positions of the aliens' bullets, and the positions of the
aliens. A loop transforms the state with optional user input, draws the state,
sleeps for a while, and repeats.

Here is the same code, with better names and formatting:

```hs
import Control.Concurrent (threadDelay)
import Data.Bits (xor)
import Data.Bool (bool)
import Data.List ((\\), elemIndex, intersect)
import System.IO (hSetBuffering, stdin, hReady, BufferMode(..)) 

divides :: Int -> Int -> Bool -- !
divides x y = mod y x == 0

input :: IO Char -- i
input = hReady stdin >>= bool (pure '.') (getChar <* input)

type V2 = (Int, Int)

plus :: V2 -> V2 -> V2 -- p
plus (i,j) (i',j') = (i+i', j+j')

type Board = V2 -> Char

setChar :: Char -> V2 -> Board -> Board -- u
setChar c p b q = bool (b q) c (p == q)

-- Board size is 10x35
h, w :: [Int]
h = [0..9]
w = [0..34]

keep :: [V2] -> [V2] -- k
keep = intersect $ (,) <$> h <*> w

clamp :: V2 -> V2 -- c
clamp (i,j) = (min 9 $ max 0 i, min 34 $ max 0 j)

loop :: Int -> Int -> V2 -> [V2] -> [V2] -> [V2] -> IO a -- l
loop time{-t-} dir{-d-} plr{-s-} plrBlt{-b-} alienBlts{-v-} aliens{-a-}
  | null aliens = error "WIN"
  | or [True | (7,_) <- aliens] || elem plr alienBlts = error "LOSE"
  | otherwise = do
    c <- input
    let -- Move the player based on input
        plr2 = clamp $ plus (0, maybe 0 (1-) $ elemIndex c "d a") plr

        -- Move the aliens
        aliens2 = plus (0, bool 0 dir $ 10 `divides` time) <$> aliens
        aliens3 = plus (1,0) <$> aliens
        (aliens4, dir2) = bool (aliens3, -dir) (aliens2, dir) (aliens2 == keep aliens2)

        -- Move the player bullet or spawn one based on input
        plrBlt2 = keep $ map (plus (-1,0)) $ bool plrBlt [plr] $ c == ' ' && null plrBlt

        -- Remove hit aliens
        aliens5 = aliens4 \\ plrBlt2

        -- Move the alien bullets and spawn new ones
        alienBlts2 = keep $ [z | z@(i,j) <- aliens5, 307 `divides` (97*i `xor` 97*j `xor` time)]
                            ++ map (plus (mod time 2, 0)) alienBlts

        -- Draw the board
        board = foldr (setChar '*')
                      (foldr (setChar 'W')
                            (foldr (setChar 'v')
                                    (setChar 'A' plr2 (const ' '))
                                    alienBlts2)
                              aliens5)
                      plrBlt2
    putStrLn $ "\ESC[H" ++ unlines [[board (i,j) | j <- w] ++ "\ESC[K" | i <- h] ++ "\ESC[J"
    threadDelay $ 9^5
    loop (time+1) dir2 plr2 (plrBlt2 \\ aliens4) alienBlts2 aliens5

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  loop 0 1 (8,15) [] [] $ (,) <$> [1,3,5] <*> [3,6..24]

```

One interesting part is the representation of the board as `V2 -> Char`, which
allowed for a cute definition of `setChar`. 

This has been fun!
