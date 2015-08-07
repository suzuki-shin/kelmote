module Kelmote
  ( run
  , simple
  , vertical
  , horizontal
  , split4
  , Background (BgColor, BgImage)
  , Page
  , BodyElement (..)
  , Style
  , defaultHeaderTextStyle
  , defaultBodyTextStyle
  , defaultPageStyle
  , timeDepend
  , (~@)
  ) where

{-| This is a presentation slide maker.

# Definition
@docs Background (BgColor, BgImage)
@docs Page
@docs BodyElement (..)
@docs Style

# Common Helpers
@docs run
@docs simple
@docs vertical
@docs horizontal
@docs split4
@docs defaultHeaderTextStyle
@docs defaultBodyTextStyle
@docs defaultPageStyle
@docs timeDepend
@docs (~@)

-}

import Color exposing (..)
import Graphics.Element as GE
import Graphics.Collage as GC
import Text as T
import Text exposing (defaultStyle)
import Color exposing (..)
import Signal
import Signal exposing ((<~), (~))
import Keyboard
import List as L
import Array as A
import Maybe exposing (withDefault)
import Window
import Touch
import Markdown
import Time
-- import Debug


{-| Page
-}
type Page =
  Page Style Header Body


type alias Header =
  String


type Body
  = Simple BodyElement
  | Vertical BodyElement BodyElement
  | Horizontal BodyElement BodyElement
  | Split4 BodyElement BodyElement BodyElement BodyElement


type ChartType
  = LineChart
  | BarChart


type alias ChartData = List Float


{-| BodyElement
-}
type BodyElement
  = Empty_
  | Text_ (List String)
  | Image_ (List (Int, Int, String))
  | Chart_ ChartType ChartData
  | Code_ String
  | TextTimeDepend_ (Time.Time -> GE.Element -> GE.Element) (List String)
  | ImageTimeDepend_ (Time.Time -> GE.Element -> GE.Element) (List (Int, Int, String))


{-| Style
-}
type alias Style =
  { headerText : T.Style
  , bodyText : T.Style
  , background : Background
  }


{-| Background
-}
type Background
  = BgColor Color
  | BgImage String


bodyElementToElement : Time.Time -> Style -> BodyElement -> GE.Element
bodyElementToElement t style be =
  case be of
    Empty_ ->
      GE.empty

    Text_ ss ->
      texts style.bodyText ss

    Image_ imgs ->
      GE.flow GE.left <| L.map (\(w,h,img) -> GE.fittedImage w h img) imgs

    Code_ md ->
      let
        el = Markdown.toElement md
      in
        GE.container
            ((GE.widthOf el) + 20)
            ((GE.heightOf el) + 20)
            GE.middle
            el
        |> GE.color white

    TextTimeDepend_ func ss ->
      func t (bodyElementToElement t style (Text_ ss))

    ImageTimeDepend_ func imgs ->
      func t (bodyElementToElement t style (Image_ imgs))

    otherwise ->
      GE.show "unknown body element.."



type alias PageIdx =
  Int


type Model =
  Model PageIdx (A.Array Page)


type Action
  = NoOp
  | Increment
  | Decrement


{-| run
-}
run : List Page -> Signal GE.Element
run ps =
  view <~ (Signal.foldp update (model ps) (Signal.merge arrowsToAction tapToAction))
       ~ Window.dimensions
       ~ Time.every Time.millisecond


model : List Page -> Model
model pages =
  Model 0 (A.fromList pages)


view : Model -> (Int, Int) -> Time.Time -> GE.Element
view (Model pageIdx pageList) (w, h) t =
  let
    headerOf : Page -> GE.Element
    headerOf (Page style header _) =
      GE.container
        w
        (GE.heightOf (strToHeader style.headerText header) + 20)
        GE.midBottom (strToHeader style.headerText header)


    bodyOf : Page -> GE.Element
    bodyOf (Page style _  body) =
      GE.container w h GE.middle <| case body of
        Simple b ->
          bodyElementToElement t style b

        Vertical b1 b2 ->
          GE.flow GE.right
               [
                 bodyElementToElement t style b1
               , GE.spacer 30 30
               , bodyElementToElement t style b2
               ]

        Horizontal b1 b2 ->
          GE.flow GE.down
               [
                 bodyElementToElement t style b1
               , GE.spacer 30 30
               , bodyElementToElement t style b2
               ]

        Split4 b1 b2 b3 b4 ->
          GE.flow GE.right
              [
                GE.flow GE.down
                    [
                      bodyElementToElement t style b1
                    , GE.spacer 30 30
                    , bodyElementToElement t style b2
                    ]
              , GE.flow GE.down
                    [
                      bodyElementToElement t style b3
                    , GE.spacer 30 30
                    , bodyElementToElement t style b4
                    ]
              ]

        otherwise ->
          GE.show ""


    bg : Int -> Int -> Background -> GE.Element -> GE.Element
    bg w h b e =
      case b of
        BgColor c ->
          GE.color c e

        BgImage s ->
          GE.layers [GE.fittedImage w h s, e]


    background : Page -> GE.Element -> GE.Element
    background (Page style _ _) =
      bg w h (style.background)


    page : Page
    page =
      withDefault
        (Page defaultPageStyle "" (Simple Empty_))
        (A.get pageIdx pageList)


    pageElement : GE.Element
    pageElement =
      GE.layers [ headerOf page, bodyOf page] |> background page


  in
    pageElement


