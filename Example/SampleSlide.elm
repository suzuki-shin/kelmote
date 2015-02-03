module Sample where

import Kelmote (..)
import Signal (Signal)
import Graphics.Element (..)
import List as L
import Color (..)
import Text as T
import Time (Time)

hStyle : T.Style
hStyle = { defaultTextStyle | color <- white, height <- Just 70 }
cStyle1 : T.Style
cStyle1 = { defaultTextStyle | color <- yellow }
cStyle2 = { defaultTextStyle | color <- lightBlue }

emptyElement : Time -> Element
emptyElement t = empty
header2 : Time -> Element
header2 t = h_ hStyle "Elmとは?"
element2 = fittedImage 400 400 "Example/IMG_1448.JPG"


pageList : List Page
pageList = [
    Page emptyElement (\t -> (ps_ hStyle ["Kelmote"])) (BGColor blue)
  , Page emptyElement (\t -> (ps_ cStyle1 ["最近 Elm を触っています"])) (BGColor blue)
  , Page emptyElement (\t -> (ps_ { cStyle1 | height <- Just 100 } ["Elm?"])) (BGColor blue)
  , Page header2      emptyElement (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional"]) empty)) (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional"]) (ps_ cStyle2 ["Haskellっぽい感じ？"]))) (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional", "Reactive"])(ps_ cStyle2 ["Haskellっぽい感じ？"]))) (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional", "Reactive"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"]))) (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional", "Reactive", "AltJS?"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"]))) (BGColor blue)
  , Page header2      (\t -> (v2Page (ps_ cStyle1 ["Functional", "Reactive", "AltJS?"]) (ps_ cStyle2 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？", "ちょっと違うか？HTMLやCSSも出力する"]))) (BGColor blue)
  , Page emptyElement (\t -> (ps_ cStyle1 ["そのElmでスライドツール作ってみました"])) (BGColor blue)
  , Page emptyElement (\t -> (ps_ { cStyle1 | height <- Just 80 } ["Kelmote"])) (BGColor blue)
  , Page emptyElement (\t -> (ps_ cStyle1 ["このスライドもそれで作ってます"])) (BGColor blue)
  , Page emptyElement (\t -> (h2Page (ps_ cStyle1 ["画像入れたり"]) element2)) (BGColor blue)
  , Page emptyElement (\t -> (v2Page (ps_ cStyle1 ["レイアウト変えたり"]) element2)) (BGColor blue)
  , Page emptyElement (\t -> (ps_ cStyle2 ["文字色変えたり"])) (BGColor blue)
  , Page emptyElement (\t -> blink t (ps_ cStyle1 ["点滅させたり"])) (BGColor blue)
  , Page emptyElement (\t -> (ps_ { cStyle2 | height <- Just 100 } ["文字サイズ変えたり"])) (BGColor blue)
  , Page emptyElement (\t -> rotatedElement) (BGColor blue)
  , Page emptyElement (\t -> (ps_ cStyle1 ["背景色変えたり"])) (BGColor red)
  , Page emptyElement (\t -> (ps_ { cStyle1 | color <- black } ["背景画像設定したり"])) (BGImage "Example/IMG_0064.JPG")
  , Page emptyElement (\t -> (ps_ cStyle1 ["今のところそんな感じです"])) (BGColor blue)
  ]

main : Signal Element
main = run pageList


rotatedElement : Element
rotatedElement = ps_ cStyle1 ["傾かせたり"] |> rotation 30
