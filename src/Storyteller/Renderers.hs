module Storyteller.Renderers where
import Control.Applicative
import Data.List ( intercalate )
import Control.Monad.Reader ( asks )
import Storyteller.Definition
import Storyteller.Renderer

data QuickRender = Quick
    { oneLine :: Bool
    } deriving Show

instance Renderer QuickRender where
    joinParagraphs xs = do
        onOne <- asks oneLine
        let combine = if onOne then unwords else unlines
        pure $ combine xs

    control Break = do
        onOne <- asks oneLine
        pure $ if onOne then " \\ " else "\n\n\n"

    control Rule = do
        onOne <- asks oneLine
        pure $ if onOne then " * * * " else "\n\n* * *\n"

    formatter _ str = pure str
    operator _ xs = pure $ intercalate " | " xs
    directive _ _ text = pure text

onelineRenderer = Quick True
simpleRenderer = Quick False

{-
data RenderOptions =
    { space       :: String
    , newline     :: String
    , linebreak   :: String
    , rule        :: String
    , italic      :: (String, String)
    , underline   :: (String, String)
    , bold        :: (String, String)
    , subscript   :: (String, String)
    , superscript :: (String, String)
    , header      :: (String, String)
    }

instance Renderer SimpleRenderer where
    joinSentences xs = do
        sep <- asks spaces
        pure . intercalate sep $ filter (not . null) xs

    joinParagraphs xs = do
        sep <- asks
        -}
