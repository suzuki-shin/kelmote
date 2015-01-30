module Kelmote where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import Html.Lazy (lazy, lazy2)
import Graphics.Element (Element, container, midTop, middle, layers, flow, down, color)
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
import Color (..)

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

fromPageElement : PageElement -> Html
fromPageElement pElem = case pElem of
    Ul lis -> ul [] <| List.map (\lStr -> li [] [text lStr]) lis
    Dl lis -> dl [] <| List.concatMap (\(tStr, dStr) -> [dt [] [text tStr], dd [] [text dStr]]) lis
    P str  -> p [style [
                         ("font-size", "400%")
                       , ("text-align", "center")
                       , ("width", "100%")
                       ]] [text str]

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
    in flow down [pageHeader, pageContent] |> color blue

fromPageToContent : Int -> Int -> Page -> List Element
fromPageToContent w h p = List.map (toElement w h) p.content

fromPageToHeader : Int -> Int -> Page -> Element
fromPageToHeader w h p = T.fromString p.header |> T.style T.defaultStyle |> T.centered


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
