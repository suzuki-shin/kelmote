module Sample where

import Kelmote (..)
import Signal (Signal)
import Graphics.Element (..)
import List as L
import Color (..)
import Text as T

hStyle : T.Style
hStyle = { defaultTextStyle | color <- white, height <- Just 70 }
cStyle1 : T.Style
cStyle1 = { defaultTextStyle | color <- yellow }
cStyle2 = { defaultTextStyle | color <- lightBlue }

header2 = h_ hStyle "Elmとは?"
element2 = fittedImage 400 400 "Example/IMG_1448.JPG"


pageList : List Page
pageList = [
    Page empty (ps_ hStyle ["Kelmote"]) (BGColor blue)
  , Page empty (ps_ cStyle1 ["最近 Elm を触っています"])  (BGColor blue)
  , Page empty (ps_ { cStyle1 | height <- Just 100 } ["Elm?"]) (BGColor blue)
  , Page header2 empty (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional"]) empty) (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional"]) (ps_ cStyle2 ["Haskellっぽい感じ？"])) (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional", "Reactive"])(ps_ cStyle2 ["Haskellっぽい感じ？"]) ) (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional", "Reactive"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"])) (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional", "Reactive", "AltJS?"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"])) (BGColor blue)
  , Page header2 (v2Page (ps_ cStyle1 ["Functional", "Reactive", "AltJS?"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？", "ちょっと違うか？HTMLやCSSも出力する"])) (BGColor blue)
  , Page empty (ps_ cStyle1 ["そのElmでスライドツール作ってみました"]) (BGColor blue)
  , Page empty (ps_ { cStyle1 | height <- Just 80 } ["Kelmote"]) (BGColor blue)
  , Page empty (ps_ cStyle1 ["このスライドもそれで作ってます"]) (BGColor blue)
  , Page empty (h2Page (ps_ cStyle1 ["画像入れたり"]) element2) (BGColor blue)
  , Page empty (v2Page (ps_ cStyle1 ["レイアウト変えたり"]) element2) (BGColor blue)
  , Page empty (ps_ cStyle2 ["文字色変えたり"]) (BGColor blue)
  , Page empty (ps_ { cStyle2 | height <- Just 100 } ["文字サイズ変えたり"]) (BGColor blue)
  , Page empty rotatedElement (BGColor blue)
  , Page empty (ps_ cStyle1 ["背景色変えたり"]) (BGColor red)
  , Page empty (ps_ { cStyle1 | color <- black } ["背景画像設定したり"]) (BGImage "Example/IMG_0064.JPG")
  , Page empty (ps_ cStyle1 ["今のところそんな感じです"]) (BGColor blue)
  ]

main : Signal Element
main = run pageList


rotatedElement : Element
rotatedElement = ps_ cStyle1 ["傾かせたり"] |> rotation 30
