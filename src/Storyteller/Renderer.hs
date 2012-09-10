module Storyteller.Renderer ( Renderer(..) ) where
import Control.Applicative
import Control.Monad ( mapM )
import Storyteller.Definition

class Renderer r where
    control :: r -> Control -> String
    formatter :: r -> Formatter -> String -> String
    operator :: r -> Operator -> [String] -> String
    directive :: r -> Directive -> String -> String -> String

    inline :: r -> Inline -> String
    inline r (Str str) = str
    inline r (Fmt f i) = formatter r f (unwords $ map (inline r) i)
    inline r (Opr o i) = operator r o (map (unwords . map (inline r)) i)
    inline r (Dir d i b) = directive r d
        (unwords $ map (inline r) i)
        (unlines $ map (block r) b)

    block :: r -> Block -> String
    block r (Ctl c) = control r c
    block r (Par p) = unwords $ map (inline r) p

    render :: r -> File -> String
    render r = unlines . map (block r) . blocks
