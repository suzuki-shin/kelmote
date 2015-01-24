module SampleSlide where
{-| Presentation tool by elm.
-}

import Kelmote (Page, run)
import Graphics.Element (Element)
import Signal (Signal)
import Html (..)
import Html.Attributes (..)
import List (take)

main : Signal Element
main = run pageList

-- page

selfList = [ liName, liJob, liTwitter, liLike, liHate, liRecentInterest ]
liName = li [] [text "名前: ", span [class "fontYellow"] [text "SUZUKI Shinichiro"]]
liJob = li [] [text "職業: ", span [class "fontYellow"] [text "Programmer"]]
liTwitter = li [] [text "twitter: ", span [class "fontYellow"] [text "shin16s"]]
liLike = li [] [text "好き: ", span [class "fontYellow"] [text "Haskell, Cat, Sake, Shogi"]]
liHate = li [] [text "嫌い: ", span [class "fontYellow"] [text "PHP, JavaScript,,, >_<"]]
liRecentInterest = li [] [text "最近興味がある: ", span [class "fontYellow"] [text "Elm"]]

liElm1_1 = li [] [span [class "fontYellow"] [text "AltJS."]]
liElm1_2 = li [] [span [class "fontYellow"] [text "AltJS...?"]]
liElm2_1 = li [] [ div [class "fontYellow"] [text "Functional"] ]
liElm2_2 = li [] [ div [class "fontYellow"] [text "Functional"]
                 , ul [] [
                    li [] [text "Haskellみたいな構文"]
                   ]
                 ]
liElm3_1 = li [] [div [class "fontYellow"] [text "Reactive"]]
liElm3_2 = li [] [div [class "fontYellow"] [text "Reactive"]
                 , ul [] [
                    li [] [text "コールバック地獄から解放される？"]
                   ]
                 ]

imgHaskell = img [ width 100, id "imgHaskell", src "img/haskell_logo.png" ] []
imgCat     = img [ width 100, id "imgCat", src "img/cat.jpg" ] []
imgSake    = img [ width 100, id "imgSake", src "img/sake.jpg" ] []
imgShoge   = img [ width 100, id "imgShoge", src "img/shogi.jpg" ] []
imgPHP     = img [ width 100, id "imgPHP", src "img/php_logo.jpg" ] []
imgJS      = img [ width 100, id "imgJS", src "img/javascript_logo.jpg" ] []

pageList : List Page
pageList = [
   Page "自己紹介" <| []
 , Page "自己紹介" <| [ul [] (take 1 selfList)]
 , Page "自己紹介" <| [ul [] (take 2 selfList)]
 , Page "自己紹介" <| [ul [] (take 3 selfList)]
 , Page "自己紹介" <| [ul [] (take 4 selfList)]
 , Page "自己紹介" <| [ul [] (take 4 selfList) , imgHaskell, imgCat, imgSake, imgShoge]
 , Page "自己紹介" <| [ul [] (take 5 selfList)]
 , Page "自己紹介" <| [ul [] (take 5 selfList), imgPHP, imgJS]
 , Page "自己紹介" <| [ul [] selfList]
 , Page "Elm?" <| [ul [] [liElm1_1]]
 , Page "Elm?" <| [ul [] [liElm1_2]]
 , Page "Elm?" <| [ul [] [liElm1_2, liElm2_1]]
 , Page "Elm?" <| [ul [] [liElm1_2, liElm2_2]]
 , Page "Elm?" <| [ul [] [liElm1_2, liElm2_2, liElm3_1]]
 , Page "Elm?" <| [ul [] [liElm1_2, liElm2_2, liElm3_2]]
 , Page "例1. 表計算" <| [iframe [
         seamless True
       , src "calcTable.html"
       , height 100
       , width 600
       ] []]
  ]
