module SampleSlide where
{-| Presentation tool by elm.
-}

import Kelmote (Page, run)
import Graphics.Element (Element)
import Signal (Signal)
import Html (..)
import Html.Attributes (..)
import List (take)

-- page

header_ txt pageCnt = div [] [ div [id "pageCount"] [text (toString pageCnt)] , h1 [] [text txt] ]
headerSelf = header_ "自己紹介"
headerElm = header_ "Elm?"

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

imgHaskell = img [
               src "img/haskell_logo.png"
             , width 100
             , id "imgHaskell"
             ] []

imgCat = img [
               src "img/cat.jpg"
             , width 100
             , id "imgCat"
             ] []

imgSake = img [
               src "img/sake.jpg"
             , width 100
             , id "imgSake"
             ] []

imgShoge = img [
               src "img/shogi.jpg"
             , width 100
             , id "imgShoge"
             ] []

imgPHP = img [
               src "img/php_logo.jpg"
             , width 100
             , id "imgPHP"
             ] []

imgJS = img [
               src "img/javascript_logo.jpg"
             , width 100
             , id "imgJS"
             ] []

pageList : List Page
pageList = [
   Page (headerSelf 0) <| div [] []
 , Page (headerSelf 1) <| div [] [ ul [] (take 1 selfList) ]
 , Page (headerSelf 2) <| div [] [ ul [] (take 2 selfList) ]
 , Page (headerSelf 3) <| div [] [ ul [] (take 3 selfList) ]
 , Page (headerSelf 4) <| div [] [ ul [] (take 4 selfList)  ]
 , Page (headerSelf 5) <| div [] [ ul [] (take 4 selfList) , imgHaskell, imgCat, imgSake, imgShoge ]
 , Page (headerSelf 6) <| div [] [ ul [] (take 5 selfList) ]
 , Page (headerSelf 7) <| div [] [ ul [] (take 5 selfList), imgPHP, imgJS ]
 , Page (headerSelf 8) <| div [] [ ul [] selfList ]
 , Page (headerElm 9)  <| div [] [ ul [] [liElm1_1] ]
 , Page (headerElm 10) <| div [] [ ul [] [liElm1_2] ]
 , Page (headerElm 11) <| div [] [ ul [] [liElm1_2, liElm2_1] ]
 , Page (headerElm 12) <| div [] [ ul [] [liElm1_2, liElm2_2] ]
 , Page (headerElm 13) <| div [] [ ul [] [liElm1_2, liElm2_2, liElm3_1] ]
 , Page (headerElm 14) <| div [] [ ul [] [liElm1_2, liElm2_2, liElm3_2] ]
 , Page (headerElm 15) <| div [] [
        iframe [
         seamless True
       , src "calcTable.html"
       , height 100
       , width 600
       ] []
     ]
  ]

main : Signal Element
main = run pageList
