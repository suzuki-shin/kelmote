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
        , h1 [] [text "Kelmote"]
        ]


liList = [ liName, liJob, liTwitter, liLike, liHate ]
liName = li [] [text "NAME: SUZUKI Shinichiro"]
liJob = li [] [text "JOB: programmer"]
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

pageList =
    let page0 = div [] []
        page1 = div [] [ ul [] (take 1 liList) ]
        page2 = div [] [ ul [] (take 2 liList) ]
        page3 = div [] [ ul [] (take 3 liList) ]
        page4 = div [] [ ul [] (take 4 liList) , imgHaskell, imgCat ]
        page5 = div [] [ ul [] liList ]
    in [page0, page1, page2, page3, page4, page5]
