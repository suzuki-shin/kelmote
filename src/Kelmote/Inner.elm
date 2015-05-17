module Kelmote.Inner where

import Graphics.Element exposing (..)
import Graphics.Element as GE exposing (empty, color)
import Text as T exposing (..)
import Color exposing (..)
import List as L exposing (..)
import Window
import Signal exposing (Signal, foldp, merge, (<~), (~))
import Keyboard
import Touch
import Array as A exposing (..)
import Time exposing (Time)

strToContent : T.Style -> String -> Element
strToContent styl = T.fromString >> T.style styl >> centered

strToHeader : T.Style -> String -> Element
strToHeader styl = T.fromString >> T.style styl >> leftAligned

type alias X = { x : Int, y : Int }

pageCount : Signal Int
pageCount =
    let tapSignal : Signal Int
        tapSignal = (\(w,h) {x,y} -> if | x >= round (toFloat w*3/4) -> 1
                                        | x <= round (toFloat w/4) -> -1
                                        | otherwise -> 0 ) <~ Window.dimensions ~ Touch.taps
        arrowSignal : Signal Int
        arrowSignal = (.x) <~ Keyboard.arrows
    in foldp (\x count -> count + x) 0 (merge arrowSignal tapSignal)


pageByIdx : Int -> List Page' -> Page'
pageByIdx idx pList = case A.get idx (A.fromList pList) of
    Just p -> p
    Nothing -> Page' (\t -> GE.empty) (\t -> GE.empty) (BGColor white)

view : List Page' -> (Int, Int) -> Int -> Time -> Element
view pageList (w, h) currentPage sec =
    let page : Page'
        page = pageByIdx currentPage pageList
        header : Time -> Element
        header t = container w (heightOf (page.header t) + 20) midBottom (page.header t)
        content : Time -> Element
        content t = container w h middle (page.content t)
    in layers [ header sec, content sec ]
        |> bg w h page.background

bg : Int -> Int -> Background -> Element -> Element
bg w h b e = case b of
    BGColor c -> GE.color c e
    BGImage s -> layers [fittedImage w h s, e]

type Background = BGColor Color | BGImage String
type alias Page' = { header : Time -> Element, content : Time -> Element, background : Background }
