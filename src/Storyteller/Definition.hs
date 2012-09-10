module Storyteller.Definition
    ( Control(..)
    , Formatter(..)
    , Operator(..)
    , Directive(..)
    , Inline(..)
    , Block(..)
    ) where

data Control
    = Break
    | Rule
    deriving Show

data Formatter
    = Italic
    | Underline
    | Bold
    | Subscript
    | Superscript
    | Comment
    | Header
    deriving Show

data Operator
    = Include
    | Character
    | Place
    | Time
    | Code
    | Quote
    | Math
    deriving Show

data Directive
    = Tag
    | Mode
    | Footnote
    deriving Show

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
