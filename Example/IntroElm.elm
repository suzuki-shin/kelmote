import Kelmote exposing (..)
import Color exposing (..)
import Graphics.Element as GE
import Graphics.Collage as GC
import Time
import Text as T
import Debug

main =
  run pages


headerStyle : T.Style
headerStyle =
  { defaultHeaderTextStyle
  | color <- lightBlue
  , bold <- True
  }


bodyStyle : T.Style
bodyStyle =
  { defaultBodyTextStyle
  | color <- white
  , bold <- True
  }


pageStyle0 : Style
pageStyle0 =
  { defaultPageStyle
  | headerText <- { headerStyle | color <- lightBrown }
  , bodyText <- { bodyStyle | color <- white }
  , background <- BgColor brown
  }


pageStyle1 : Style
pageStyle1 =
  { defaultPageStyle
  | headerText <- headerStyle
  , bodyText <- bodyStyle
  , background <- BgColor blue
  }


pageStyle2 : Style
pageStyle2 =
  { pageStyle1
  | background <- BgColor darkGreen
  , headerText <- { headerStyle | color <- lightGreen }
  }


pageStyle3 : Style
pageStyle3 =
  { pageStyle1
  | background <- BgColor darkOrange
  , headerText <- { headerStyle | color <- lightOrange }
  }


pageStyle4 : Style
pageStyle4 =
  { pageStyle1
  | background <- BgColor darkYellow
  , headerText <- { headerStyle | color <- lightYellow }
  }


pageStyle5 : Style
pageStyle5 =
  { pageStyle1
  | background <- BgColor black
  }


pageStyle6 : Style
pageStyle6 =
  { pageStyle1
  | background <- BgImage "Example/fog_city.jpg"
  }


