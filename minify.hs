#!cabal
{- cabal:
default-language: GHC2021
default-extensions: BlockArguments DataKinds DuplicateRecordFields LambdaCase MultiWayIf OverloadedStrings PatternSynonyms RecordWildCards TypeFamilies UnicodeSyntax ViewPatterns
build-depends: base, containers, ghc, optparse-generic, text, mtl
ghc-options: -Wall -Wextra -Wno-unticked-promoted-constructors -Wunused-packages
-}

import Control.Applicative (Alternative ((<|>)), asum, empty, liftA2, many)
import Control.Monad.State
import Data.Bifunctor
import Data.Char
import Data.Containers.ListUtils qualified as ListUtils
import Data.List hiding (head, tail)
import Data.List.NonEmpty (NonEmpty (..), nonEmpty)
import Data.Map qualified as Map
import Data.Maybe
import Data.Text qualified as Text
import Data.Text.IO qualified as Text
import GHC.Data.EnumSet qualified as EnumSet
import GHC.Data.StringBuffer
import GHC.Parser.Lexer
import GHC.Types.SrcLoc
import Options.Generic
import Prelude hiding (head, tail)

-- | Categorial dual of `either id id`.
fork ∷ (input → left) → (input → right) → input → (left, right)
fork function gunction = \input → (function input, gunction input)

for ∷ Functor functor ⇒ functor α → (α → β) → functor β
for = flip fmap

data Command = Command {source, target ∷ FilePath} deriving (Generic, Show)
instance ParseRecord Command

-- | These tokens do not require any white space around them.
specialTokens ∷ [Text]
specialTokens = ["(", ",", ")", "{", ";", "}", "[", "]", "←", "→", "<-", "->", "∷", "::", "\\"]

isAllowedInIdentifier ∷ Char → Bool
isAllowedInIdentifier = or . flip fmap [isAlphaNum, (== '_'), (== '\'')] . flip ($)

defaultParserOptions ∷ ParserOpts
defaultParserOptions = mkParserOpts EnumSet.empty EnumSet.empty False False False False

defaultRealSourceLocation ∷ RealSrcLoc
defaultRealSourceLocation = mkRealSrcLoc "" 1 1

defaultLexer ∷ StringBuffer → ParseResult [Located Token]
defaultLexer stringBuffer = lexTokenStream defaultParserOptions stringBuffer defaultRealSourceLocation

-- | Try and tear the substring corresponding to a token out from the source code.
tearOut ∷ Text → Located Token → Maybe (Text, Token)
tearOut text (L realSrcSpan token) =
  let
    textLines = Text.lines text ++ repeat ""
    textLine = textLines !! (srcLocLine start - 1)
    (start, end) = case realSrcSpan of
      RealSrcSpan ((realSrcSpanStart `fork` realSrcSpanEnd) → spanTuple) _ → spanTuple
      UnhelpfulSpan _ → error "Impossible: We parse from file."
   in
    if srcLocLine start /= srcLocLine end
      then Nothing -- We expect that no token is spread across two or more lines.
      else Just ((Text.take (srcLocCol end - srcLocCol start) . Text.drop (srcLocCol start - 1)) textLine, token)

-- | Ask GHC to split source code into tokens.
lexify ∷ Text → Maybe [(Text, Token)]
lexify sourceCode =
  let textToParseResult = defaultLexer . stringToStringBuffer . Text.unpack
   in case textToParseResult sourceCode of
        POk _ tokens → traverse (tearOut sourceCode) tokens
        PFailed _ → Nothing

data Stripes (done ∷ Bool) black white where
  Black ∷ black → Stripes False black white → Stripes True black white
  White ∷ white → Stripes True black white → Stripes False black white
  Done ∷ black → Stripes True black white

instance Bifunctor (Stripes any) where
  bimap function gunction (Black black stripes) = Black (function black) (bimap function gunction stripes)
  bimap function gunction (White white stripes) = White (gunction white) (bimap function gunction stripes)
  bimap function _ (Done black) = Done (function black)

flatten ∷ Stripes any black white → [Either black white]
flatten (Black black stripes) = Left black : flatten stripes
flatten (White white stripes) = Right white : flatten stripes
flatten (Done black) = [Left black]

