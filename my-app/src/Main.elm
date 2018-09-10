module Main exposing (main)

-- https://ellie-app.com/3j3zsLYPdMza1

import Browser
import Html exposing (Html, article, button, div, h1, header, img, p, text)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)


type alias ImageAttributes =
    { imageUrl : String
    , caption : Maybe String
    }


type ImageAndCaption
    = NoImage
    | Image ImageAttributes


type alias Model =
    { title : String
    , paragraphs : List String
    , imageAndCaption : ImageAndCaption
    }


initialModel : Model
initialModel =
    { title = "Best Title Ever"
    , paragraphs =
        [ "First paragraph is about Elm "
        , "Second it still about Elm"
        ]
    , imageAndCaption =
        Image
            { imageUrl = "https://picsum.photos/200/300"
            , caption = Just "Image caption"
            }
    }


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


viewImageAndCaption : ImageAndCaption -> Html Msg
viewImageAndCaption imageAndCaption =
    case imageAndCaption of
        NoImage ->
            text ""

        Image imageAttributes ->
            let
                imgContent =
                    img
                        [ src imageAttributes.imageUrl
                        , class "mw-100 dib measure f3"
                        ]
                        []

                captionContent =
                    case imageAttributes.caption of
                        Just caption ->
                            div [ class "caption" ] [ text caption ]

                        Nothing ->
                            text ""
            in
            div []
                [ imgContent
                , captionContent
                ]


viewParagraphs : List String -> Html Msg
viewParagraphs paragraphs =
    div [ class "ph3 ph4-m ph5-l" ]
        (List.map (\paragraph -> p [ class "f4 mb4 center measure lh-copy" ] [ text paragraph ]) paragraphs)


viewParagraphsCount : List String -> Html Msg
viewParagraphsCount paragraphs =
    -- div [] [ text <| String.fromInt <| List.length paragraphs ]
    let
        count =
            List.foldl (\_ accum -> accum + 1) 0 paragraphs
    in
    div [ class "ph3 ph4-m ph5-l" ]
        [ text "Paragraphs Count: "
        , text <| String.fromInt count
        ]


view : Model -> Html Msg
view model =
    article [ class "baskerville pb5" ]
        [ header [ class "avenir tc-l ph3 ph4-ns pt4 pt5-ns" ]
            [ h1
                [ class "f3 f2-m f-subheadline-l measure lh-title fw1 mt0" ]
                [ text model.title ]
            ]
        , viewImageAndCaption model.imageAndCaption
        , viewParagraphs model.paragraphs
        , viewParagraphsCount model.paragraphs
        ]



--
--
-- article
--   [ class "baskerville pb5" ]
--   [ header
--     [ class "avenir tc-l ph3 ph4-ns pt4 pt5-ns" ]
--     [ h1
--       [ class "f3 f2-m f-subheadline-l measure lh-title fw1 mt0" ]
--       [ text "A Night of Taking Photos at the Spooky Ruins of the Sutro Baths" ]
--     , time
--       [ class "f5 f4-l db fw1 baskerville mb4" ]
--       [ text "March 19th, 2015" ]
--     , img
--       [ class "w-100 dib measure f3", src "http://mrmrs.github.io/photos/009.jpg", alt "A photo of sutro baths by Adam Morse" ]
--       []
--     ]
--   , div
--     [ class "ph3 ph4-m ph5-l" ]
--     [ p
--       [ class "f4 mb4 center measure lh-copy" ]
--       [ text "On"  time
--         []
--         [ text "March 14, 1896" ] text ", the Sutro Baths were opened to the public as the world's largest indoor swimming pool establishment."
--       ]
--     , div
--       [ class "measure db center f5 f4-ns lh-copy" ]
--       [ img
--         [ class "db w-100 mt4 mt5-ns", src "http://mrmrs.github.io/photos/013.jpg", alt "Photo of the foundations of a building on a cliff overlooking a lighthouse." ]
--         []
--       , p
--         []
--         [ text "Before it burned to the ground, the structure filled a small beach
--         inlet below the Cliff House, also owned by Adolph Sutro at the time.
--         Shortly after closing, a fire in 1966 destroyed the building
--         while it was in the process of being demolished." ]
--       , img
--         [ class "db w-100 mt4 mt5-ns", src "http://mrmrs.github.io/photos/012.jpg", alt "Photo of the sea with mist covering the rocky formations near the shore." ]
--         []
--       , p
--         []
--         [ text "During high tides, water would flow directly into the pools from the
--         nearby ocean, recycling the two million US gallons of water in about an hour." ]
--       , img
--         [ class "db w-100 mt4 mt5-ns", src "http://mrmrs.github.io/photos/010.jpg", alt "Photo of a dusk skyline above a grassy rockface covered in trees." ]
--         []
--       , p
--         []
--         [ text "All that remains
--         of the site are concrete walls, blocked off stairs and
--         passageways, and a tunnel with a deep crevice in the middle. The
--         cause of the fire was arson. Shortly afterwards, the developer
--         left San Francisco and claimed insurance money." ]
--       , img
--         [ class "db w-100 mt4 mt5-ns", src "http://mrmrs.github.io/photos/011.jpg", alt "Photo of the sea and sky on the horizon with the foundations of a demolished house." ]
--         []
--       , p
--         []
--         [ text "During low tides, a powerful turbine water pump,
--         built inside a cave at sea level, could be switched on from a control
--         room and could fill the tanks at a rate of 6,000 US gallons a minute,
--         recycling all the water in five hours." ]
--       ]
--     ]
--   ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
