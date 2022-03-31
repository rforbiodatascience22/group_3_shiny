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
    hr(strong("Welcome to Rbosome server!")),
    p("Insert a DNA query or generate a random sequence of
      chosen length."),
    fluidRow(
      column(8, shiny::uiOutput(ns("DNA"))),
      column(4, shiny::numericInput(
        inputId = ns("dna_length"),
        value = 6000,
        min = 3,
        max = 100000,
        step = 3,
        label = "Random DNA length"
      ),
      shiny::actionButton(
        inputId = ns("generate_dna"),
        label = "Generate random DNA", style = "margin-top: 18px;"
      ))
    ),
    shiny::verbatimTextOutput(outputId = ns("peptide")) %>%
      shiny::tagAppendAttributes(style = "white-space: pre-wrap;")

  )
}
#' make_peptide Server Functions
#'
#' @noRd
mod_make_peptide_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    dna <- reactiveVal()

    output$DNA <- renderPrint({
      textAreaInput(
        inputId = ns("DNA"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    observeEvent(input$generate_dna, {
      dna(
        Rbosome::ATGC(input$dna_length)
      )
    })
    output$peptide <- renderText({
      # Ensure input is not NULL and is longer than 2 characters
      if(is.null(input$DNA)){
        NULL
      } else if(nchar(input$DNA) < 3){
        NULL
      } else{
        input$DNA %>%
          toupper() %>%
          Rbosome::DNA_to_RNA() %>%
          Rbosome::rna_transform() %>%
          Rbosome::translate()
      }
    })
  })
}

## To be copied in the UI
# mod_make_peptide_ui("make_peptide_1")

## To be copied in the server
# mod_make_peptide_server("make_peptide_1")
