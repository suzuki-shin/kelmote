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
    | background <- BgColor darkYellow
    , headerText <- { headerStyle | color <- lightYellow }
  }


pageStyle4 : Style
pageStyle4 =
  { pageStyle1
    | background <- BgColor darkOrange
    , headerText <- { headerStyle | color <- lightOrange }
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
    simple { pageStyle1
             | bodyText <- { bodyStyle
                             | height <- Just 100
                             , color <- white
                           }
           }
           ""
           ((Text_ [
              "Kelmote"
            ]) ~@ swingEffectFunc)
  , simple pageStyle1
           "What is Kelmote"
           (Empty_)
  , simple pageStyle1
           "What is Kelmote"
           ((Text_ [
              "This is an application for creating simple slide."
            ]) ~@ zoomEffectFunc)
  , simple pageStyle1
           "What is Kelmote"
           ((Text_ [
              "This is an application for creating simple slide."
            , "This slide also was created using the Kelmote."
            ]) ~@ moveEffectFunc)
  , simple pageStyle1
           "What is Kelmote"
           (Text_ [
              "Written in elm."
            ])
  , simple pageStyle1
           "What is Kelmote"
           (Text_ [
              "Written in elm."
            , "Elm is one of the AltJs that has syntax like haskell."
            ])
  , simple pageStyle1
           "What is Kelmote"
           (Text_ [
              "Written in elm."
            , "Elm is one of an AltJs."
            , "http://elm-lang.org/ in details."
            ])
  , simple pageStyle2
           "Kelmote's feature"
           (Empty_)
  , simple pageStyle2
           "Kelmote's feature"
           (Text_ [
              "To be honest, is not so much function.;p"
            ])
  , simple pageStyle2
           "Kelmote's feature"
           (Text_ [
              "1. You can make slides in your favorite text editor."
            ])
  , simple pageStyle2
           "Kelmote's feature"
           (Text_ [
              "1. You can make slides in your favorite text editor."
            , "　emacs, vim, atom, sublime,,,"
            ])
  , horizontal pageStyle3
           "Kelmote's feature"
           (Text_ [
              "2. Of course, image also placed."
            ])
           (Empty_)
  , horizontal pageStyle3
           "Kelmote's feature"
           (Text_ [
              "2. Of course, image also placed."
            ])
           (Image_ [ (400, 400, "Example/IMG_1127.jpg")
                   , (400, 400, "Example/IMG_0995.jpg")
                   , (400, 400, "Example/IMG_1448.jpg")
                   ])
  , horizontal pageStyle4
           "Kelmote's feature"
           (Text_ [
              "3. You can put the program code in slide."
            ])
           (Empty_)
  , horizontal pageStyle4
           "Kelmote's feature"
           (Text_ [
              "3. You can put the program code in slide."
            , "　and syntax highlighten."
            ])
           (Empty_)
  , horizontal pageStyle4
           "Kelmote's feature"
           (Text_ [
              "3. You can put the program code in slide."
            , "　and syntax highlighten."
             ])
           (Code_ codeMd)
  , simple pageStyle5
           "Kelmote's feature"
           (Text_ [
              "4. You can set the background image."
            ])
  , simple pageStyle6
           "Kelmote's feature"
           (Text_ [
              "4. You can set the background image."
            ])
  ]


codeMd : String
codeMd = """
```haskell
import Kelmote exposing (..)
import Color exposing (..)
import Text as T

main =
  run pages

pages : List Page
pages =
  [
      simple pageStyle1 "" (Text_ ["Kelmote"])
    , simple pageStyle1 "What is Kelmote" (Empty_)
    , simple pageStyle1 "What is Kelmote" (Text_ [ "This is an application for creating slide." ])
    , simple pageStyle1 "What is Kelmote" (Text_ [ "This is an application for creating slide." , "This slide also was created using the Kelmote." ])
    , simple pageStyle1 "What is Kelmote" (Text_ [ "Written in elm." ])
    , simple pageStyle1 "What is Kelmote" (Text_ [ "Written in elm." , "http://elm-lang.org/" ])
    , simple pageStyle2 "Kelmote's feature" (Empty_)
    , simple pageStyle2 "Kelmote's feature" (Text_ [ "You can make slides in your favorite text editor." ])
  ]
```
"""


swingEffectFunc : Time.Time -> GE.Element -> GE.Element
swingEffectFunc t e =
  let
    w = GE.widthOf e
    h = (toFloat w) * (cos (degrees 20)) * (toFloat (GE.heightOf e)) |> ceiling
  in
    GC.collage w h <| [GC.rotate (sin (degrees (10 * (Time.inSeconds t)))) (GC.toForm e)]


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