data Room = Love | Hate | Indifference deriving (Show, Eq, Ord)

loves, hates, isIndifferentTowards ∷ black → Stripes True black Room → Stripes True black Room
black `loves` stripes = Black black (White Love stripes)
black `hates` stripes = Black black (White Hate stripes)
black `isIndifferentTowards` stripes = Black black (White Indifference stripes)

getBlack ∷ Stripes True black white → black
getBlack (Black black _) = black
getBlack (Done black) = black

tokensToStripes ∷ NonEmpty (Token, Text) → Stripes True (Token, Text) Room
tokensToStripes = fix \recurse → \(token :| tokens) → case nonEmpty tokens of
  Nothing → Done token
  Just (recurse → stripes) → case (token, stripes) of
    ((ITat, _), _) → token `loves` stripes
    (_, (Black (ITat, _) _)) → token `loves` stripes
    ((_, this), (getBlack → (_, that))) →
      if
          | Text.null this || Text.null that → error "Invariant: Tokens are not blank."
          | this == "∷" && that == "∀" → token `hates` stripes
          | any (`elem` specialTokens) [this, that] → token `isIndifferentTowards` stripes
          | ((== '"') . Text.last) this || ((== '"') . Text.head) that → token `isIndifferentTowards` stripes
          | (isAllowedInIdentifier . Text.last) this == (isAllowedInIdentifier . Text.head) that → token `hates` stripes
          | otherwise → token `isIndifferentTowards` stripes

data Parser input output = Parser {parse ∷ input → [(input, output)]}
uncurryParser ∷ (firstOutput → Parser input nextOutput) → (input, firstOutput) → [(input, nextOutput)]
uncurryParser makeParser (input, firstOutput) = parse (makeParser firstOutput) input
instance Functor (Parser input) where fmap function (Parser parser) = Parser ((fmap . fmap . fmap) function parser)
instance Applicative (Parser input) where
  pure output = Parser \input → [(input, output)]
  (<*>) = ap
instance Monad (Parser input) where
  firstParser >>= makeNextParser = Parser \firstInput → parse firstParser firstInput >>= uncurryParser makeNextParser
instance Monoid input ⇒ Alternative (Parser input) where
  empty = Parser do const mempty
  thisParser <|> thatParser = Parser \input →
    let
      thisOutput = parse thisParser input
      thatOutput = parse thatParser input
     in
      thisOutput <> thatOutput
instance Monoid input ⇒ MonadPlus (Parser input)

class (Monad parser, Alternative parser) ⇒ MonadParser parser where
  type Chunk parser
  type Input parser
  foresee ∷ parser output → parser output
  orElse ∷ parser output → parser output → parser output
  match ∷ (Chunk parser → Bool) → parser (Chunk parser)
  matchMaybe ∷ (Chunk parser → Maybe output) → parser output
  close ∷ parser ()

class List list where
  type Item list
  bestow ∷ Maybe (Item list, list) → list
  behead ∷ list → Maybe (Item list, list)

pattern (:::) ∷ ∀ {list}. List list ⇒ Item list → list → list
pattern head ::: tail ← (behead → Just (head, tail))
  where
    head ::: tail = bestow (Just (head, tail))

pattern End ∷ ∀ {list}. List list ⇒ list
pattern End ← (behead → Nothing)
  where
    End = bestow Nothing

