module Kelmote where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import Html.Lazy (lazy, lazy2)
import Graphics.Element (Element, container, midTop)
import Keyboard
import Signal (Signal, map, map2, (<~), foldp)
import Text (asText)
import Debug (log)
import Mouse
import Window
import List (take)
import Array (fromList, get)
import Kelmote.Page

main : Signal Element
main = map2 (\pageCnt dims -> scene (pages pageCnt Kelmote.Page.pageList) dims) pageCount Window.dimensions

-- run : List Html -> Signal Element
-- run pageList = map2 (\pageCnt dims -> scene (pages pageCnt pageList) dims) pageCount Window.dimensions

scene : Html -> (Int, Int) -> Element
scene p (w, h) = container w h midTop (toElement 800 h p)

pages : Int -> List Html -> Html
pages pageCnt pageList =
    let pageByIdx idx = case get idx (fromList pageList) of
                          Just p -> p
                          Nothing -> div [] []
        attrVisible currentCnt pageCnt = if pageCnt == currentCnt then styleVisible else styleHidden
        hoge pageCnt currentCnt = div [ attrVisible currentCnt pageCnt ] [ Kelmote.Page.header pageCnt, pageByIdx pageCnt ]
    in div [] [
                 hoge pageCnt 0
               , hoge pageCnt 1
               , hoge pageCnt 2
               , hoge pageCnt 3
               , hoge pageCnt 4
               , hoge pageCnt 5
             ]

styleHidden : Attribute
styleHidden = style [ ("display", "none") ]

styleVisible : Attribute
styleVisible = style [ ("display", "block") ]

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows
