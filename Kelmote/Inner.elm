module Kelmote.Inner where

import Graphics.Element (..)
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, foldp, merge, (<~), (~))
import Keyboard
import Touch
import Array as A
import Time (Time)

strToContent : T.Style -> String -> Element
strToContent styl = T.fromString >> T.style styl >> T.centered

strToHeader : T.Style -> String -> Element
strToHeader styl = T.fromString >> T.style styl >> T.leftAligned

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
    Nothing -> Page' (\t -> empty) (\t -> empty) (BGColor white)

view : List Page' -> (Int, Int) -> Int -> Time -> Element
view pageList (w, h) currentPage sec =
    let page = pageByIdx currentPage pageList
        header t = container w (heightOf (page.header t) + 20) midBottom (page.header t)
        content t = container w h middle (page.content t)
    in layers [ header sec, content sec ]
        |> bg w h page.backGround

bg : Int -> Int -> Background -> Element -> Element
bg w h b e = case b of
    BGColor c -> color c e
    BGImage s -> layers [fittedImage w h s, e]

type Background = BGColor Color | BGImage String
type alias Page' = { header : Time -> Element, content : Time -> Element, backGround : Background }
