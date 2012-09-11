module Storyteller.Symbols
    ( formatters
    , operators
    , directives
    , sep
    , esc
    , dash
    , notInline
    , notOperator
    ) where
import Storyteller.Definition

sep, esc, dash :: Char
sep = '|'
esc = '\\'
dash = '-'

directives :: [(Char, Char, Directive)]
directives =
    [ ('{', '}', Tag)
    , ('[', ']', Footnote)
    , ('<', '>', Mode)
    ]

formatters :: [(Char, Formatter)]
formatters =
    [ ('/', Italic)
    , ('_', Underline)
    , ('*', Bold)
    , ('^', Superscript)
    , ('~', Subscript)
    , ('#', Comment)
    , ('|', Character)
    , ('=', Header)
    ]

operators :: [(Char, Operator)]
operators =
    [ ('@', Time)
    , ('%', Place)
    , ('`', Code)
    , ('+', Quote)
    , ('$', Math)
    , ('&', Include)
    ]

notInline :: String
notInline = '\n' : esc : ds ++ fs ++ os where
    ds = concatMap (\(o, c, _) -> [o, c]) directives
    fs = map fst formatters
    os = map fst operators

notOperator :: String
notOperator = sep : notInline
