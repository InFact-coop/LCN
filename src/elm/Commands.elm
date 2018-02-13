module Commands exposing (..)

import Types exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Http exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode


formEncoder : Model -> Encode.Value
formEncoder model =
    let
        attributes =
            [ ( "Name", Encode.string model.airtableForm.name )
            , ( "Contact Number", Encode.string model.airtableForm.contactNumber )
            , ( "Email", Encode.string model.airtableForm.email )
            , ( "Role", Encode.string model.airtableForm.role )
            , ( "Role (Other)", Encode.string model.airtableForm.roleOther )
            , ( "Start Date", Encode.string model.airtableForm.startDate )
            , ( "Contract Length", Encode.string model.airtableForm.contractLength )
            , ( "Contract Length (Other)", Encode.string model.airtableForm.contractOther )
            , ( "Min Rate", Encode.int model.airtableForm.minRate )
            , ( "Max Rate", Encode.int model.airtableForm.maxRate )
            , ( "CV", Encode.string model.airtableForm.cv )
            , ( "LinkedIn", Encode.string model.airtableForm.linkedIn )
            , ( "Twitter", Encode.string model.airtableForm.twitter )
            , ( "GitHub", Encode.string model.airtableForm.gitHub )
            , ( "Personal Website", Encode.string model.airtableForm.website )
            , ( "Q1", Encode.string model.airtableForm.q1 )
            , ( "Q2", Encode.string model.airtableForm.q2 )
            , ( "Q3", Encode.string model.airtableForm.q3 )
            ]
    in
        Encode.object attributes


methodRequest : String -> String -> Encode.Value -> Decode.Decoder a -> Http.Request a
methodRequest method url encodedBody decoder =
    Http.request
        { body = encodedBody |> Http.jsonBody
        , expect = Http.expectJson decoder
        , headers = []
        , method = method
        , timeout = Nothing
        , url = url
        , withCredentials = False
        }


formResponseDecoder : Decode.Decoder FormResponse
formResponseDecoder =
    decode FormResponse
        |> Json.Decode.Pipeline.required "success" Decode.bool


postFormRequest : Model -> Http.Request FormResponse
postFormRequest model =
    let
        baseUrl =
            "/api/v1/upload-form"
    in
        methodRequest "POST" baseUrl (formEncoder model) formResponseDecoder


sendFormCmd : Model -> Cmd Msg
sendFormCmd model =
    postFormRequest model
        |> Http.send OnFormSent
