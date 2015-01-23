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
-- import Kelmote.Page
import Touch
import Time (every, second)
import Graphics.Input.Field as Field

-- main : Signal Element
-- main = let view : List Kelmote.Page.Page -> Int -> (Int, Int) -> Element
--            view pageList pageCnt dims = scene (pages pageCnt pageList) dims
--        in view Kelmote.Page.pageList <~ pageCount ~ Window.dimensions

type alias Page = {content : Html, header : Html}

scene : Html -> (Int, Int) -> Element
scene p (w, h) = container w h midTop (toElement 800 h p)

pages : Int -> List Page -> Html
pages pageCnt pageList =
    let contentList = List.map (\a -> a.content) pageList
        headerList = List.map (\a -> a.header) pageList
        pageByIdx idx = case get idx (fromList contentList) of
                          Just p -> p
                          Nothing -> div [] []
        headerByIdx idx = case get idx (fromList headerList) of
                            Just h -> h
                            Nothing -> div [] []
        attrVisible currentCnt pageCnt = if pageCnt == currentCnt then styleVisible else styleHidden
        pageDiv pageCnt currentCnt = div [ attrVisible currentCnt pageCnt ] [ headerByIdx pageCnt, pageByIdx pageCnt ]
        maxPageCnt = List.length contentList
    in div [] <| List.map (pageDiv pageCnt) [0..maxPageCnt-1]

styleHidden : Attribute
styleHidden = style [ ("display", "none") ]

styleVisible : Attribute
styleVisible = style [ ("display", "block") ]

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

run : List Page -> Signal Element
run pageList =
    let view : List Page -> Int -> (Int, Int) -> Element
        view pageList pageCnt dims = scene (pages pageCnt pageList) dims
    in view pageList <~ pageCount ~ Window.dimensions
