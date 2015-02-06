module Kelmote.Inner where

import Graphics.Element (..)
import Graphics.Collage as GC
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, (<~), (~), foldp)
import Keyboard
import Array as A
import Time (Time, fps, inSeconds, second)
import Easing as ES
import Markdown as MD
import Html as H
import Html.Attributes as H

strToContent : T.Style -> String -> Element
strToContent styl = T.fromString >> T.style styl >> T.centered

strToHeader : T.Style -> String -> Element
strToHeader styl = T.fromString >> T.style styl >> T.leftAligned

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

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
