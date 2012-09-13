{-# LANGUAGE ConstraintKinds #-}
module Storyteller.Renderer
    ( Base
    , Render
    , Renderer(..)
    , apply
    , render
    , block
    , blocks
    , inline
    , inlines
    , simpleRender
    , simpleBlock
    , simpleBlocks
    , simpleInline
    , simpleInlines
    ) where
import Control.Applicative
import Control.Monad.Reader ( ReaderT, runReaderT )
import Control.Monad ( join )
import Storyteller.Definition
import Storyteller.Util ( (.:) )

type Render r m = ReaderT r m String

type Base m = (Applicative m, Functor m, Monad m)


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


apply :: (Renderer r, Base m) => Render r m -> r -> m String
apply = runReaderT


render :: (Renderer r, Base m)
    => (Block -> Render r m)
    -> File
    -> Render r m
render b = blocks b . paragraphs


block :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> Block -> Render r m
block _ (Ctl ctl) = control ctl
block i (Par chunk) = paragraph =<< inlines i chunk


blocks :: (Renderer r, Base m)
    => (Block -> Render r m)
    -> [Block]
    -> Render r m
blocks = (joinParagraphs =<<) .: mapM


inline :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> (Block -> Render r m)
    -> Inline -> Render r m
inline _ _ (Str str) = string str
inline i _ (Fmt f chunk) = formatter f =<< inlines i chunk
inline i _ (Opr o chunks) = operator o =<< (mapM . inlines) i chunks
inline i b (Dir d chunk text) = join $ directive d <$> x <*> y where
    x = inlines i chunk
    y = blocks b text


inlines :: (Renderer r, Base m)
    => (Inline -> Render r m)
    -> [Inline]
    -> Render r m
inlines = (joinSentences =<<) .: mapM


simpleRender :: (Renderer r, Base m) => File -> Render r m
simpleRender = render simpleBlock

simpleBlock :: (Renderer r, Base m) => Block -> Render r m
simpleBlock = block simpleInline

simpleBlocks :: (Renderer r, Base m) => [Block] -> Render r m
simpleBlocks = blocks simpleBlock

simpleInline :: (Renderer r, Base m) => Inline -> Render r m
simpleInline = inline simpleInline simpleBlock

simpleInlines :: (Renderer r, Base m) => [Inline] -> Render r m
simpleInlines = inlines simpleInline
