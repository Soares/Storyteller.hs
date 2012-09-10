module Storyteller.Parser
    ( eol
    , escaping
    , stringWithout
    ) where
import Control.Applicative
import Storyteller.Symbols ( esc )
import Text.ParserCombinators.Parsec hiding ( (<|>), many, optional )

eol :: GenParser Char st ()
eol = try (newline *> pure ()) <|> eof

-- Parses a character not present in `chars`, unless escaped with a backslash.
-- If escaped, unescapes the character in the parsed string.
escaping :: String -> GenParser Char st Char
escaping chars = try (char esc *> char esc)
             <|> try (char esc *> oneOf chars)
             <|> noneOf chars
             <?> "None of " ++ show chars ++ " (unless escaped)"

stringWithout :: String -> GenParser Char st String
stringWithout = many1 . escaping
