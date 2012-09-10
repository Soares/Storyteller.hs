module Storyteller.Reader
    ( inline
    , block
    ) where
import Control.Applicative
import Storyteller.Definition
import Storyteller.Parser
import Storyteller.Symbols
import Text.ParserCombinators.Parsec hiding ( (<|>), many, optional )

linebreak :: GenParser Char st Control
linebreak = newline *> eol *> pure Break

rule :: GenParser Char st Control
rule = d *> d *> many1 d *> eol *> pure Rule where
    d = char dash *> many (oneOf " \t")

formatter :: GenParser Char st Inline
formatter = choice (map make formatters) where
    make (c, f) = Fmt f <$> between (char c) (char c) (many1 inline)

inlineOperator :: GenParser Char st Inline
inlineOperator = choice (map make operators) where
    make (c, o) = Opr o <$> between (char c) (char c) chunks

blockOperator :: GenParser Char st Block
blockOperator = (Par . pure) <$> choice (map make operators) where
    make (c, o) = Opr o <$> between (char c) eol chunks

chunks :: GenParser Char st [[Inline]]
chunks = many1 chunk `sepBy` char sep where

chunk :: GenParser Char st Inline
chunk = try formatter <|> (Str <$> stringWithout notOperator)

directive :: GenParser Char st Inline
directive = choice (map make directives) where
    make (o, c, d) = Dir d <$> (char o *> many chunk) <*> (blocks <* char c)
    blocks = many (try block <|> promoted)
    promoted = (Par . pure) <$> inline

inline :: GenParser Char st Inline
inline = try formatter <|> try inlineOperator <|> try directive <|> plain where
    plain = Str <$> stringWithout notInline

block :: GenParser Char st Block
block = try (Ctl <$> linebreak) <|> (optional eol *> content) where
    content = try (Ctl <$> rule) <|> try blockOperator <|> paragraph
    paragraph = Par <$> (many1 inline <* eol)
