{-# LANGUAGE ConstraintKinds #-}
module Storyteller.Builder where
import Control.Applicative
import Control.Monad.State ( StateT )
import Control.Monad.IO.Class ( MonadIO )
import Storyteller.Definition

type Base m = (Applicative m, Functor m, Monad m, MonadIO m)

class Builder b where
  string :: Base m => String -> StateT b m ()
  string = const $ pure ()

  control :: Base m => Control -> StateT b m ()
  control = const $ pure ()

  formatter :: Base m => Formatter -> [Inline] -> StateT b m ()
  formatter = const $ const $ pure ()

  operator :: Base m => Operator -> [[Inline]] -> StateT b m ()
  operator = const $ const $ pure ()

  directive :: Base m => Directive -> [Inline] -> [Block] -> StateT b m ()
  directive = const $ const $ const $ pure ()

  paragraph :: Base m => [Inline] -> StateT b m ()
  paragraph = const $ pure ()

inline :: (Builder b, Base m) => Inline -> StateT b m ()
inline (Str str) = string str
inline (Fmt f xs) = formatter f xs
inline (Opr o xs) = operator o xs
inline (Dir d xs ys) = directive d xs ys

block :: (Builder b, Base m) => Block -> StateT b m ()
block (Ctl c) = control c
block (Par p) = mapM_ inline p

build :: (Builder b, Base m) => File -> StateT b m ()
build = mapM_ block . paragraphs
