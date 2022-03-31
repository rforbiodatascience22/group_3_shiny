#' The application server-side
#'
#'@importFrom magrittr %>%
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  mod_plot_server("plot_1")
  mod_make_peptide_server("make_peptide_1")
  mod_restr_enzyme_server("restr_enzyme_1")
}
