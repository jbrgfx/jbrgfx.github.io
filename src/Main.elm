module Main exposing (..)

import Color exposing (black, darkBlue, lightGrey, white)
import Element exposing (Element, alignBottom, alignLeft, centerY, column, height, image, layout, newTabLink, padding, paddingEach, paragraph, px, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html


main =
    Html.beginnerProgram { model = initialModel, view = view, update = update }


type alias Model =
    { people : List String
    , filtered : List String
    , filterTerm : String
    }


initialModel : Model
initialModel =
    { people = [ "elm-filtered-list", "elm-style-elements-experiments", "github-stylish-elephants-search", "responsive-filtered-list", "responsive-stylish-elephants" ]
    , filtered = [ "elm-filtered-list", "elm-style-elements-experiments", "github-stylish-elephants-search", "responsive-stylish-elephants" ]
    , filterTerm = "el"
    }



-- UPDATE


type Msg
    = Filter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filterTerm ->
            { model
                | filtered = List.filter (String.contains filterTerm) model.people
                , filterTerm = filterTerm
            }



-- VIEW


view model =
    Element.layout
        [ Background.color white
        , width (px 900)
        , paddingLeft gutter
        , Font.family
            [ Font.typeface "Open Sans"
            , Font.sansSerif
            ]
        ]
    <|
        column
            []
            [ headerArea
            , mainColumns
                { left =
                    [ row [ padding gutter ] [ inputForm ]
                    , validateFilter model
                    , paragraph
                        []
                        [ Element.text "Results:" ]
                    , paragraph
                        [ padding gutter
                        , Background.color lightGrey
                        , Font.size 16
                        ]
                        (List.map viewPeople model.filtered)
                    ]
                , right =
                    [ theAppDesc
                    , overViewDesc
                    ]
                }
            , footerArea
            ]


headerArea =
    row
        [ Background.color white
        , Font.color darkBlue
        , borderBottom 1
        , Border.color darkBlue
        ]
        [ elmlogo
        , Element.el
            [ centerY
            , Font.size 40
            , Font.bold
            ]
            (Element.text "stylish-elephants experiments")
        ]


elmlogo =
    row []
        [ image
            [ width (px 180)
            , height (px 73)
            , alignLeft
            ]
            { description = "the Elm Language logo"
            , src = "elm_logo.png"
            }
        ]


theAppDesc =
    paragraph
        [ padding gutter
        , Element.alignTop
        ]
        [ Element.el
            [ alignLeft
            , Element.spacingXY 4 100
            , padding 10
            , Font.size 40
            , Font.lineHeight 0.5
            , Font.color darkBlue
            , Background.color white
            ]
            (Element.text "S")
        , paragraph
            [ width (px 300)
            , Font.color black
            , Font.size 18
            ]
            [ Element.text " earch for stylish-elephants experimental projects by jbrgfx on github." ]
        ]


overViewDesc =
    paragraph
        [ padding gutter
        , Element.alignTop
        ]
        [ Element.el
            [ alignLeft
            , Element.spacingXY 4 100
            , padding 10
            , Font.size 40
            , Font.lineHeight 0.5
            , Font.color darkBlue
            , Background.color white
            ]
            (text "A")
        , paragraph
            [ width (px 300)
            , Font.color black
            , Font.size 18
            ]
            [ Element.text " simple Elm module that filters a list using text input.  The module has an initial state to demonstrate to the end-user how the text box works and end-user feedback to guide the user in the use of the module." ]
        ]


viewPeople entry =
    paragraph
        []
        [ newTabLink
            [ padding gutter
            , Font.bold
            , Font.size 18
            , Font.underline
            , alignBottom
            , Font.color darkBlue
            , Element.mouseOver [ Font.color Color.white, Background.color Color.darkBlue ]
            ]
            { url = "https://github.com/jbrgfx/" ++ entry
            , label = Element.text entry
            }
        ]


validateFilter model =
    let
        message =
            if model.filterTerm == "" then
                "❌ No filter. Try adding one!"
            else
                "✅ Filter is set."
    in
    row []
        [ Element.text message ]


mainColumns { left, right } =
    row
        [ borderBottom 1
        , Border.color darkBlue
        ]
        [ column
            [ borderRight 1
            , Border.color darkBlue
            , paddingRight gutter
            ]
            left
        , column
            [ paddingLeft gutter ]
            right
        ]


inputForm : Element Msg
inputForm =
    Input.text
        [ Border.color Color.black
        ]
        { label = Input.labelLeft [] (text "Filter:")
        , onChange = Just Filter
        , placeholder = Nothing
        , text = initialModel.filterTerm
        }


footerArea =
    row
        [ Font.color darkBlue
        , paddingTop 20
        ]
        [ newTabLink
            [ Font.bold
            , Font.size 18
            , Font.underline
            , alignBottom
            ]
            { url = "http://package.elm-lang.org/packages/mdgriffith/stylish-elephants/latest/"
            , label = Element.text "stylish-elephants latest: package docs"
            }
        ]



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Atom.elm -}


gutter =
    20



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


borderRight n =
    Border.widthEach { right = n, left = 0, top = 0, bottom = 0 }


borderBottom n =
    Border.widthEach { right = 0, left = 0, top = 0, bottom = n }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingRight n =
    paddingEach { right = n, left = 0, top = 0, bottom = 0 }


paddingTop n =
    paddingEach { bottom = 0, top = n, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingBottom n =
    paddingEach { bottom = n, top = 0, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingLeft n =
    paddingEach { right = 0, left = n, top = 0, bottom = 0 }
