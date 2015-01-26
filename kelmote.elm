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
import Window
import List
import Array (fromList, get)
import Markdown

scene : Html -> (Int, Int) -> Element
scene p (w, h) = container w h midTop (toElement 800 h p)

pages : Int -> List Page -> Html
pages pageCnt pageList =
    let contentList = List.map getContent pageList
        headerList = List.map getHeader pageList
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

getContent : Page -> Html
getContent p = div [] p.content

getHeader : Page -> Html
getHeader p = div [] [ h1 [] [text p.header] ]

fromPageElement : PageElement -> Html
fromPageElement pElem = case pElem of
    Ul lis -> ul [] <| List.map (\lStr -> li [] [text lStr]) lis
    Dl lis -> dl [] <| List.concatMap (\(tStr, dStr) -> [dt [] [text tStr], dd [] [text dStr]]) lis
    P str  -> p [style [ ("position", "absolute")
                       , ("top", "50%")
                       , ("margin-top", "-50px")
                       , ("font-size", "400%")
                       , ("text-align", "center")
                       , ("width", "100%")
                       ]] [text str]

type PageElement = Ul (List String) | Dl (List (String, String))  | P String

type alias Page = {header : String, content : List Html}

{-| Export
-}

run : List Page -> Signal Element
run pageList =
    let view : List Page -> Int -> (Int, Int) -> Element
        view pageList pageCnt dims = scene (pages pageCnt pageList) dims
    in view pageList <~ pageCount ~ Window.dimensions

page : String -> List Html -> Page
page header content = Page header content

ul_ : List String -> Html
ul_  x= Ul x |> fromPageElement
dl_ : List (String, String) -> Html
dl_ x = Dl x |> fromPageElement
p_ : String -> Html
p_ x = P x |> fromPageElement

md_ : String -> Html
md_ markdownStr = fromElement <| Markdown.toElement markdownStr