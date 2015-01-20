module Kelmote.Page where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import List (take)
import Array (fromList, get)

-- page

headerSelf pageCnt = div [] [
          div [id "pageCount"] [text (toString pageCnt)]
        , h1 [] [text "自己紹介"]
        ]

headerElm pageCnt = div [] [
          div [id "pageCount"] [text (toString pageCnt)]
        , h1 [] [text "Elm?"]
        ]

headers = [
     headerSelf 0
   , headerSelf 1
   , headerSelf 2
   , headerSelf 3
   , headerSelf 4
   , headerSelf 5
   , headerSelf 6
   , headerSelf 7
   , headerSelf 8
   , headerElm 9
  ]


liList = [ liName, liJob, liTwitter, liLike, liHate, liRecentInterest ]
liName = li [] [text "名前: ", span [class "fontYellow"] [text "SUZUKI Shinichiro"]]
liJob = li [] [text "職業: ", span [class "fontYellow"] [text "Programmer"]]
liTwitter = li [] [text "twitter: ", span [class "fontYellow"] [text "shin16s"]]
liLike = li [] [text "好き: ", span [class "fontYellow"] [text "Haskell, Cat, Sake, Shogi"]]
liHate = li [] [text "嫌い: ", span [class "fontYellow"] [text "PHP, JavaScript,,, >_<"]]
liRecentInterest = li [] [text "最近興味がある: ", span [class "fontYellow"] [text "Elm"]]

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


pageList = [
     div [] []
   , div [] [ ul [] (take 1 liList) ]
   , div [] [ ul [] (take 2 liList) ]
   , div [] [ ul [] (take 3 liList) ]
   , div [] [ ul [] (take 4 liList)  ]
   , div [] [ ul [] (take 4 liList) , imgHaskell, imgCat, imgSake, imgShoge ]
   , div [] [ ul [] (take 5 liList) ]
   , div [] [ ul [] (take 5 liList), imgPHP, imgJS ]
   , div [] [ ul [] liList ]
   , div [] [ text "Elm..." ]
  ]

