#' Create dashboard page
#'
#' @param title Title to display in browser's title bar.
#' @param header Dashboard header produced by \code{\link{md_header}}.
#' @param sidebar Dashboard sidebar produced by \code{\link{md_sidebar}}.
#' @param body Dashboard body produced by \code{\link{md_body}}.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinymd)
#'
#'   ui = md_page(
#'     header = md_header(),
#'     sidebar = md_sidebar(),
#'     body = md_body()
#'   )
#'
#'   server = function(input, output) {}
#'
#'   shinyApp(ui, server)
#' }
md_page = function(title = 'My Dashboard',
                   header = NULL,
                   sidebar = NULL,
                   body = NULL) {
  html_scripts = shiny::tags$head(
    shiny::tags$title(title),
    shiny::tags$meta(
      charset = 'utf-8'
    ),
    shiny::tags$meta(
      `http-equiv` = 'X-UA-Compatible',
      content = 'IE=edge,chrome=1'
    ),
    shiny::tags$meta(
      content = paste(
        'width=device-width',
        'initial-scale=1.0',
        'maximum-scale=1.0',
        'user-scalable=0',
        'shrink-to-fit=no',
        sep = ', '
      ),
      name = 'viewport'
    )
  )

  html_body = add_deps(
    shiny::tags$body(
      class = '',
      shiny::tags$div(
        class = 'wrapper',
        sidebar,
        shiny::tags$div(
          class = 'main-panel',
          header,
          body
        )
      )
    )
  )

  shiny::tags$html(
    html_scripts,
    html_body
  )
}
