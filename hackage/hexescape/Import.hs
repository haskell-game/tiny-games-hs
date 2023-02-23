{-# LANGUAGE PackageImports #-}
module Import (module I) where  -- imports for hexescape.hs
import "grid"   Math.Geometry.Grid           as I (centre,directionTo,indices,neighbours)
import "grid"   Math.Geometry.Grid.Hexagonal as I (hexHexGrid)
import "random" System.Random                as I (randomRIO)
import "base"   Data.List                    as I ((\\))