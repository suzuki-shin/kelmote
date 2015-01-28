module Kelmote where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import Html.Lazy (lazy, lazy2)
import Graphics.Element (Element, container, midTop, middle, layers, flow, down)
import Graphics.Collage (collage, circle, filled, move, Form)
import Color (..)
import Keyboard
import Signal (..)
import Text as T
import Debug (log)
import Window
import List
import List ((::))
import Array (fromList, get)
import Markdown

scene : (Int -> Int -> Html) -> (Int, Int) -> Element
scene p (w, h) = container w h middle (toElement 800 h (p w h))

pages : Int -> List Page -> Int -> Int -> Html
pages pageCnt pageList w h =
    let contentList = List.map getContent pageList
        headerList = List.map getHeader pageList
        pageByIdx idx = case get idx (fromList contentList) of
                          Just pg -> [pg]
                          Nothing -> []
        headerByIdx idx = case get idx (fromList headerList) of
                            Just hdr -> [hdr]
                            Nothing -> []
    in div [] <| headerByIdx pageCnt ++ pageByIdx pageCnt
--         pageDiv pageCnt = div [] <| headerByIdx pageCnt ++ pageByIdx pageCnt
--     in pageDiv pageCnt

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
    P str  -> p [style [
                         ("font-size", "400%")
                       , ("text-align", "center")
                       , ("width", "100%")
                       ]] [text str]
--     P str  -> p [style [ ("position", "absolute")
--                        , ("top", "50%")
--                        , ("margin-top", "-50px")
--                        , ("font-size", "400%")
--                        , ("text-align", "center")
--                        , ("width", "100%")
--                        ]] [text str]

type PageElement = Ul (List String) | Dl (List (String, String))  | P String

type alias Page = {header : String, content : List Html}

view : List Page -> Int -> (Int, Int) -> Element
view pageList currentPage (w, h) =
    let page : Page
        page = case get currentPage (fromList pageList) of
                     Just pg -> pg
                     Nothing -> Page "" []
        pageContent : Element
        pageContent = container w h middle <| flow down <| fromPageToContent w h page
        pageHeader : Element
        pageHeader = fromPageToHeader w h page
    in flow down [pageHeader, pageContent]

fromPageToContent : Int -> Int -> Page -> List Element
fromPageToContent w h p = List.map (toElement w h) p.content

fromPageToHeader : Int -> Int -> Page -> Element
fromPageToHeader w h p = T.fromString p.header
                       |> T.style T.defaultStyle
                       |> T.centered


{-| Export
-}

run : List Page -> Signal Element
run pageList = view pageList <~ pageCount ~ Window.dimensions

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
