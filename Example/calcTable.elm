import Graphics.Element (..)
import Graphics.Input.Field as Field
import Signal (..)
import String
import Text (plainText)
import List

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
celD0 : Cel
celD0 = channel Field.noContent
celD1 : Cel
celD1 = channel Field.noContent
celD2 : Cel
celD2 = channel Field.noContent

main : Signal Element
main = scene <~ (subscribe celA0)
              ~ (subscribe celA1)
              ~ (subscribe celB0)
              ~ (subscribe celB1)
              ~ (subscribe celC0)
              ~ (subscribe celC1)

scene : Field.Content -> Field.Content -> Field.Content -> Field.Content -> Field.Content -> Field.Content -> Element
scene valueA0 valueA1 valueB0 valueB1 valueC0 valueC1 =
    let field : Cel -> String -> Field.Content -> Element
        field cel defStr val = Field.field Field.defaultStyle (send cel) defStr val
        sumValue values =
            let fieldContent n = (Field.Content (toString n) (Field.Selection 0 0 Field.Forward))
            in fieldContent <| List.foldl (+) 0 <| List.map (\v -> v.string |> toInt) values
    in flow down
           [ flow right [
                 field celA0 "A0" valueA0
               , field celB0 "B0" valueB0
               , field celC0 "C0" valueC0
               , field celD0 "A0 + B0 + C0" (sumValue [valueA0, valueB0, valueC0])
              ]
           , flow right [
                 field celA1 "A1" valueA1
               , field celB1 "B1" valueB1
               , field celC1 "C1" valueC1
               , field celC1 "A1 + B1 + C1" (sumValue [valueA1, valueB1, valueC1])
              ]
           , flow right [
                 field celA2 "A0 + A1" (sumValue [valueA0, valueA1])
               , field celB2 "B0 + B1" (sumValue [valueB0, valueB1])
               , field celC2 "C0 + C1" (sumValue [valueC0, valueC1])
               , field celC2 "A0 + A1 + B0 + B1 + C0 + C1" (sumValue [valueA0, valueA1, valueB0, valueB1, valueC0, valueC1])
              ]
           ]

toInt str = case String.toInt str of
  Ok n -> n
  Err msg -> 0
