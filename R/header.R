#' Create a dashboard header
#'
#' @param ... Items to put in the dashboard header.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinymd)
#'
#'   ui = md_page(
#'     header = md_header(
#'       md_dropdown_menu(
#'         icon = md_icon('shopping_cart'),
#'         md_dropdown_menu_item('Message 1'),
#'         md_dropdown_menu_item('Message 2')
#'       ),
#'
#'       # Create dropdown menu programmatically (UI-side)
#'       md_dropdown_menu_output('dropdown_menu')
#'     ),
#'     sidebar = md_sidebar(),
#'     body = md_body()
#'   )
#'
#'   server = function(input, output) {
#'     # Create dropdown menu programmatically (server-side)
#'     output$dropdown_menu = md_render_dropdown_menu({
#'
#'       # Assuming the dropdown menu's message stored in a list
#'       notif = list(
#'         'Message 3',
#'         'Message 4',
#'         'Message 5'
#'       )
#'
#'       items = lapply(notif, function(x) {
#'         md_dropdown_menu_item(x)
#'       })
#'
#'       md_dropdown_menu(
#'         icon = md_icon('notifications'),
#'         items
#'       )
#'     })
#'   }
#'
#'   shinyApp(ui, server)
#' }
md_header = function(...) {
  shiny::tags$nav(
    class = paste(
      'navbar',
      'navbar-expand-lg',
      'navbar-transparent',
      'navbar-absolute',
      'fixed-top ',
      sep = ' '
    ),
    shiny::tags$div(
      class = 'container-fluid',
      shiny::tags$div(
        class = 'navbar-wrapper',
        shiny::tags$a(
          class = 'navbar-brand'
        )
      ),
      shiny::tags$button(
        class = 'navbar-toggler',
        type = 'button',
        `data-toggle` = 'collapse',
        `aria-controls` = 'navigation-index',
        `aria-expanded` = 'false',
        `aria-label` = 'Toggle navigation',
        shiny::tags$span(
          class = 'sr-only',
          'Toggle navigation'
        ),
        shiny::tags$span(
          class = 'navbar-toggler-icon icon-bar'
        ),
        shiny::tags$span(
          class = 'navbar-toggler-icon icon-bar'
        ),
        shiny::tags$span(
          class = 'navbar-toggler-icon icon-bar'
        )
      ),
      shiny::tags$div(
        class = paste(
          'collapse',
          'navbar-collapse',
          'justify-content-end',
          sep = ' '
        ),
        shiny::tags$ul(
          class = 'navbar-nav',
          ...
        )
      )
    )
  )
}

#' Create a dropdown menu
#'
#' @param ... Items to put. Typically, \code{\link{md_dropdown_menu_item}}.
#' @param icon Icon to identify the dropdown menu. Should be produced by
#'     \code{\link{md_icon}}.
#'
#' @export
#'
#' @seealso \code{\link{md_header}} for example usage.
md_dropdown_menu = function(..., icon = md_icon('notifications')) {
  nav_link = shiny::tags$a(
    class = 'nav-link',
    href = '#',
    `data-toggle` = 'dropdown',
    `aria-haspopup` = 'true',
    `aria-expanded` = 'false',
    id = 'navbarDropdownMenuLink',
    icon
  )

  items = list(...)

  if (any(sapply(items, is.list)) && class(items[[1]]) != 'shiny.tag') {
    items = items[[1]]
  }

  if (length(items) > 0) {
    nav_link = shiny::tagAppendChildren(
      nav_link,
      shiny::tags$span(
        class = 'notification',
        length(items)
      ),
      shiny::tags$p(
        class = 'd-lg-none d-md-block'
      )
    )
  } else {
    items = shiny::tags$a(
      class = 'dropdown-item',
      style = 'pointer-events: none;',
      'No new messages'
    )
  }

  shiny::tags$li(
    class = 'nav-item dropdown',
    nav_link,
    shiny::tags$div(
      class = 'dropdown-menu dropdown-menu-right',
      shiny::tagList(items)
    )
  )
}

#' Create a dropdown menu item
#'
#' @param message Message to display.
#'
#' @export
#'
#' @seealso \code{\link{md_header}} for example usage.
md_dropdown_menu_item = function(message) {
  shiny::tags$a(
    class = 'dropdown-item',
    message
  )
}

#' Create a dropdown menu programmatically (UI-side)
#'
#' @param id Output variable name.
#'
#' @export
#'
#' @seealso \code{\link{md_header}} for example usage and \code{\link{md_render_dropdown_menu}}
#'     for corresponding server-side function.
md_dropdown_menu_output = function(id) {
  shiny::uiOutput(outputId = id)
}

#' Create a dropdown menu programmatically (server-side)
#'
#' @param expr Expression that returns dropdown menu with its items.
#'
#' @export
#'
#' @seealso \code{\link{md_header}} for example usage and \code{\link{md_dropdown_menu_output}}
#'     for corresponding UI-side function.
md_render_dropdown_menu = function(expr) {
  shiny::renderUI(expr)
}