pages : List Page
pages =
  [
    simple
    { pageStyle0
    | bodyText <-
      { bodyStyle
      | height <- Just 100
      , color <- white
      }
    , background <- BgImage "Example/flickr_dog.jpg"
    }
    ""
    (Text_ [
      "Introduction to Elm"
     ])
  , simple
    pageStyle0
    ""
    (Text_ [
      "とりあえず自己紹介"
     ])
  , horizontal
    pageStyle0
    ""
    (Text_ [
      "Twitter: shin16s"
     ])
    (Image_ [
      (1000, 400, "Example/twitter_img.png")
     ])
  , simple
    pageStyle0
    ""
    (Text_ [
      "Twitter: shin16s"
     ,"Job: Programmer"
     ,"Like: Haskell, Elm, 将棋, ねこ, お酒"
     ,"目黒もくもく会主催してます"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "JavaScriptが怖い"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "JavaScriptが怖い"
     ,"自由すぎる"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "JavaScriptが怖い"
     ,"自由すぎる"
     ,"BK多過ぎる"
     ,"http://nmi.jp/archives/488"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "AltJSをつまみ食い"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "2014年のElmアドベントカレンダー"
     ,"http://qiita.com/advent-calendar/2014/elm"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "2014年のElmアドベントカレンダー"
     ,"（僕の中で）はやりのHaskell系AltJS"
     ])
  , simple
    pageStyle1
    "Elmと私"
    (Text_ [
      "2014年のElmアドベントカレンダー"
     ,"（僕の中で）はやりのHaskell系AltJS"
     ,"いくつかプログラムを書いてみる"
     ])
  , simple
    pageStyle2
    "Elmと私"
    (Text_ [
      "1. スライド作成ツール"
     ])
  , simple
    pageStyle2
    "Elmと私"
    (Text_ [
      "1. スライド作成ツール"
     ,"まともに作った初めてのElmアプリ"
     ])
  , simple
    pageStyle2
    "Elmと私"
    (Text_ [
      "1. スライド作成ツール"
     ,"まともに作った初めてのElmアプリ"
     ,"このスライドもそれで作ってます"
     ])
  , horizontal
    pageStyle2
    "Elmと私"
    (Text_ [
      "むだなエフェクトも実装"
     ] ~@ moveEffectFunc)
    (Image_ [
      (600, 400, "Example/natsume.JPG")
     ] ~@ zoomEffectFunc)
  , simple
    pageStyle3
    "Elmと私"
    (Text_ [
      "2. どうぶつしょうぎ"
     ])
  , simple
    pageStyle3
    "Elmと私"
    (Text_ [
      "2. どうぶつしょうぎ"
     ,"バックエンドはmilkcocoaで通信対戦可能"
     ,"http://suzuki-shin.github.io/doubutsuShogi/?xxx"
     ])
  , simple
    { pageStyle1
    | bodyText <-
      { bodyStyle
      | height <- Just 100
      , color <- white
      }
    , background <- BgImage "Example/fog_city.jpg"
    }
    ""
    (Text_ [
      "ようやく本題"
     ])
  , simple
    pageStyle1
    "What is Elm?"
    (Text_ [
      ""
     ])
  , simple
    pageStyle1
    "What is Elm?"
    (Text_ [
      "AltJS"
     ])
  , simple
    pageStyle1
    "AltJS"
    (Text_ [
      "HTMLとJSとCSSを生成"
     ])
  , simple
    pageStyle1
    "AltJS"
    (Text_ [
      "HTMLとJSとCSSを生成"
     ,"Virtual DOM"
     ])
  , simple
    pageStyle1
    "AltJS"
    (Text_ [
      "HTMLとJSとCSSを生成"
     ,"Virtual DOM"
     ,"FRP"
     ])
  , simple
    { pageStyle1
    | bodyText <-
      { bodyStyle
      | height <-
        Just 30
      }
    }
    "Virtual DOM?"
    (Text_ [
      "http://qiita.com/mizchi/items/4d25bc26def1719d52e6"
     ,"http://postd.cc/blazing-fast-html-virtual-dom-in-elm/"
     ])
  , simple
    pageStyle2
    "FRP?"
    (Text_ [
      "Functional Reactive Programming"
     ])
  , simple
    pageStyle2
    "FRP?"
    (Text_ [
      "Functional Reactive Programming"
     ,"時間変化する値がファーストクラス"
     ])
  , simple
    pageStyle2
    "FRP?"
    (Text_ [
      "Functional Reactive Programming"
     ,"時間変化する値がファーストクラス"
     ,"ElmではSignalという型で表現"
     ])
  , simple
    pageStyle2
    "FRP?"
    (Text_ [
      "Functional Reactive Programming"
     ,"時間変化する値がファーストクラス"
     ,"ElmではSignalという型で表現"
     ,"Bye bye callback hell?"
     ])
  , simple
    pageStyle3
    "What is Elm?"
    (Text_ [
      "関数型言語"
     ])
  , simple
    pageStyle3
    "What is Elm?"
    (Text_ [
      "静的型付け関数型言語"
     ])
  , simple
    pageStyle3
    "What is Elm?"
    (Text_ [
      "静的型付け関数型言語"
     ,"型推論"
     ])
  , simple
    pageStyle3
    "What is Elm?"
    (Text_ [
      "静的型付け関数型言語"
     ,"型推論"
     ,"Haskell like Syntax"
     ])
  , vertical
    pageStyle3
    "Haskell like Syntax"
    (Text_ [
      "Hello World"
     ])
    (Code_ helloWorld)
  , simple
    pageStyle4
    "What is Elm?"
    (Text_ [
      "tool類の完成度が高い"
     ,"コンパイラはもちろん"
     ,"パッケージマネージャ"
     ,"デバッガ"
     ])
  , simple
    pageStyle2
    "What is Elm?"
    (Text_ [
      "公式サイトが充実"
     ,"http://elm-lang.org/"
     ])
  ]


helloWorld : String
helloWorld = """
```haskell
import Html exposing (span, text)
import Html.Attributes exposing (class)


main =
  span [class "welcome-message"] [text "Hello, World!"]
```
"""


swingEffectFunc : Time.Time -> GE.Element -> GE.Element
swingEffectFunc t e =
  let
    w = GE.widthOf e
    h = (toFloat w) * (cos (degrees 20)) * (toFloat (GE.heightOf e)) |> ceiling
  in
    GC.collage w h <| [GC.rotate (sin (degrees (30 * (Time.inSeconds t)))) (GC.toForm e)]


zoomEffectFunc : Time.Time -> GE.Element -> GE.Element
zoomEffectFunc t e =
  let
    x = (sin (degrees (30 * (Time.inSeconds t)))) * 0.5 + 1.0
    w = x * (toFloat (GE.widthOf e)) |> ceiling
    h = x * (toFloat (GE.heightOf e)) |> ceiling
  in
    GC.collage w h <| [GC.scale x (GC.toForm e)]


moveEffectFunc : Time.Time -> GE.Element -> GE.Element
moveEffectFunc t e =
  let
    x = (sin (degrees (30 * (Time.inSeconds t)))) * 1000.0
    w = toFloat (GE.widthOf e) |> ceiling
    h = toFloat (GE.heightOf e) |> ceiling
  in
    GC.collage w h <| [GC.moveX (Debug.log "x" x) (GC.toForm e)]

