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
    fluidRow(
      column(8, "DNA_sequence"),
      column(4, "random_dna_length", "generate_dna_button")
    ),
    "peptide_sequence"

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
