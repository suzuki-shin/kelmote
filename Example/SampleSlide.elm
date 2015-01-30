module Sample where

import Signal (Signal)
import Graphics.Element (..)
import Kelmote (..)
import List as L
import Color (..)

header1 = strToHeader "ELM KELMOTE"
element1 = flow down <| L.map strToContent [ "コラボキャンペーンLP," , "we can stack elements" , "on top of other elements." ]
element2 = flow down <| [ fittedImage 300 300 "haskell_logo.png" ]

pageList : List Page
pageList = [
    Page header1 element1 blue
  , Page header1 (v2Page element1 element2) green
  , Page header1 (h2Page element1 element2) lightBlue
  , Page empty element1 brown
  , Page empty (v2Page element1 element2) darkRed
  , Page empty (h2Page element1 element2) lightBlue
  ]

main : Signal Element
main = run pageList
