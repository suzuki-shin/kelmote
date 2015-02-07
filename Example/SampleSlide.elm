module Sample where

import Kelmote (..)
import Signal (Signal)
import Graphics.Element (..)
import List as L
import Color (..)
import Text as T
import Time (Time)

styl1 : T.Style
styl1 = { defaultTextStyle | color <- white, height <- Just 70 }
styl2 : T.Style
styl2 = { defaultTextStyle | color <- yellow }
styl3 : T.Style
styl3 = { defaultTextStyle | color <- lightBlue }
styl4 : T.Style
styl4 = { styl2 | height <- Just 100 }

header2 : Time -> Element
header2 t = h_ styl1 "Elmとは?"
img1 = fittedImage 400 400 "Example/IMG_1448.jpg"
img2 = fittedImage 400 400 "Example/IMG_0638.jpg"
img3 = fittedImage 400 400 "Example/IMG_1127.jpg"
emptyElement : Time -> Element
emptyElement t = empty

page' : Page
page' = page emptyElement emptyElement (bgColor blue)

-- シンプルなテキストだけのページを返す
simple : String -> T.Style -> List String -> Page
simple h cStyle c = { page' | header <- (\_ -> h_ styl1 h) , content <- (\_ -> texts cStyle c) }

v2 : String -> Element -> Element -> Page
v2 h leftE rightE = { page' | header <- (\_ -> h_ styl1 h) , content <- (\t -> v2L leftE rightE) }

h2 : String -> Element -> Element -> Page
h2 h upperE lowerE = { page' | header <- (\_ -> h_ styl1 h) , content <- (\t -> h2L upperE lowerE) }

pageList : List Page
pageList = [
    simple "" styl1 ["Kelmote"]
  , simple "" styl2 ["最近 Elm を触っています"]
  , simple "" styl4 ["Elm?"]
  , simple "Elmとは?" styl1 []
  , v2 "Elmとは?" (texts styl2 ["Functional"]) empty
  , v2 "Elmとは?" (texts styl2 ["Functional"]) (texts styl3 ["Haskellっぽい感じ？"])
  , v2 "Elmとは?" (texts styl2 ["Functional", "Reactive"]) (texts styl3 ["Haskellっぽい感じ？"])
  , v2 "Elmとは?" (texts styl2 ["Functional", "Reactive"]) (texts styl3 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"])
  , v2 "Elmとは?" (texts styl2 ["Functional", "Reactive", "AltJS?"]) (texts styl3 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？"])
  , v2 "Elmとは?" (texts styl2 ["Functional", "Reactive", "AltJS?"]) (texts styl3 ["Haskellっぽい感じ？", "コールバック地獄から抜け出せる？", "ちょっと違うか？HTMLやCSSも出力する"])
  , simple "" styl2 ["そのElmでスライドツール作ってみました"]
  , simple "" { styl2 | height <- Just 80 } ["Kelmote"]
  , simple "" styl2 ["このスライドもそれで作ってます"]
  , simple "" styl2 ["→ でページ送り"]
  , simple "" styl2 ["→ でページ送り", "← で戻り"]
  , simple "" styl2 ["→ でページ送り", "← で戻り", "タッチでもOK"]
  , h2 "" (texts styl2 ["画像入れたり"]) img3
  , simple "" styl3 ["文字色変えたり"]
  , page emptyElement (\t -> blink t (h2L (texts styl2 ["点滅させたり"]) img2)) (bgColor blue)
  , simple "" { styl2 | height <- Just 100 } ["文字サイズ変えたり"]
  , page emptyElement (\t -> scale t (texts styl2 ["ボワンボワンさせたり"])) (bgColor blue)
  , page emptyElement (\t -> texts styl2 ["傾かせたり"] |> rotation 30) (bgColor blue)
  , simple "" styl2 ["背景色変えたり"]
  , page emptyElement
         (\t -> let c1 = texts { styl2 | color <- white } ["背景画像設定したり"]
                in opacity 0.8 (color black c1))
         (bgImage "Example/IMG_0064.JPG")
  , simple "" styl2 ["今のところそんな感じです"]
--   , Page emptyElement (\t -> mdcode) (bgColor blue)
  ]

main : Signal Element
main = run pageList

codeSample = """

```elm:markdown.elm
module Sample where

import Kelmote (..)
import Signal (Signal)
import Graphics.Element (..)
import List as L
import Color (..)
import Text as T
import Time (Time)
import Markdown as MD

pageList : List Page
pageList = [
    simple "" styl1 ["Kelmote"])) (bgColor blue)
  , Page emptyElement (\t -> MD.toElementWith MD.defaultOptions codeSample) (bgColor blue)
  , simple "" styl2 ["最近 Elm を触っています"])) (bgColor blue)
  , simple "" { styl2 | height <- Just 100 } ["Elm?"])) (bgColor blue)
```

"""

mdcode = fromMD codeSample
