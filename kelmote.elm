module Kelmote where
{-| Presentation tool by elm.
-}

-- import Markdown
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

main : Signal Element
main = map2 (\pageCnt dims -> scene (pages pageCnt pageList) dims) pageCount Window.dimensions

scene : Html -> (Int, Int) -> Element
scene p (w, h) = container w h midTop (toElement 800 h p)

pages : Int -> List Html -> Html
pages pageCnt pageList =
    let pageByIdx idx = case get idx (fromList pageList) of
                          Just p -> p
                          Nothing -> div [] []
        attrVisible currentCnt pageCnt = if pageCnt == currentCnt then styleVisible else styleHidden
        hoge pageCnt currentCnt = div [ attrVisible currentCnt pageCnt ] [ header pageCnt, pageByIdx pageCnt ]
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

-- page

header pageCnt = div [] [
          div [id "pageCount"] [text (toString pageCnt)]
        , h1 [] [text "Kelmote"]
        ]


liList = [ liName, liJob, liTwitter, liLike, liHate ]
liName = li [] [text "name: SUZUKI Shinichiro"]
liJob = li [] [text "job: programmer"]
liTwitter = li [] [text "twitter: shin16s"]
liLike = li [] [text "like: Haskell, Cat, Sake, Shogi"]
liHate = li [] [text "hate: PHP, JavaScript,,, >_<"]

imgHaskell = img [
               src "http://upload.wikimedia.org/wikipedia/commons/1/1c/Haskell-Logo.svg"
             , width 100
             , id "imgHaskell"
             ] []

imgCat = img [
               src "http://i.huffpost.com/gen/964776/thumbs/o-CATS-KILL-BILLIONS-facebook.jpg"
             , width 100
             , id "imgCat"
             ] []

pageList =
    let page0 = div [class "pure-g"] [
                    div [classList [("pure-u-1-3", True), ("bRed", True)]] [text "Hoge"]
                  , div [classList [("pure-u-1-3", True), ("bGreen", True)]] [text "Hoge"]
                  , div [classList [("pure-u-1-3", True), ("bYellow", True)]] [text "Hoge"]
                ]
        page1 = div [class "pure-g"] [
                    div [classList [("pure-u-1-2", True), ("bRed", True), ("boxH100", True)]] [text "name: SUZUKI Shinichiro"]
                  , div [classList [("pure-u-1-2", True), ("bGreen", True), ("boxH100", True)]] [text "job: Programmer"]
                ]
--         page1 = div [] [ ul [] (take 1 liList) ]
        page2 = div [] [ ul [] (take 2 liList) ]
        page3 = div [] [ ul [] (take 3 liList) ]
        page4 = div [] [ ul [] (take 4 liList) , imgHaskell, imgCat ]
        page5 = div [] [ ul [] liList ]
    in [page0, page1, page2, page3, page4, page5]
