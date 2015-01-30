module Sample where

import Kelmote (..)
import Signal (Signal)
import Graphics.Element (..)
import List as L
import Color (..)
import Text as T

hStyle : T.Style
hStyle = { defaultTextStyle | color <- white, height <- Just 70 }
cStyle : T.Style
cStyle = { defaultTextStyle | color <- yellow }

header1 = h_ hStyle "ELM KELMOTE"
element1 = ps_ cStyle [ "コラボキャンペーンLP," , "we can stack elements" , "on top of other elements." ]
element2 = fittedImage 300 300 "haskell_logo.png"
element3 = ps_ cStyle ["** Q1: やる気がでないのは今日に入ってからですか？数日やる気がでない状態が続いているのですか？それとも今日に入ってからかですか？** Q2: 最近なにか新しい情報が明らかになりましたか？たとえば計画段階では知らなかった事実が明らかになって、今までやってきた作業が無駄になったとか。何らかの情報が最近明らかになりましたか？はい→状況が変わったのであれば、計画の通りに実行することが必要とは限りません。状況の変化に合わせて計画を変更したり中止したりしてはいけないのですか？利害関係者と相談してみましょう。"]
element4 = ps_ cStyle [ "1. I can't do it," , "2. we can stack elements" , "3. on top of other elements." ]


pageList : List Page
pageList = [
    Page header1 element1 blue
  , Page header1 (v2Page element1 element2) green
  , Page header1 (h2Page element1 element2) lightBlue
  , Page empty element3 brown
  , Page empty (v2Page element4 element2) darkRed
  , Page empty (h2Page element1 element2) lightBlue
  ]

main : Signal Element
main = run pageList
