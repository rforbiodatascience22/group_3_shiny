#' make_peptide UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_make_peptide_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(8,
               # Make peptide button
               uiOutput(ns("DNA_sequence"))
               ),
        column(4,
               # Random sequence length input
               numericInput(
                 inputId = ns("DNA_length"),
                 value = 6000,
                 min = 3,
                 max = 100000,
                 step = 3,
                 label = "Random DNA length"
               ),
               # Generate random sequence button
               actionButton(
                 inputId = ns("generate_DNA"),
                 label = "Generate", style = "margin-top: 18px;"
                )
               )
      ),
      # Peptide sequence output field
      verbatimTextOutput(outputId = ns("peptide")) %>%
        tagAppendAttributes(style = "white-space: pre-wrap;")
    )
  )
}

#' make_peptide Server Functions
#'
#' @noRd
mod_make_peptide_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_make_peptide_ui("make_peptide_1")

## To be copied in the server
# mod_make_peptide_server("make_peptide_1")
