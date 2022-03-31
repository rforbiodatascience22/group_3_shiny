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
               # UI output from server (with DNA_sequence output):
               uiOutput(ns("DNA_sequence"))
               ),
        column(4,
               # Random sequence length input widget
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

    # Create reactive DNA value.
    dna <- reactiveVal()

    # Create input textbox with the reactive DNA value
    output$DNA_sequence <- renderUI({
      textAreaInput(
        inputId = ns("DNA_sequence"),
        label = "DNA sequence",
        placeholder = "Insert DNA sequence",
        value = dna(),
        height = 100,
        width = 600
      )
    })

      # Create reaction when generate dna button is clicked.
      observeEvent(input$generate_DNA, {
        dna(
          Rbosome::ATGC(input$DNA_length)
        )
      })

      # Create peptide output string from textbox DNA_sequence input:

      output$peptide <- renderText({
        # Ensure input is not NULL and is longer than 2 characters
        if(is.null(input$DNA_sequence)){
          NULL
        } else if(nchar(input$DNA_sequence) < 3){
          NULL
        } else{
          input$DNA_sequence %>%
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
