module Kelmote where
{- Export
   (
    Page
  , run
  , h_
  , c_
  , v2Page
  , h2Page
  , defaultTextStyle
  , rotation
  )
-}

import Graphics.Element (..)
import Graphics.Collage as GC
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, (<~), (~), foldp)
import Keyboard
import Array as A
import Time (Time, fps, inSeconds)

strToContent : T.Style -> String -> Element
strToContent styl s = T.fromString s |> T.style styl |> T.centered

strToHeader : T.Style -> String -> Element
strToHeader styl s = T.fromString s |> T.style styl |> T.leftAligned

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

pageByIdx : Int -> List Page -> Page
pageByIdx idx pList = case A.get idx (A.fromList pList) of
                        Just p -> p
                        Nothing -> Page empty empty (BGColor white)

view : List Page -> (Int, Int) -> Int -> Time -> Element
view pageList (w, h) currentPage sec =
    let page = pageByIdx currentPage pageList
        header = container w (heightOf page.header + 20) midBottom page.header
        content = container w h middle page.content
    in bg w h page.backGround <| layers [ header, content ]

bg : Int -> Int -> Background -> Element -> Element
bg w h b e = case b of
         BGColor c -> color c e
         BGImage s -> layers [fittedImage w h s, e]

type Background = BGColor Color | BGImage String

{- Export -}

h_ : T.Style -> String -> Element
h_ = strToHeader

ps_ : T.Style -> List String -> Element
ps_ styl ss = flow down <| L.map (strToContent styl) ss

v2Page : Element -> Element -> Element
v2Page leftE rightE = flow right [ leftE , spacer 30 30, rightE ]

h2Page : Element -> Element -> Element
h2Page upperE lowerE = flow down [ upperE , spacer 30 30, lowerE ]

rotation : Float -> Element -> Element
rotation angl e =
    let h = round ((toFloat (widthOf e)) * (sin (degrees angl))) + heightOf e
        w = widthOf e
    in GC.collage w h [(GC.rotate (degrees angl) (GC.toForm e))]

type alias Page = { header : Element, content : Element, backGround : Background }

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
run pageList = view pageList <~ Window.dimensions
                              ~ pageCount
                              ~ fps 3
