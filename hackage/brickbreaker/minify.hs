#!/usr/bin/env runhaskell

-- fgaz's minifier
--
-- Copyright Francesco Gazzetta
-- SPDX-License-Identifier: EUPL-1.2
--
-- Like the other one, it needs explicit block syntax (semicolons and braces).
-- NOTE: It will split string literals containing spaces.

import Data.List (isPrefixOf, foldl')
import Data.Char (isSpace, isAlphaNum, isAscii)
import Data.Function (on)

main :: IO ()
main = interact $ \text ->
  let (shebang, program) =
        if "#!" `isPrefixOf` text
        then (Just $ takeWhile (/='\n') text, dropWhile (/='\n') text)
        else (Nothing, text)
  in maybe "" (<>"\n") shebang <> minify program <> "\n"

minify :: String -> String
minify = mkLines
       . filter (not . isSpace . head)
       . groupBy' (not .: canTouch `on` characterClass)
       . unlines
       . filter (not . isExtra)
       . lines

-- NOTE: tweak as needed
isExtra :: String -> Bool
isExtra s = any ($ s)
  [ isComment
  , isType
  , isSignature
  ]

isComment :: String -> Bool
isComment = isPrefixOf "--" . dropWhile isSpace

isType :: String -> Bool
isType = isPrefixOf "type"

isSignature :: String -> Bool
isSignature = elem "::" . words

-- | Basically
--     unwords . fmap concat . groupBy' (canTouch `on` (characterClass . head))
-- but splits the output into lines.
-- O(n^2) due to '<>' and 'last' in 'addToken', but inputs are going to be short
-- anyway. For now at least.
--
-- TODO make it stream
mkLines :: [String] -> String
mkLines = fst . foldl' addToken ("", 0)

addToken :: (String, Int) -> String -> (String, Int)
addToken (str, lineLen) token
  | lineLen + length spacedToken > 80 =
      if token `elem` [";", "{"]
      then (str <> "\n", 0)
      else (str <> "\n " <> token, length token + 1)
  | otherwise = (str <> spacedToken, lineLen + length spacedToken)
  where spacedToken
          | null str || null token
          || (canTouch `on` characterClass) (last str) (head token)
          = token
          | otherwise = " " <> token

data CharacterClass = IdentifierOrLit | Operator | Dot | Special deriving Eq

characterClass :: Char -> CharacterClass
characterClass '.' = Dot
characterClass c | isAlphaNum c = IdentifierOrLit
                 | c `elem` "\"'_" = IdentifierOrLit
                 | c `elem` "!#$%&*+/<=>?@\\^|-~:" = Operator
                 | not $ isAscii c = Operator
                 | c `elem` "[](),;{}" = Special
                 | isSpace c = Special
characterClass c = error $ "Unknown character: " ++ show c

-- Check if splitting or joining the characters does not change their meaning
canTouch :: CharacterClass -> CharacterClass -> Bool
canTouch Special _ = True
canTouch _ Special = True
-- . is both used for operators and for qualified names
canTouch Dot _ = False
canTouch _ Dot = False
canTouch a b = a /= b

-- Utilities
------------

(.:) :: (b -> c) -> (a1 -> a2 -> b) -> a1 -> a2 -> c
(.:) = (.).(.)

-- | Like groupBy, but equality is not transitive
groupBy' :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy' _ [] = []
groupBy' eq (x:xs) | all (eq x) (take 1 xs) =
                       let (gr, grs) = case groupBy' eq xs of
                            gr':grs' -> (gr', grs')
                            []   -> ([], [])
                         in (x : gr) : grs
                   | otherwise = [x] : groupBy' eq xs
