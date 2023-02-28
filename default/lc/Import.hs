module Import (module X) where
import           Control.Applicative          as X ((<|>))
import           Control.Monad                as X (mzero)
import           Data.Bool                    as X (bool)
import           Data.Char                    as X (isAlpha, isDigit)
import           Data.List                    as X (foldl')
import           Data.Map                     as X (Map, empty, insert, (!?))
import           Data.Maybe                   as X (fromJust, fromMaybe,
                                                    listToMaybe)
import           Text.ParserCombinators.ReadP as X
