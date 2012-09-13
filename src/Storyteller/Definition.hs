module Storyteller.Definition
    ( Control(..)
    , Formatter(..)
    , Operator(..)
    , Directive(..)
    , Inline(..)
    , Block(..)
    , File(..)
    ) where

data Control
    = Break
    | Rule
    deriving (Eq, Enum, Show)

data Formatter
    = Italic
    | Underline
    | Bold
    | Subscript
    | Superscript
    | Comment
    | Header
    deriving (Eq, Enum, Show)

data Operator
    = Include
    | Character
    | Place
    | Time
    | Code
    | Quote
    | Math
    deriving (Eq, Enum, Show)

data Directive
    = Tag
    | Mode
    | Footnote
    deriving (Eq, Enum, Show)

data Inline
    = Str String
    | Fmt Formatter [Inline]
    | Opr Operator [[Inline]]
    | Dir Directive [Inline] [Block]
    deriving Show

data Block
    = Ctl Control
    | Par [Inline]
    deriving Show


data File = File
    { name       :: String
    , paragraphs :: [Block]
    } deriving Show
