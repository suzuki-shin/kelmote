module Kelmote where

import Graphics.Element (..)
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, (<~), (~), foldp)
import Keyboard
import Array as A
import Time (Time, fps, inSeconds)

defaultTextStyle : T.Style
defaultTextStyle = {
    typeface = [ "Lucida Console", "monospace" ]
  , height   = Just 50
  , color    = white
  , bold     = True
  , italic   = False
  , line     = Nothing
  }

strToContent : String -> Element
strToContent s = T.fromString s |> T.style { defaultTextStyle | color <- yellow } |> T.centered

strToHeader : String -> Element
strToHeader s = T.fromString s |> T.style { defaultTextStyle | height <- Just 70 } |> T.leftAligned

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

pageByIdx : Int -> List Page -> Page
pageByIdx idx pList = case A.get idx (A.fromList pList) of
                        Just p -> p
                        Nothing -> Page empty empty white

view : List Page -> (Int, Int) -> Int -> Time -> Element
view pageList (w, h) currentPage sec =
    let page = pageByIdx currentPage pageList
        header = container w (heightOf page.header + 20) midBottom page.header
        content = container w h middle page.content
    in color page.backGroundColor <| layers [ header, content ]
--     in color page.backGroundColor <| container w h middle <| flow down [ T.asText (inSeconds sec), page.content]
--     in color page.backGroundColor <| container w h middle <| opacity (inSeconds sec) <| page.content

v2Page : Element -> Element -> Element
v2Page leftE rightE = flow left [ leftE , spacer 30 30, rightE ]

h2Page : Element -> Element -> Element
h2Page upperE lowerE = flow down [ upperE , spacer 30 30, lowerE ]

type alias Page = { header : Element, content : Element, backGroundColor : Color }

run : List Page -> Signal Element
run pageList = view pageList <~ Window.dimensions
                              ~ pageCount
                              ~ fps 3
