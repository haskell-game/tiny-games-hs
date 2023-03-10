#!/usr/bin/env -S stack script --resolver lts-20.13 --package pretty-show --package extra --verbosity error
-- Dumb ever-growing script to extract judges' numeric ratings from README.md as TSV for easier processing.
-- Run this in the tiny-games-hs-private repo. Writes several "ratings*.tsv" files.
-- Depends on README.md's structure, keep synced. 

{-# LANGUAGE RecordWildCards #-}

import Control.Monad
import Data.Bifunctor (first)
import Data.Char
import Data.List
import Data.Maybe
import Data.Ord
import Data.List.Extra (groupOn)
-- import Debug.Trace
import System.IO
import Text.Read
import Text.Show.Pretty

data Category = Prelude | Base | Default | Hackage deriving (Eq, Ord, Read, Show)

readCategory s = fromMaybe (error $ "could not read "<>show s) $ readMaybe $ capitalise s
showCategory = uncapitalise . show
capitalise s = a<>b where (a,b) = first (map toUpper) $ splitAt 1 s
uncapitalise s = a<>b where (a,b) = first (map toLower) $ splitAt 1 s

data Rating=Rating {
  rcategory :: Category,
  rgame     :: String,
  rreviewer :: String,
  rscore    :: Int
  } deriving (Show)

showRatingTSV Rating{..} = intercalate "\t" [showCategory rcategory, rgame, rreviewer, show rscore]

main = do
  f <- readFile "README.md"
  let
    -- all non-empty lines after "## Results" to file end
    ls =
      filter (not.null) $
      init $ takeWhile ((/=) "<!-- END -->") $
      drop 1 $ dropWhile ((/=) "<!-- START -->") $
      lines f
    ratingsbycategory =
      flip concatMap (splitLinesByCategory ls) $ \(cat,ls1) ->
        flip concatMap (splitLinesByGame ls1) $ \(game,ls2) ->
          flip map (splitLinesByReviewer ls2) $ \(reviewer,ls3) ->
            Rating (readCategory cat) game reviewer (getScore ls3)
    ratingsbycategoryandscore = sortOn (\r -> (rcategory r, negate $ rscore r)) ratingsbycategory

  -- withFile "ratings.tsv"        WriteMode $ \h -> mapM_ (hPutStrLn h . showRatingTSV) ratingsbycategory
  withFile "ratings.tsv" WriteMode $ \h -> mapM_ (hPutStrLn h . showRatingTSV) ratingsbycategoryandscore

splitLinesByCategory :: [String] -> [(String,[String])]
splitLinesByCategory [] = []
splitLinesByCategory (catl:ls) =
  (cat, ls1) : splitLinesByCategory ls2
  where
    cat = map toLower $ dropWhile (not.isAlpha) catl
    (ls1,ls2) = break ("### " `isPrefixOf`) ls

splitLinesByGame :: [String] -> [(String,[String])]
splitLinesByGame [] = []
splitLinesByGame (gamel:ls) =
  (game, ls1) : splitLinesByGame ls2
  where
    game = map toLower $ takeWhile (not.isSpace) $ dropWhile (not.isAlpha) gamel
    (ls1,ls2) = break ("#### " `isPrefixOf`) ls

splitLinesByReviewer :: [String] -> [(String,[String])]
splitLinesByReviewer [] = []
splitLinesByReviewer (reviewerl:ls) =
  (reviewer, ls1) : splitLinesByReviewer ls2
  where
    reviewer = takeWhile (not.(==':')) $ dropWhile (=='*') reviewerl
    (ls1,ls2) = break ("**" `isPrefixOf`) ls

-- Get the numeric score from a "Rating:" line, normally 0-10,
-- or -1 if there's no numeric score.
getScore :: [String] -> Int
getScore [] = error "getScore needs lines"
getScore ls = maybe (-1) id $ do
  l <- listToMaybe $ filter ("Rating:" `isPrefixOf`) ls
  readMaybe $ takeWhile isDigit $ dropWhile (\c -> not $ isDigit c || c=='/') l :: Maybe Int