{-# COMPLETE (:::), End #-}

instance List Text where
  type Item Text = Char
  bestow Nothing = Text.empty
  bestow (Just (head, tail)) = head `Text.cons` tail
  behead = Text.uncons

instance List [item] where
  type Item [item] = item
  bestow Nothing = []
  bestow (Just (head, tail)) = head : tail
  behead [] = Nothing
  behead (head : tail) = Just (head, tail)

instance (List input, Monoid input) ⇒ MonadParser (Parser input) where
  type Chunk (Parser input) = Item input
  type Input (Parser input) = input
  foresee parser = Parser \input → for (parse parser input) \(_, output) → (input, output)
  thisParser `orElse` thatParser = Parser \input →
    let thisOutput = parse thisParser input
     in if null thisOutput then parse thatParser input else thisOutput
  match matching = Parser \case
    (token ::: tokens) | matching token → [(tokens, token)]
    _ → End
  matchMaybe making = Parser \case
    (token ::: tokens) → maybe [] (pure . (tokens,)) (making token)
    _ → End
  close = Parser \input → case behead input of
    Nothing → [(End, ())]
    Just _ → []

runParser ∷ List input ⇒ Parser input output → input → Maybe output
runParser parser input = case parse parser input of
  [(End, output)] → Just output
  _ → Nothing

instance (Monoid input, MonadParser (Parser input)) ⇒ MonadParser (StateT state (Parser input)) where
  type Chunk (StateT state (Parser input)) = Chunk (Parser input)
  type Input (StateT state (Parser input)) = input
  foresee statefulParser = do
    stateOfParser ← get
    let parser = evalStateT statefulParser stateOfParser
    lift do foresee parser
  (StateT thisStatefulParser) `orElse` (StateT thatStatefulParser) = StateT \stateOfParser →
    let
      Parser thisParser = thisStatefulParser stateOfParser
      Parser thatParser = thatStatefulParser stateOfParser
     in
      Parser \input →
        let thisParseResult = thisParser input
         in if null thisParseResult then thatParser input else thisParseResult
  match = fmap lift match
  matchMaybe = fmap lift matchMaybe
  close = lift close

fromLeft ∷ Either left right → Maybe left
fromLeft (Left left) = Just left
fromLeft (Right _) = Nothing

fromRight ∷ Either left right → Maybe right
fromRight (Right right) = Just right
fromRight (Left _) = Nothing

parseStripes
  ∷ (Monoid monoid, MonadParser monad)
  ⇒ monad monoid
  → monad monoid
  → monad monoid
parseStripes parseToken parseRoom = do
  firstToken ← parseToken
  leftovers ← many do
    room ← parseRoom
    token ← parseToken
    pure [room, token]
  pure do mconcat (firstToken : concat leftovers)

try ∷ MonadParser parser ⇒ parser output → parser (Maybe output)
try this = fmap Just this `orElse` pure Nothing

alsuch
  ∷ (Item (Input parser) ~ Chunk parser, List (Input parser), MonadParser parser, Eq (Item (Input parser)))
  ⇒ Input parser
  → parser (Input parser)
alsuch End = pure End
alsuch (token ::: tokens) = liftA2 (:::) (match (== token)) (alsuch tokens)

-- | Parse a run of tokens that must have no line breaks.
chopRun ∷ StateT Int (Parser [Either (Token, Text) Room]) Text
chopRun =
  (close *> pure "") <|> fix \recurse → do
    (_, text) ← matchMaybe fromLeft
    room ← try (foresee (matchMaybe fromRight))
    modify (+ Text.length text)
    case room of
      Just Love → do
        _ ← matchMaybe fromRight
        fmap (text <>) recurse
      _ → pure text

-- | Parse appropriate white space between runs.
chopRoom ∷ StateT Int (Parser [Either (Token, Text) Room]) Text
chopRoom = do
  room ← lift do matchMaybe fromRight
  pad ← case room of
    Love → empty
    Hate → pure " "
    Indifference → pure ""
  text ← foresee chopRun
  lengthSoFar ← get
  let newLength = lengthSoFar + Text.length text + Text.length pad
  if newLength > 80
    then do
      put 0
      pure "\n"
    else do
      modify (+ Text.length pad)
      pure pad

cut80 ∷ StateT Int (Parser [Either (Token, Text) Room]) Text
cut80 = fmap Text.concat (parseStripes (fmap pure chopRun) (fmap pure chopRoom)) <* lift close

data RegularExpression input output where
  Pick ∷ (input → Bool) → RegularExpression input input
  Choice ∷ [RegularExpression input output] → RegularExpression input output
  Adjacent ∷ [RegularExpression input output] → RegularExpression input output
  Star ∷ RegularExpression input output → RegularExpression input output
  Match ∷ RegularExpression input output → RegularExpression input [output]
  Replace ∷ ([input] → [input]) → RegularExpression input input → RegularExpression input input

regularExpressionParser ∷ RegularExpression input output → Parser [input] [output]
regularExpressionParser = fix \recurse → \case
  Pick check → fmap pure do match check
  Choice regularExpressions → asum (fmap recurse regularExpressions)
  Adjacent regularExpressions → foldr (liftA2 (<>)) (pure []) (fmap recurse regularExpressions)
  Star regularExpression → fmap concat do many (recurse regularExpression)
  Match regularExpression →
    let matcher = regularExpressionParser regularExpression
     in (fmap reverse . flip execStateT [] . fix) \parser → do
          maybeMatched ← lift do try matcher
          maybe (pure ()) (modify . (:)) maybeMatched
          _ ← match (const True)
          parser <|> close
  Replace replace regularExpression →
    let matcher = regularExpressionParser regularExpression
     in fix \parser → do
          maybeMatched ← try matcher
          let replaced = maybe [] replace maybeMatched
          fmap (replaced <>) do
            liftA2 (:) (match (const True)) parser `orElse` (close *> pure [])

searchAndReplace ∷ ([token] → [token]) → RegularExpression token token → [token] → [token]
searchAndReplace replace regularExpression input =
  case runParser (regularExpressionParser (Replace replace regularExpression)) input of
    Just output → output
    Nothing → error "Something went wrong!"

repair ∷ [(Token, Text)] → [(Token, Text)]
repair tokens =
  let
    -- Sometimes GHC's lexer forgets to close the outermost curly brace.
    closingCurlyBraces = replicate ((length . filter ((== "{") . snd)) tokens - (length . filter ((== "}") . snd)) tokens) (ITccurly, "}")
    dropRedundantSemicolon = searchAndReplace (const [(ITccurly, "}")]) (Adjacent [Pick ((== ";") . snd), Pick ((== "}") . snd)])
    dropModuleHeader = searchAndReplace
      do const ([] ∷ [(Token, Text)])
      do Adjacent [Pick ((== "module") . snd), Pick ((== "Main") . snd), Pick ((== "where") . snd)]
   in
    (dropModuleHeader . dropRedundantSemicolon) (tokens <> closingCurlyBraces)

smallPrint ∷ (Text, Token) → Text
smallPrint (_, ITvocurly) = "{"
smallPrint (_, ITvccurly) = "}"
smallPrint (_, ITsemi) = ";"
smallPrint (_, (ITdocCommentNext _ _)) = mempty
smallPrint (_, (ITdocCommentPrev _ _)) = mempty
smallPrint (_, (ITdocCommentNamed _ _)) = mempty
smallPrint (_, (ITdocSection _ _ _)) = mempty
smallPrint (_, (ITdocOptions _ _)) = mempty
smallPrint (_, (ITlineComment _ _)) = mempty
smallPrint (_, (ITblockComment _ _)) = mempty
smallPrint (verbatim, _) = verbatim

render ∷ (Text, Token) → (Token, Text)
render this@(_, token) = (token, smallPrint this)

renameCurlies ∷ Text → Text
renameCurlies input =
  let
    (curlyConstructors, curlyVariables) =
      ( partition (isUpper . (!! 1))
          . fromMaybe (error "Cannot parse curlies!")
          . runParser parseCurlies
          . Text.unpack
      )
        input
    shortenings = Map.fromList (ListUtils.nubOrd curlyConstructors `zip` constructors <> ListUtils.nubOrd curlyVariables `zip` variables)
    shortenCurlies = (regularExpressionParser . Replace (shortenings Map.!)) curliesRegularExpression
   in
    (Text.pack . fromMaybe (error "Cannot replace curlies!") . runParser shortenCurlies . Text.unpack) input
 where
  parseCurlies = (regularExpressionParser . Match) curliesRegularExpression
  curliesRegularExpression = Adjacent [Pick (== '{'), Star (Pick isAllowedInIdentifier), Pick (== '}')]
  variables = inflate ['ऄ' .. 'ह']
  constructors = inflate ['Ա' .. 'Ֆ']
  inflate xs = fmap pure xs ++ [x : ys | ys ← inflate xs, x ← xs]

parseUntil ∷ MonadParser parser ⇒ parser element → parser end → parser [element]
parseUntil parseElement parseEnd = fix \recurse → do
  maybeEnd ← (try . foresee) parseEnd
  case maybeEnd of
    Just _ → pure []
    Nothing → do
      maybeElement ← try parseElement
      case maybeElement of
        Nothing → empty
        Just element → fmap (element :) recurse

data ParsedSourceCode = ParsedSourceCode
  { hashbang ∷ Maybe Text
  , leadingComments ∷ Text
  , moduleHeader ∷ Maybe Text
  , actualCode ∷ Text
  , trailingComments ∷ Text
  }
  deriving (Show)

manyOrElse ∷ MonadParser parser ⇒ parser a → parser [a]
manyOrElse parser = someOrElse parser `orElse` pure []

someOrElse ∷ MonadParser parser ⇒ parser a → parser [a]
someOrElse parser = liftA2 (:) parser (manyOrElse parser)

parseSourceCode ∷ Parser Text ParsedSourceCode
parseSourceCode = do
  hashbang ← try parseHashbang
  leadingComments ← fmap Text.concat do manyOrElse parseComment
  moduleHeader ← try parseModuleHeader
  actualCode ← parseCode
  trailingComments ← fmap Text.concat do many parseComment <* close
  pure ParsedSourceCode {..}
 where
  inSpace ∷ Parser Text Text → Parser Text Text
  inSpace parser =
    (fmap Text.concat . sequence)
      [(fmap Text.pack . many . match) isSpace, parser, (fmap Text.pack . many . match) isSpace]
      <* foresee (match (not . isSpace) *> pure () <|> close)
  parseUntilNewLine ∷ Parser Text Text
  parseUntilNewLine = liftA2 (<>) ((fmap Text.pack . many . match . (/=)) '\n') (alsuch "\n")
  parseComment = inSpace (parseLineComment <|> parseBlockComment)
  parseHashbang = liftA2 (<>) (alsuch "#!") parseUntilNewLine
  parseLineComment, parseBlockComment ∷ Parser Text Text
  parseLineComment = (fmap Text.concat . sequence) [alsuch "--", parseUntilNewLine]
  parseBlockComment =
    (fmap Text.concat . sequence)
      [alsuch "{-", fmap Text.pack (match (const True) `parseUntil` alsuch "-}"), alsuch "-}"]
  parseModuleHeader =
    (inSpace . fmap Text.concat . sequence)
      [alsuch "module", fmap Text.pack (match (const True) `parseUntil` alsuch "where"), alsuch "where"]
  parseCode ∷ Parser Text Text
  parseCode = fmap Text.pack (match (const True) `parseUntil` (many parseComment *> close))

data SourceCodeToRender = SourceCodeToRender
  { hashbang ∷ Maybe Text
  , leadingComments ∷ Text
  , moduleHeader ∷ Maybe Text
  , actualCode ∷ Text
  , trailingComments ∷ Text
  }
  deriving (Show)

renderSourceCode ∷ SourceCodeToRender → Text
renderSourceCode SourceCodeToRender {..} =
  Text.concat
    [ fromMaybe "" hashbang
    , leadingComments
    , actualCode
    , trailingComments
    ]

processActualCode ∷ Text → Maybe Text
processActualCode actualCode = do
  pure actualCode
    >>= lexify . renameCurlies
    >>= nonEmpty . filter ((/= "") . snd) . repair . fmap render
    >>= runParser (evalStateT cut80 0) . flatten . tokensToStripes

main ∷ IO ()
main = do
  Command {..} ← getRecord @IO @Command "Minify your Haskell files!"
  let output = if target == "-" then Text.putStrLn else Text.writeFile target
  rawSourceCode ← Text.readFile source
  let ParsedSourceCode {..} = fromMaybe (error "Cannot parse source code!") do runParser parseSourceCode rawSourceCode
  let codeToProcess = fromMaybe "module Main where" moduleHeader <> "\n" <> actualCode
  let processedActualCode = fromMaybe (error "Cannot process actual code!") do processActualCode codeToProcess
  output do renderSourceCode SourceCodeToRender {actualCode = processedActualCode, ..}
