module Main exposing (main)

-- https://ellie-app.com/3j3zsLYPdMza1

import Browser
import Html exposing (Html, button, div, img, p, text)
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
                    img [ src imageAttributes.imageUrl ] []

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
    div []
        (List.map (\paragraph -> p [] [ text paragraph ]) paragraphs)


viewParagraphsCount : List String -> Html Msg
viewParagraphsCount paragraphs =
    -- div [] [ text <| String.fromInt <| List.length paragraphs ]
    let
        count =
            List.foldl (\_ accum -> accum + 1) 0 paragraphs
    in
    div []
        [ text "Paragraphs Count: "
        , text <| String.fromInt count
        ]


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.title ]
        , viewImageAndCaption model.imageAndCaption
        , viewParagraphs model.paragraphs
        , viewParagraphsCount model.paragraphs
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
