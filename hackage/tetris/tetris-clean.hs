#!/usr/bin/env -S stack script --resolver=lts-20 --package ansi-terminal-game
import Imports

type Line = Int
type Piece = [[Line]]
type Well = [Line]

type State =
    ( Piece
    , Well
    )

main :: IO ()
main = playGame $ Game 8 (head pieces, emptyWell) logic draw (\_->False)
  where
    emptyWell = replicate 20 0

pieces :: [Piece]
pieces = [ i, t, l, j, s, z, o ]
  where
    i =
      [[0b00011_11000
       ]
      ,[0b00001_00000
       ,0b00001_00000
       ,0b00001_00000
       ,0b00001_00000
       ]
      ]
    t =
      [[0b00001_00000
       ,0b00011_10000
       ]
      ,[0b00001_00000
       ,0b00001_10000
       ,0b00001_00000
       ]
      ,[0b00011_10000
       ,0b00001_00000
       ]
      ,[0b00001_00000
       ,0b00011_00000
       ,0b00001_00000
       ]
      ]
    l =
      [[0b00000_10000
       ,0b00011_10000
       ]
      ,[0b00001_00000
       ,0b00001_00000
       ,0b00001_10000
       ]
      ,[0b00011_10000
       ,0b00010_00000
       ]
      ,[0b00001_10000
       ,0b00000_10000
       ,0b00000_10000
       ]
      ]
    j = reverse . mirror $ l
    s =
      [[0b00001_10000
       ,0b00011_00000
       ]
      ,[0b00001_00000
       ,0b00001_10000
       ,0b00000_10000
       ]
      ]
    z = mirror s
    o =
      [[0b00001_10000
       ,0b00001_10000
       ]
      ]

    mirror = map reverse

withWalls :: Well -> Well
withWalls = overlay $ replicate 19 sideWalls ++ [bottomWall]
  where
    sideWalls  = 0b1_00000_00000_1
    bottomWall = 0b1_11111_11111_1

overlay :: [Line] -> Well -> Well
overlay = zipWith (.|.)

draw :: GEnv -> State -> Plane
draw _ s = stringPlane $ render (withWalls $ add s)

render :: Well -> String
render = unlines . map renderLine
  where
    renderLine line = concatMap (renderBlock line) [0..14]
    renderBlock line i = if indent line `testBit` i then "▇▉" else "  "
    indent line = line `shiftL` 3

add :: State -> Well
add (pieces, well) = overlay (head pieces ++ repeat 0) well

logic :: GEnv -> State -> Event -> State
logic _ s (KeyPress k)
    | k == 'k', let s' = rot s,           isValid s' = s'
    | k == 'j', let s' = move (`div`2) s, isValid s' = s'
    | k == 'l', let s' = move (*2) s,     isValid s' = s'
logic _ s _
  | let s' = fall s, isValid s' = s'
  | otherwise = glue s

rot :: State -> State
rot (piece, well) = (tail . cycle $ piece, well)

move :: (Line -> Line) -> State -> State
move x (piece, well) = (map (map x) piece, well)

fall :: State -> State
fall (piece, well) = (map (0:) piece, well)

isValid :: State -> Bool
isValid (piece, well) = all (== 0) $ zipWith (.&.) (head piece) (withWalls well)

glue :: State -> State
glue s = (newPiece, map (\ _ -> 0) erase ++ keep)
  where
    newPiece = pieces!!(sum well' `mod` 7)
    well' = add s
    (keep, erase) = partition (<2046) well'
