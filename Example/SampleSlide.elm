module SampleSlide where
{-| Presentation tool by elm.
-}

import Kelmote (Page, page, run, ul_, dl_, p_, md_)
import Graphics.Element (Element)
import Signal (Signal)
import Html (..)
import Html.Attributes (..)
import List (take, drop)

main : Signal Element
main = run pageList

-- page

selfList = [
    ("名前: ", "SUZUKI Shinichiro")
  , ("職業: ", "Programmer")
  , ("好き: ", "Haskell, ねこ, お酒, 将棋")
  , ("嫌い: " , "特に無し")
  , ("最近興味がある: ", "elm")
  ]

elmList = [
    ("AltJS.", "")
  , ("AltJS...?", "ではないかも")
  , ("Functional", "参照透明, 型推論, Haskellっぽい構文.")
  , ("Reactive", "コールバック地獄から開放される？")
  ]

imgHaskell = img [ width 100, id "imgHaskell", src "img/haskell_logo.png" ] []
imgCat     = img [ width 100, id "imgCat", src "img/cat.jpg" ] []
imgSake    = img [ width 100, id "imgSake", src "img/sake.jpg" ] []
imgShoge   = img [ width 100, id "imgShoge", src "img/shogi.jpg" ] []
imgPHP     = img [ width 100, id "imgPHP", src "img/php_logo.jpg" ] []
imgJS      = img [ width 100, id "imgJS", src "img/javascript_logo.jpg" ] []

pageList : List Page
pageList = [
   page "" <| [p_ "elmやってみた"]
 , page "自己紹介" <| []
 , page "自己紹介" <| [dl_ <| take 1 selfList]
 , page "自己紹介" <| [dl_ (take 2 selfList)]
 , page "自己紹介" <| [dl_ (take 3 selfList)]
 , page "自己紹介" <| [dl_ (take 3 selfList), imgHaskell, imgCat, imgSake, imgShoge]
 , page "自己紹介" <| [dl_ (take 4 selfList)]
 , page "自己紹介" <| [dl_ (take 4 selfList), imgJS, imgPHP]
 , page "自己紹介" <| [dl_ selfList]
 , page "" <| [p_ "elm?"]
 , page "elm" <| [dl_ (take 1 elmList)]
 , page "elm" <| [dl_ (drop 1 elmList |> take 1)]
 , page "elm" <| [dl_ (drop 1 elmList |> take 2)]
 , page "elm" <| [dl_ (drop 1 elmList |> take 3)]
--  , Page "elm" <| [(dl_ (drop 1 elmList |> take 3))]
--  , Page "例1. 表計算" <| [iframe [
--          seamless True
--        , src "calcTable.html"
--        , height 95
--        , width 800
--        ] []]
 , page "" <| [p_ "そんなelmでプレゼン用スライドツール作ってみた"]
 , page "" <| [p_ "Kelmote"]
 , page "" <| [p_ "Keynote"]
 , page "" <| [p_ "Kelmote"]
 , page "Kelmote" <| [md_ xxx]
 , page "Markdownでも行けるよ" <| [md_ mdSample]

  ]


xxx = """
page関数でページを作って、run関数にページのリストを渡す

     p0 = page "" <| [p_ "そんなelmでプレゼン用スライドツール作ってみた"]
     p1 = page "" <| [p_ "Kelmote"]
     run [p0, p1]

"""

mdSample = """
# Apple Pie Recipe

1. Invent the universe.
2. Bake an apple pie.
3. [elm](http://elm-lang.org/)


    # Apple Pie Recipe
    
    1. Invent the universe.
    2. Bake an apple pie.
    3. [elm](http://elm-lang.org/)
"""
