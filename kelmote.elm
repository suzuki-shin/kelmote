module Kelmote where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import Html.Lazy (lazy, lazy2)
import Graphics.Element (Element, container, midTop, layers)
import Graphics.Collage (collage, circle, filled, move, Form)
import Color (..)
import Keyboard
import Signal (..)
import Text (asText)
import Debug (log)
import Mouse
import Window
import List
import Array (fromList, get)
import Kelmote.Page
import Touch
import Time (every, second)
import Graphics.Input.Field as Field

main : Signal Element
main = let view : List Html -> Int -> (Int, Int) -> Element
           view pageList pageCnt dims = scene (pages pageCnt pageList) dims
       in view Kelmote.Page.pageList <~ pageCount ~ Window.dimensions

scene : Html -> (Int, Int) -> Element
scene p (w, h) = container w h midTop (toElement 800 h p)

pages : Int -> List Html -> Html
pages pageCnt pageList =
    let pageByIdx idx = case get idx (fromList pageList) of
                          Just p -> p
                          Nothing -> div [] []
        headerByIdx idx = case get idx (fromList Kelmote.Page.headers) of
                            Just h -> h
                            Nothing -> div [] []
        attrVisible currentCnt pageCnt = if pageCnt == currentCnt then styleVisible else styleHidden
        pageDiv pageCnt currentCnt = div [ attrVisible currentCnt pageCnt ] [ headerByIdx pageCnt, pageByIdx pageCnt ]
        maxPageCnt = List.length pageList
    in div [] <| List.map (pageDiv pageCnt) [0..maxPageCnt-1]

styleHidden : Attribute
styleHidden = style [ ("display", "none") ]

styleVisible : Attribute
styleVisible = style [ ("display", "block") ]

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows
