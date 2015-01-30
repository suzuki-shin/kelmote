module Sample where

import Graphics.Element (..)
import Text as T
import Color (..)
import List as L
import Window
import Signal (Signal, (<~), (~), foldp)
import Keyboard
import Array as A
import Time (Time, fps, inSeconds)

bodyTextStyle = { typeface = [ "Lucida Console", "monospace" ]
                , height   = Just 50
                , color    = white
                , bold     = True
                , italic   = False
                , line     = Nothing
                }

stringToElement : String -> Element
stringToElement s = T.fromString s |> T.style bodyTextStyle |> T.centered

element1 = flow down <| L.map stringToElement [ "コラボキャンペーンLP," , "we can stack elements" , "on top of other elements." ]
element2 = flow down <| [ fittedImage 300 300 "haskell_logo.png" ]

pageCount : Signal Int
pageCount =  foldp (\{x, y} count -> count + x) 0 Keyboard.arrows

pageByIdx : Int -> List Page -> Page
pageByIdx idx pList = case A.get idx (A.fromList pList) of
                        Just p -> p
                        Nothing -> Page empty empty white

view : List Page -> (Int, Int) -> Int -> Time -> Element
view pageList (w, h) currentPage sec =
    let page = pageByIdx currentPage pageList
    in color page.backGroundColor <| container w h middle <| flow down [ T.asText (inSeconds sec), page.content]
--     in color page.backGroundColor <| container w h middle <| opacity (inSeconds sec) <| page.content
--     in color page.backGroundColor <| container w h middle page.content

main : Signal Element
main = view pageList <~ Window.dimensions
                      ~ pageCount
                      ~ fps 3
v2Page : Element -> Element -> Element
v2Page leftE rightE = flow left [ leftE , rightE ]

h2Page : Element -> Element -> Element
h2Page upperE lowerE = flow down [ upperE , lowerE ]

pageList = [
   Page empty element1 blue
 , Page empty (v2Page element1 element2) green
 , Page empty (h2Page element1 element2) lightBlue
 ]

type alias Page = { header : Element, content : Element, backGroundColor : Color }
