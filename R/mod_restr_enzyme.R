#' restr_enzyme UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_restr_enzyme_ui <- function(id){
  ns <- NS(id)
  tagList(
    hr(strong("Choose the restriction enzyme
             to find cutting positions in a DNA
             sequence.")),
    p("The sequence should be in the direction of 5-end to 3-end."),
    fluidRow(
      column(4, shiny::radioButtons(
        inputId = ns("enzyme_choice"),
        label = h3("Restriction enzymes"),
        choices = list("EcoRI 1" = 'GAATTC' ,
                       "SmaI" = 'CCCGGG'),
        selected = 1)
      ),
      column(8, shiny::uiOutput(ns("DNA"))),
    ),
    "Restriction sites",
    column(12, verbatimTextOutput(outputId = ns("position"))
  ))
}

#' restr_enzyme Server Functions
#'
#' @noRd
mod_restr_enzyme_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    dna <- reactiveVal()

    output$DNA <- renderPrint({
      textAreaInput(
        inputId = ns("DNA"),
        label = h3("DNA sequence"),
        placeholder = "Insert DNA sequence...",
        value = dna(),
        height = 100,
        width = 600
      )
    })

    output$position <- renderPrint({
      #Ensure choice input is not NULL
      if(is.null(input$enzyme_choice)){
        NULL
      } else{
        input$enzyme_choice %>%
      Biostrings::matchPattern(
        input$DNA)
      }
      # Biostrings::matchPattern(
      #   input$enzyme_choice, input$DNA)
  }
  )
  }
)
}

## To be copied in the UI
# mod_restr_enzyme_ui("restr_enzyme_1")

## To be copied in the server
# mod_restr_enzyme_server("restr_enzyme_1")
