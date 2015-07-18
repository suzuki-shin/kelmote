import Kelmote exposing (..)
import Color exposing (..)
import Text as T

main =
  run pages


headerStyle : T.Style
headerStyle =
  { defaultHeaderTextStyle
    | color <- white
  }


bodyStyle : T.Style
bodyStyle =
  { defaultBodyTextStyle
    | color <- white
  }


pageStyle : Style
pageStyle =
  { defaultPageStyle
    | headerText <- headerStyle
    , bodyText <- bodyStyle
    , background <- BgColor blue
  }


pages : List Page
pages =
  [
    simple
    pageStyle
    "Profile"
    (Text_ [
      "Name: ~~hogeta fugao~~"
     ])
  , simple
    pageStyle
    "Profile"
    (Text_ [
      "Name: ~~hogeta fugao~~"
     ,"Age: ~~30~~"
     ])
  , simple
    pageStyle
    "Profile"
    (Text_ [
      "Name: ~~hogeta fugao~~"
     ,"Age: ~~30~~"
     ,"Job: ~~Neet~~"
     ])
  , vertical
    { pageStyle
      | background <- BgColor green
    }
    "Work1"
    (Text_ ["Hoge"])
    (Image_ 300 300 "Example/IMG_1448.jpg")
  , horizontal
    { pageStyle
      | background <- BgColor red
    }
    "Work2"
    (Text_ ["Hoge hoge hogera"])
    (Image_ 300 300 "Example/IMG_1448.jpg")
  , simple
    { pageStyle
      | background <- BgImage "Example/IMG_0064.jpg"
    }
    ""
    (Text_ ["Hello Hello"])
  ]
