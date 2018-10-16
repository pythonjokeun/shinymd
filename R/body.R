#' Create a dashboard body
#'
#' @param ... Items to put. Typically \code{\link{md_tab_items}}.
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
#'     sidebar = md_sidebar(
#'       title = 'Dashboard Title',
#'       md_sidebar_menu(
#'         md_sidebar_menu_item(
#'           title = 'Tab 1',
#'           tab_name = 'tab_1',
#'           icon = md_icon('loyalty')
#'         ),
#'         md_sidebar_menu_item(
#'           title = 'Tab 2',
#'           tab_name = 'tab_2',
#'           icon = md_icon('face')
#'         )
#'       )
#'     ),
#'     body = md_body(
#'       md_tab_items(
#'         md_tab_item(
#'           tab_name = 'tab_1',
#'           tags$h2('Tab 1 content')
#'         ),
#'         md_tab_item(
#'           tab_name = 'tab_2',
#'           tags$h2('Tab 2 content')
#'         )
#'       )
#'     )
#'   )
#'
#'   server = function(input, output, session) {}
#'
#'   shinyApp(ui, server)
#' }
md_body = function(...) {
  shiny::tags$div(
    class = 'content',
    ...
  )
}

#' Create a tabs container
#'
#' @param ... Items to put. Typically \code{\link{md_tab_item}}.
#'
#' @export
#'
#' @seealso \code{\link{md_body}} for example usage.
md_tab_items = function(...) {
  shiny::tags$div(
    class = 'tab-content',
    ...
  )
}

#' Create a tab
#'
#' @param tab_name Identifier that links tab with \code{\link{md_sidebar_menu_item}}.
#'     Should correspond exactly to the \code{tab_name} argument given in
#'     \code{\link{md_sidebar_menu_item}}
#' @param ... Items to put.
#'
#' @export
#'
#' @seealso \code{\link{md_body}} for example usage.
md_tab_item = function(tab_name, ...) {
  shiny::tags$div(
    role = 'tabpanel',
    class = 'tab-pane container-fluid',
    id = paste0('shiny-tab-', tab_name),
    ...
  )
}

#' Create a row to organize UI items
#'
#' Use this whenever you need to organize contents by row.
#'
#' @param ... Items to put.
#'
#' @export
md_row = function(...){
  shiny::tags$div(
    class = 'row',
    ...
  )
}
