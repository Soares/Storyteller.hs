module Storyteller.Transformer where
import Control.Applicative
import Control.Monad ( mapM )
import Control.Monad.State ( StateT )
import Storyteller.Definition
import Storyteller.Renderer ( Renderer )

class Renderer t => Transformer t where
    control :: Control -> StateT t IO String
    format :: Formatter -> [Inline] -> StateT t IO String
    operate :: Operator -> [[Inline]] -> StateT t IO String
    direct :: Directive -> [Inline] -> [Block] -> StateT t IO String

    inline :: Inline -> StateT t IO String
    inline (Str str) = pure str
    inline (Fmt f xs) = format f xs
    inline (Opr o xs) = operate o xs
    inline (Dir d xs ys) = direct d xs ys

    block :: Block -> StateT t IO String
    block (Ctl c) = control c
    block (Par p) = unwords <$> mapM inline p

    transform :: File -> StateT t IO String
    transform = fmap unlines . mapM block . blocks
