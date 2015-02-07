module Kelmote where

import Graphics.Element (..)
import Graphics.Collage as GC
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, (<~), (~), foldp)
import Keyboard
import Touch
import Time (Time, fps, inSeconds, second)
import Easing as ES
import Markdown as MD
import Html as H
import Html.Attributes as H
import Kelmote.Inner as Inner

{- Export -}

h_ : T.Style -> String -> Element
h_ = Inner.strToHeader

ps_ : T.Style -> List String -> Element
ps_ styl = L.map (Inner.strToContent styl) >> flow down

v2Page : Element -> Element -> Element
v2Page leftE rightE = flow right [ leftE , spacer 30 30, rightE ]

h2Page : Element -> Element -> Element
h2Page upperE lowerE = flow down [ upperE , spacer 30 30, lowerE ]

rotation : Float -> Element -> Element
rotation angl e =
    let h = round ((toFloat (widthOf e)) * (sin (degrees angl))) + heightOf e
        w = widthOf e
    in GC.collage w h [(GC.rotate (degrees angl) (GC.toForm e))]

type alias Page = Inner.Page'
page h c b = Inner.Page' h c b

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

-- hoge : Signal Int
-- hoge = Inner.pageCount Keyboard.arrows Touch.taps
-- hoge = Inner.pageCount <~ Keyboard.arrows ~ Touch.taps

run : List Page -> Signal Element
run pageList = Inner.view pageList <~ Window.dimensions
                                    ~ Inner.pageCount
                                    ~ foldp (+) 0 (fps 5)

rotateEasing : Time -> Float
rotateEasing = ES.cycle (ES.ease ES.linear ES.float 0 9) second

blink : Time -> Element -> Element
blink t e = let o = (toFloat ((round (rotateEasing t)) % 10)) / 10
            in opacity o e

scale : Time -> Element -> Element
scale t e =
    let x = ((toFloat ((round (rotateEasing t)) % 10)) / 10) + 1
    in GC.collage (ceiling (toFloat ((widthOf e)) * x)) (ceiling ((toFloat (heightOf e)) * x)) [GC.scale x (GC.toForm e)]

fromMD : String -> Element
fromMD mdStr = H.div
               [H.style [
                      ("backgroundColor", "black")
                     ,("color", "green")
                     ,("padding", "5px")
                     ]]
               [ MD.toHtmlWith MD.defaultOptions mdStr ]
                   |> H.toElement 900 500
