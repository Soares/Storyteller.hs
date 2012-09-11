{-# LANGUAGE ConstraintKinds #-}
module Storyteller.Renderer
    ( Base
    , Render
    , Renderer(..)
    , render
    , block
    , inline
    , renderWith
    , renderBlock
    , renderInline
    ) where
import Control.Applicative
import Control.Monad.Reader ( ReaderT )
import Control.Monad ( join )
import Control.Monad.IO.Class ( MonadIO )
import Storyteller.Definition
import Storyteller.Util ( (.:) )

type Render r m = ReaderT r m String

type Base m = (Applicative m, Functor m, Monad m, MonadIO m)


class Renderer r where
  control :: Base m => Control -> Render r m

  directive :: Base m => Directive -> String -> String -> Render r m

  formatter :: Base m => Formatter -> String -> Render r m

  operator :: Base m => Operator -> [String] -> Render r m

  paragraph :: Base m => String -> Render r m
  paragraph = pure

  string :: Base m => String -> Render r m
  string = pure

  joinSentences :: Base m => [String] -> Render r m
  joinSentences = pure . unwords . filter (not . null)

  joinParagraphs :: Base m => [String] -> Render r m
  joinParagraphs = pure . unlines


renderInline :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> (Block -> Render r m)
    -> Inline -> Render r m
renderInline _ _ (Str str) = string str
renderInline i _ (Fmt f chunk) = formatter f =<< renderInlines i chunk
renderInline i _ (Opr o chunks) = operator o =<< (mapM . renderInlines) i chunks
renderInline i b (Dir d chunk text) = join $ directive d <$> x <*> y where
    x = renderInlines i chunk
    y = renderBlocks b text


renderBlock :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> Block -> Render r m
renderBlock _ (Ctl ctl) = control ctl
renderBlock i (Par chunk) = paragraph =<< renderInlines i chunk


renderWith :: (Renderer r, Base m)
    => (Block -> Render r m)
    -> File
    -> Render r m
renderWith b = renderBlocks b . paragraphs


renderInlines :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> [Inline]
    -> Render r m
renderInlines = (joinSentences =<<) .: mapM


renderBlocks :: (Renderer r, Base m)
    => (Block -> Render r m)
    -> [Block]
    -> Render r m
renderBlocks = (joinParagraphs =<<) .: mapM


inline :: (Renderer r, Base m) => Inline -> Render r m
inline = renderInline inline block


block :: (Renderer r, Base m) => Block -> Render r m
block = renderBlock inline


render :: (Renderer r, Base m) => File -> Render r m
render = renderWith block
