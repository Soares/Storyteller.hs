module Storyteller.Symbols
    ( formatters
    , operators
    , directives
    , sep
    , esc
    , dash
    , star
    , notInline
    , notOperator
    ) where
import Storyteller.Definition

sep, esc, dash, star :: Char
sep = '|'
esc = '\\'
dash = '-'
star = '*'

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
    , ('=', Header)
    ]

operators :: [(Char, Operator)]
operators =
    [ ('@', Time)
    , ('|', Character)
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
