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
-- import Signal (Signal, map, map2, map5, (<~), foldp, subscribe)
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
main = let view = \pageCnt dims touches input sec
                       -> if | pageCnt <= 7 -> scene (pages pageCnt Kelmote.Page.pageList) dims
                             | pageCnt == 8 -> asText sec
                             | pageCnt == 9 -> sceneTouch dims touches
       in map5 view pageCount
                    Window.dimensions
                    Touch.touches
                    (subscribe content)
                    (every second)

content : Channel Field.Content
content = channel Field.noContent


-- run : List Html -> Signal Element
-- run pageList = map2 (\pageCnt dims -> scene (pages pageCnt pageList) dims) pageCount Window.dimensions

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

sceneTouch : (Int,Int) -> List Touch.Touch -> Element
sceneTouch (w,h) touches =
    let dots = List.map (makeCircle (toFloat w) (toFloat h)) touches
    in 
        layers [ collage w h dots ]


makeCircle : Float -> Float -> Touch.Touch -> Form
makeCircle w h {x,y} =
    circle 60
        |> filled green
        |> move (toFloat x - w/2, h/2 - toFloat y)

