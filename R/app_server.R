#' The application server-side
#'
#'@importFrom magrittr %>%
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  mod_plot_server("plot_1")
}
