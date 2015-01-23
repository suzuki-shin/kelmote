module Kelmote.Page where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import List (take, map2, length)
import Array (fromList, get)

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


headers = map2 (<|) [
             headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerSelf
           , headerElm
           , headerElm
           , headerElm
           , headerElm
           , headerElm
           , headerElm
           , header_ "例1. 表計算"
          ]
          [0..length(pageList)-1]

pageList = [
     div [] []
   , div [] [ ul [] (take 1 selfList) ]
   , div [] [ ul [] (take 2 selfList) ]
   , div [] [ ul [] (take 3 selfList) ]
   , div [] [ ul [] (take 4 selfList)  ]
   , div [] [ ul [] (take 4 selfList) , imgHaskell, imgCat, imgSake, imgShoge ]
   , div [] [ ul [] (take 5 selfList) ]
   , div [] [ ul [] (take 5 selfList), imgPHP, imgJS ]
   , div [] [ ul [] selfList ]
   , div [] [ ul [] [liElm1_1] ]
   , div [] [ ul [] [liElm1_2] ]
   , div [] [ ul [] [liElm1_2, liElm2_1] ]
   , div [] [ ul [] [liElm1_2, liElm2_2] ]
   , div [] [ ul [] [liElm1_2, liElm2_2, liElm3_1] ]
   , div [] [ ul [] [liElm1_2, liElm2_2, liElm3_2] ]
   , div [] [
        iframe [
         seamless True
       , src "calcTable.html"
       , height 100
       , width 600
       ] []
     ]
  ]
