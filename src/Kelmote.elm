module Kelmote where

import Graphics.Element exposing (..)
import Graphics.Collage as GC exposing (..)
import Text as T exposing (..)
import Color exposing (..)
import List as L exposing (..)
import Window
import Signal exposing (Signal, (<~), (~), foldp)
import Keyboard
import Touch
import Time exposing (Time, fps, inSeconds, second)
-- import Easing as ES exposing (..)
import Markdown as MD exposing (..)
import Html as H exposing (..)
import Html.Attributes as H exposing (..)
import Kelmote.Inner as Inner exposing (..)

{- Export -}

h_ : T.Style -> String -> Element
h_ = Inner.strToHeader

texts : T.Style -> List String -> Element
texts styl = L.map (Inner.strToContent styl) >> flow down

-- 横2分割レイアウト
v2L : Element -> Element -> Element
v2L leftE rightE = flow right [ leftE , spacer 30 30, rightE ]

-- 縦2分割レイアウト
h2L : Element -> Element -> Element
h2L upperE lowerE = flow down [ upperE , spacer 30 30, lowerE ]

rotation : Float -> Element -> Element
rotation angl e =
    let h = round ((toFloat (widthOf e)) * (sin (degrees angl))) + heightOf e
        w = widthOf e
    in GC.collage w h [(GC.rotate (degrees angl) (GC.toForm e))]

type alias Page = Inner.Page'

page : (Time -> Element) -> (Time -> Element) -> (Inner.Background) -> Page
page header content background = Inner.Page' header content background

bgColor : Color -> Inner.Background
bgColor = Inner.BGColor
bgImage : String -> Inner.Background
bgImage = Inner.BGImage

defaultTextStyle : T.Style
defaultTextStyle = {
    typeface = [ "Lucida Console", "monospace" ]
  , height   = Just 50
  , color    = black
  , bold     = True
  , italic   = False
  , line     = Nothing
  }

run : List Page -> Signal Element
run pageList = Inner.view pageList <~ Window.dimensions
                                    ~ Inner.pageCount
                                    ~ foldp (+) 0 (fps 5)

blink : Time -> Element -> Element
blink t e = let o = (toFloat ((round t) % 10)) / 10
            in opacity o e

scale : Time -> Element -> Element
scale t e =
    let x = ((toFloat ((round t) % 10)) / 10) + 1
    in GC.collage (ceiling (toFloat ((widthOf e)) * x)) (ceiling ((toFloat (heightOf e)) * x)) [GC.scale x (GC.toForm e)]

swing : Time -> Element -> Element
swing t e =
    let h = round ((toFloat (widthOf e)) * 2.0) + heightOf e
        w = widthOf e
    in GC.collage w h [(GC.rotate (sin (t/250) * 0.2) (GC.toForm e))]

fromMD : String -> Element
fromMD mdStr = H.div
               [H.style [
                      ("backgroundColor", "#fdf6e3")
                     ,("padding", "5px")
                     ]]
               [ MD.toHtmlWith MD.defaultOptions mdStr ]
                   |> H.toElement 900 500
