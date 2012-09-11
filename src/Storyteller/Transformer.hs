{-# LANGUAGE MultiParamTypeClasses #-}
module Storyteller.Transformer where
import Control.Applicative
import Control.Monad.Reader ( ReaderT, runReaderT )
import Control.Monad.State ( StateT, runStateT )
import Control.Monad.Trans ( lift )
import Storyteller.Definition
import Storyteller.Builder ( Builder )
import qualified Storyteller.Builder as Builder
import Storyteller.Renderer ( Renderer, renderWith, renderBlock, renderInline )
import qualified Storyteller.Renderer as Renderer

type Story r b = ReaderT r (StateT b IO) String

transform :: (Renderer r, Builder b) => File -> Story r b
transform = renderWith block

tell :: (Renderer r, Builder b) => r -> b -> File -> IO (String, b)
tell config init file =
    let maker = runReaderT (transform file) config
    in runStateT maker init

block :: (Renderer r, Builder b) => Block -> Story r b
block b = lift (Builder.block b) *> renderBlock inline b

inline :: (Renderer r, Builder b) => Inline -> Story r b
inline i = lift (Builder.inline i) *> renderInline inline block i