update : Action -> Model -> Model
update action (Model pageIdx pageList) =
  case action of
    NoOp ->
        Model pageIdx pageList

    Increment ->
        Model (pageIdx + 1) pageList

    Decrement ->
        Model (pageIdx - 1) pageList


tapToAction : Signal Action
tapToAction =
  let
    tapSignal : Signal Int
    tapSignal =
      (\(w,h) {x,y} ->
        if | x >= round (toFloat w*3/4) -> 1
           | x <= round (toFloat w/4) -> -1
           | otherwise -> 0
      ) <~ Window.dimensions
        ~ Touch.taps

    toAction : Int -> Action
    toAction x =
      if | x == 1 ->
             Increment

         | x == -1 ->
             Decrement

         | otherwise ->
             NoOp
  in
    toAction <~ tapSignal


arrowsToAction : Signal Action
arrowsToAction =
  let
    toAction : {x:Int, y:Int} -> Action
    toAction {x,y} =
      if | x == 1 ->
             Increment

         | x == -1 ->
             Decrement

         | otherwise ->
             NoOp
  in
    toAction <~ Keyboard.arrows


strToHeader : T.Style -> String -> GE.Element
strToHeader styl =
    T.fromString >> T.style styl >> GE.leftAligned


strToContent : T.Style -> String -> GE.Element
strToContent styl =
    T.fromString >> T.style styl >> GE.centered


texts : T.Style -> List String -> GE.Element
texts styl =
    L.map (strToContent styl) >> GE.flow GE.down


{-| defaultHeaderTextStyle
-}
defaultHeaderTextStyle : T.Style
defaultHeaderTextStyle =
  { defaultStyle
    | color <- black
    , height <- Just 70
    , bold <- False
  }


{-| defaultBodyTextStyle
-}
defaultBodyTextStyle : T.Style
defaultBodyTextStyle =
  { defaultStyle
    | color <- black
    , height <- Just 60
    , bold <- False
  }


{-| defaultPageStyle
-}
defaultPageStyle : Style
defaultPageStyle =
  { headerText = defaultHeaderTextStyle
  , bodyText = defaultBodyTextStyle
  , background = BgColor white
  }


{-| simple
-}
simple : Style -> Header -> BodyElement -> Page
simple style header bodyE =
  Page style header (Simple bodyE)


{-| vertical
-}
vertical : Style -> Header -> BodyElement -> BodyElement -> Page
vertical style header bodyE1 bodyE2 =
  Page style header (Vertical bodyE1 bodyE2)


{-| horizontal
-}
horizontal : Style -> Header -> BodyElement -> BodyElement -> Page
horizontal style header bodyE1 bodyE2 =
  Page style header (Horizontal bodyE1 bodyE2)


{-| split4
-}
split4 : Style -> Header -> BodyElement
               -> BodyElement -> BodyElement -> BodyElement -> Page
split4 style header bodyE1 bodyE2 bodyE3 bodyE4 =
  Page style header (Split4 bodyE1 bodyE2 bodyE3 bodyE4)


{-| timeDepend
-}
timeDepend : (Time.Time -> GE.Element -> GE.Element) -> BodyElement -> BodyElement
timeDepend f be =
  case be of
    Text_ a ->
      TextTimeDepend_ f a
    Image_ a ->
      ImageTimeDepend_ f a


{-| (~@)
alias for timeDepend
-}
(~@) : BodyElement -> (Time.Time -> GE.Element -> GE.Element) -> BodyElement
(~@) be f= timeDepend f be
