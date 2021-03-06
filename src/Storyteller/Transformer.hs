{-# LANGUAGE MultiParamTypeClasses #-}
module Storyteller.Transformer where
import Control.Applicative
import Control.Monad.Reader ( ReaderT, runReaderT )
import Control.Monad.State ( StateT, runStateT )
import Control.Monad.Trans ( lift )
import Storyteller.Definition
import Storyteller.Builder ( Builder )
import qualified Storyteller.Builder as Builder
import Storyteller.Renderer ( Renderer )
import qualified Storyteller.Renderer as Renderer

type Story r b = ReaderT r (StateT b IO) String

tell :: (Renderer r, Builder b) => r -> File -> IO (String, b)
tell conf file = runStateT (runReaderT (transform file) conf) Builder.new

transform :: (Renderer r, Builder b) => File -> Story r b
transform = Renderer.render block

block :: (Renderer r, Builder b) => Block -> Story r b
block b = lift (Builder.block b) *> Renderer.block inline b

inline :: (Renderer r, Builder b) => Inline -> Story r b
inline i = lift (Builder.inline i) *> Renderer.inline inline block i
