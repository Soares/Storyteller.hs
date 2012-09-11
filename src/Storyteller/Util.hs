module Storyteller.Util ( (.:) ) where

(.:) :: (x -> c) -> (a -> b -> x) -> a -> b -> c
(.:) = (.) . (.)
