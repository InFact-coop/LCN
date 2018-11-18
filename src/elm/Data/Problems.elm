module Data.Problems exposing (problemCheckboxesList)

import Components.LawAreaCheckbox exposing (agencyCheckbox, problemCheckbox)
import Html exposing (..)
import Types exposing (..)


problemCheckboxesList : Model -> List (Html Msg)
problemCheckboxesList model =
    case model.lawArea of
        WelfareAndBenefits ->
            [ problemCheckbox "Carers' Allowance" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Council Tax Reduction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "DLA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "ESA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Entitlement" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "JSA" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Overpayment" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "PIP" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Pension Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Right to Reside" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Sanctions" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Tax Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Universal Credit" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Employment ->
            [ problemCheckbox "Breach of Contract" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Constructive Dismissal" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Disciplinary / Grievance" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Discrimination" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Redundancy Payments" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Unfair Dismissal" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Whistleblowing" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Withheld Wages / Notice / Holiday Pay" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Working Time" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Debt ->
            [ problemCheckbox "Council Tax Arrears / Bailiffs" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Court Fines" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Credit Card Debt" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Mortgage (Arrears or Interest Only)" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Overpaid Benefits Clawback" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Rent Arrears" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Secured or Student Loans" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Utilities" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Housing ->
            [ problemCheckbox "Allocations" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Committals" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Disrepair" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Duty Scheme" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Eviction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Homelessness" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Homelessness Review" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Injunction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Possession" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        ImmigrationAndAsylum ->
            [ problemCheckbox "Article 3 / Humanitarian Protection" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Article 8" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Asylum" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Children / UASC" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Family Reunion" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "NRPF" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Trafficking" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        Family ->
            [ problemCheckbox "Care Proceedings" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Child Abduction" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Child Arrangement Orders" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Divorce" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Domestic Violence" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Financial Matters" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        CommunityCare ->
            [ problemCheckbox "Aids and Adaptations" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Assessments for Care / Support" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Best Interest Decision Making" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care / Support Planning" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care Home Placement / Supported Living" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Care at Home" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Carers Assessment / Services" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Children's Act Assessment / Services" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Payments (Charging, Personal Budget, Direct Payments)" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Service Reorganisation / Closure" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        PublicLaw ->
            [ problemCheckbox "Human Rights" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Migrant Support" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Social Welfare" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            , problemCheckbox "Other" (model.postStatsStatus == UserConfirmation || model.postStatsStatus == ResponseSuccess || model.postStatsStatus == Loading) model.problems
            ]

        NoArea ->
            []
