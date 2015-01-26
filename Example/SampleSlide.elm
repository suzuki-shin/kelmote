module SampleSlide where
{-| Presentation tool by elm.
-}

import Kelmote (Page, run, ul_, dl_, p_, md_)
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
  , ("twitter: ", "shin16s")
  , ("好き: ", "Haskell, ねこ, お酒, 将棋")
  , ("嫌い: " , "PHP, JavaScript,,, >_<")
  , ("最近興味がある: ", "Elm")
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
   Page "" <| p_ "Elmやってみた"
 , Page "自己紹介" <| []
 , Page "自己紹介" <| dl_ <| take 1 selfList
 , Page "自己紹介" <| dl_ (take 2 selfList)
 , Page "自己紹介" <| dl_ (take 3 selfList)
 , Page "自己紹介" <| dl_ (take 4 selfList) ++ [imgHaskell, imgCat, imgSake, imgShoge]
 , Page "自己紹介" <| dl_ (take 5 selfList) ++ [imgJS, imgPHP]
 , Page "自己紹介" <| dl_ selfList
 , Page "" <| p_ "Elm?"
 , Page "Elm" <| dl_ (take 1 elmList)
 , Page "Elm" <| dl_ (drop 1 elmList |> take 1)
 , Page "Elm" <| dl_ (drop 1 elmList |> take 2)
 , Page "Elm" <| dl_ (drop 1 elmList |> take 3)
 , Page "Elm" <| (dl_ (drop 1 elmList |> take 3)) ++ [iframe [
         seamless True
       , src "calcTable.html"
       , height 95
       , width 800
       ] []]
 , Page "例1. 表計算" <| [iframe [
         seamless True
       , src "calcTable.html"
       , height 95
       , width 800
       ] []]
 , Page "Markdownでも行けるよ" <| [md_ mdSample]

  ]

mdSample = """
# Apple Pie Recipe

  1. Invent the universe.
  2. Bake an apple pie.

"""
