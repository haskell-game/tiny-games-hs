#!/usr/bin/env -S stack script --resolver=lts-20.10 --package ansi-terminal-game
import Imports

main = playGame $ Game 8 (pieces!!0, replicate 20 0) logic draw (\_->False)

testCollision = zipWith (.|.)

pieces=
  [ [[0b00011_11000]
    ,[0b00001_00000
     ,0b00001_00000
     ,0b00001_00000
     ,0b00001_00000
     ]
    ]
  , [[0b00001_00000
     ,0b00011_10000
     ]
    ,[0b00001_00000
     ,0b00011_00000
     ,0b00001_00000
     ]
    ,[0b00011_10000
     ,0b00001_00000
     ]
    ,[0b00001_00000
     ,0b00001_10000
     ,0b00001_00000
     ]
    ]
  , [[0b00001_10000
     ,0b00001_10000
     ]
    ]
  , l
  , mirror l
  , z
  , mirror z
  ]
  where
    mirror = map reverse
    l =
      [[0b00000_10000
       ,0b00011_10000
       ]
      ,[0b00001_10000
       ,0b00000_10000
       ,0b00000_10000
       ]
      ,[0b00011_10000
       ,0b00010_00000
       ]
      ,[0b00001_00000
       ,0b00001_00000
       ,0b00001_10000
       ]
      ]
    z =
      [[0b00001_10000
       ,0b00011_00000
       ]
      ,[0b00001_00000
       ,0b00001_10000
       ,0b00000_10000
       ]
      ]

render = unlines . map (\row -> foldMap (\i -> if (row `shiftL` 3) `testBit` i then "██" else "  ") [0..14])
add (p,f) = testCollision ((p!!0) ++ repeat 0) f

withWell = testCollision $ replicate 19 0b1_00000_00000_1 ++ [0b1_11111_11111_1]

rot (p,f) = (tail . cycle $ p, f)

logic _ s (KeyPress k)
  | k == 'k', let s' = rot s,           can s' = s'
  | k == 'j', let s' = move (`div`2) s, can s' = s'
  | k == 'l', let s' = move (*2) s,     can s' = s'
logic _ s _
  |let s' = fall s, can s' = s'
  |otherwise = glue s

draw _ s = stringPlane $ render (withWell $ add s)
move x (p,f) = (map (map x) p, f)
fall (p,f) = (map (0:) p, f)

can (p,f) = all (== 0) $ zipWith (.&.) (head p) (withWell f)

glue s = (newPiece, map (\ _ -> 0) e ++ k)
  where
    newPiece = pieces!!(sum k`mod`7)
    (k,e) = partition(<2046) (add s)
