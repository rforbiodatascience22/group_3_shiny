#' plot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_ui <- function(id){
  ns <- NS(id)
  tagList(

    shiny::sidebarLayout(
      shiny::sidebarPanel(
        titlePanel('To create an aa abundance plot,
        insert the amino-acide sequence in
        the box bellow.'),
        fluidRow(column(12,
        p("Here we provide an example peptide,
        the HUMAN Serotonin N-acetyltransferase.")
        )),
        shiny::textAreaInput(
          inputId = ns("peptide"),
          label = "Peptide sequence",
          width = 300,
          height = 200,
          value = paste0(c("MSTQSTHPLKPEAPRLPPGIPESPSCQ",
                         "RRHTLPASEFRCLTPEDAVSAFEIERE",
                         "AFISVLGVCPLYLDEIRHFLTLCPELS",
                         "LGWFEEGCLVAFIIGSLWDKERLMQES",
                         "LTLHRSGGHIAHLHVLAVHRAFRQQGR",
                         "GPILLWRYLHHLGSQPAVRRAALMCED",
                         "ALVPFYERFSFHAVGPCAITVGSLTFM",
                         "ELHCSLRGHPFLRRNSGC"), collapse = "")
        )
      ),
      shiny::mainPanel(
        shiny::plotOutput(
          outputId = ns("abundance")
        )

      )
    )
  )
}

#' plot Server Functions
#'
#' @noRd
mod_plot_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$abundance <- renderPlot({
      if(input$peptide == ""){
        NULL
      } else{
        input$peptide %>%
          Rbosome::aa_abundance_plot() +
          ggplot2::theme(legend.position = "none")
      }
    })

  })
}

## To be copied in the UI
# mod_plot_ui("plot_1")

## To be copied in the server
# mod_plot_server("plot_1")
