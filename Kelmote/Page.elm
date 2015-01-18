module Kelmote.Page where
{-| Presentation tool by elm.
-}

import Html (..)
import Html.Attributes (..)
import List (take)
import Array (fromList, get)
-- import Html.Lazy (lazy, lazy2)
-- import Graphics.Element (Element, container, midTop)
-- import Keyboard
-- import Signal (Signal, map, map2, (<~), foldp)
-- import Text (asText)
-- import Debug (log)
-- import Mouse
-- import Window
-- import List (take)
-- import Array (fromList, get)

-- page

header pageCnt = div [] [
          div [id "pageCount"] [text (toString pageCnt)]
        , h1 [] [text "自己紹介"]
        ]


liList = [ liName, liJob, liTwitter, liLike, liHate ]
liName = li [] [text "NAME: SUZUKI Shinichiro"]
liJob = li [] [text "JOB: Programmer"]
liTwitter = li [] [text "TWITTER: shin16s"]
liLike = li [] [text "LIKE: Haskell, Cat, Sake, Shogi"]
liHate = li [] [text "HATE: PHP, JavaScript,,, >_<"]

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

imgSake = img [
               src "http://img01.hamazo.tv/usr/i/r/o/irodorihamakita/%E6%97%A5%E6%9C%AC%E9%85%92~1.JPG"
             , width 100
             , id "imgSake"
             ] []

imgShoge = img [
               src "http://screenshots.softonic.jp/jp/scrn/69662000/69662223/%E5%B0%86%E6%A3%8B%E3%82%A2%E3%83%97%E3%83%AA-%E5%B0%86%E7%9A%87-01-546x535.png"
             , width 100
             , id "imgShoge"
             ] []

imgPHP = img [
               src "http://blog.connarti.com/wp-content/uploads/2015/01/php.png"
             , width 100
             , id "imgPHP"
             ] []

imgJS = img [
               src "http://www.bin-co.com/blog/wp-content/uploads/2008/05/javascript_logo.jpg"
             , width 100
             , id "imgJS"
             ] []


pageList =
    let page0 = div [] []
        page1 = div [] [ ul [] (take 1 liList) ]
        page2 = div [] [ ul [] (take 2 liList) ]
        page3 = div [] [ ul [] (take 3 liList) ]
        page4 = div [] [ ul [] (take 4 liList) , imgHaskell, imgCat, imgSake, imgShoge ]
        page5 = div [] [ ul [] liList, imgPHP, imgJS ]
    in [page0, page1, page2, page3, page4, page5]
