import Graphics.Element (..)
import Graphics.Input.Field as Field
import Signal (..)
import String
import Text (plainText)


type alias Cel = Channel Field.Content

celA0 : Cel
celA0 = channel Field.noContent
celA1 : Cel
celA1 = channel Field.noContent
celA2 : Cel
celA2 = channel Field.noContent
celB0 : Cel
celB0 = channel Field.noContent
celB1 : Cel
celB1 = channel Field.noContent
celB2 : Cel
celB2 = channel Field.noContent
celC0 : Cel
celC0 = channel Field.noContent
celC1 : Cel
celC1 = channel Field.noContent
celC2 : Cel
celC2 = channel Field.noContent

main : Signal Element
main = scene <~ (subscribe celA0) ~ (subscribe celA1) ~ (subscribe celB0) ~ (subscribe celB1)

scene : Field.Content -> Field.Content -> Field.Content -> Field.Content -> Element
scene valueA0 valueA1 valueB0 valueB1 = flow down
   [ flow right [
                 Field.field Field.defaultStyle (send celA0) "" valueA0
               , Field.field Field.defaultStyle (send celB0) "" valueB0
               , Field.field Field.defaultStyle (send celC0) "" (Field.Content (toString ((toInt valueA0.string) + (toInt valueB0.string))) (Field.Selection 0 0 Field.Forward))
              ]
   , flow right [
                 Field.field Field.defaultStyle (send celA1) "" valueA1
               , Field.field Field.defaultStyle (send celB1) "" valueB1
               , Field.field Field.defaultStyle (send celC1) "" (Field.Content (toString ((toInt valueA1.string) + (toInt valueB1.string))) (Field.Selection 0 0 Field.Forward))
              ]
   , flow right [
                 Field.field Field.defaultStyle (send celA2) "" (Field.Content (toString ((toInt valueA0.string) + (toInt valueA1.string))) (Field.Selection 0 0 Field.Forward))
               , Field.field Field.defaultStyle (send celB2) "" (Field.Content (toString ((toInt valueB0.string) + (toInt valueB1.string))) (Field.Selection 0 0 Field.Forward))
               , Field.field Field.defaultStyle (send celC2) "" (Field.Content (toString ((toInt valueA0.string) + (toInt valueA1.string) + (toInt valueB0.string) + (toInt valueB1.string))) (Field.Selection 0 0 Field.Forward))
              ]
   ]

toInt str = case String.toInt str of
  Ok n -> n
  Err msg -> 0
