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
              label = h3("Insert DNA sequence"),
              value = "Insert sequence..."),
    numericInput(
      inputId = ns("dna_length"),
      value = 60,
      min = 3,
      max = 100000,
      step = 3,
      label = "Random DNA length"
    ),
    actionButton(
      inputId = ns("generate_dna"),
      label = "Generate", style = "margin-top: 18px;"
    ),
    fluidRow(
      column(2, verbatimTextOutput("value")),
      #column(2, "random_dna_length", "generate_dna_button"),
      #column(10, "peptide_sequence" )
      ),

    mainPanel(
      textOutput(
        outputId = ns("value")
      ),
      textOutput(
        outputId = ns("gdna")
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
    output$value <- renderPrint({ input$dna })
    output$randomdna <- renderText({
      paste0( sample(c("A","T","G","C"),
                     size = input$dna_length,
                     replace = TRUE),
              collapse = ""
              )
      })
    output$gdna <- observeEvent( input$generate_dna, {
      print(output$randomdna)
    })


  })
}

## To be copied in the UI
# mod_make_peptide_ui("make_peptide_1")

## To be copied in the server
# mod_make_peptide_server("make_peptide_1")
