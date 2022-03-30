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
    textInput(ns("dna"),
              label = h3("Insert your DNA sequence here"),
              value = "Insert sequence..."),
    numericInput(
      inputId = ns("dna_length"),
      value = 6000,
      min = 3,
      max = 100000,
      step = 3,
      label = "Random DNA length"
    ),
    actionButton(
      inputId = ns("generate_dna"),
      label = "Generate random DNA", style = "margin-top: 18px;"
    ),
    hr(),
    fluidRow(
      column(2, verbatimTextOutput("value")),
      column(2, "random_dna_length", "generate_dna_button"),
      column(10, "peptide_sequence" )
      ),

    mainPanel(
      shiny::textOutput(
        outputId = ns("value")
      )

    )
  )
}

#' make_peptide Server Functions
#'
#' @noRd
mod_make_peptide_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    #output$value <- renderPrint({ input$dna })
    output$value <- renderPrint({ input$generate_dna })


  })
}

## To be copied in the UI
# mod_make_peptide_ui("make_peptide_1")

## To be copied in the server
# mod_make_peptide_server("make_peptide_1")
