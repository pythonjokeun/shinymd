#' Create dashboard sidebar
#'
#' @param ... Items to put in the dashboard sidebar.
#' @param title Title to display in the top side of the sidebar.
#' @param color Sidebar color theme.
#' @param background_color Sidebar's background color.
#' @param background_image Sidebar's background image.
#' @param title_url Title's redirect URL.
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
#'     body = md_body()
#'   )
#'
#'   server = function(input, output, session) {}
#'
#'   shinyApp(ui, server)
#' }
md_sidebar = function(...,
                      title = 'My Dashboard',
                      color = 'green',
                      background_color = 'white',
                      background_image = TRUE,
                      title_url = NULL) {
  match.arg(color, choices = c('purple', 'azure', 'green', 'orange', 'danger'))

  if (background_image == TRUE) {
    dir.create('www', showWarnings = FALSE)
    dir.create('www/sidebar_images', showWarnings = FALSE)

    lapply(1:4, function(i) {
      f = system.file(
        paste0('assets/external/img/sidebar-', i, '.jpg'),
        package = 'shinymd'
      )

      file.copy(f, 'www/sidebar_images', overwrite = FALSE)
    })

    img = paste0('sidebar_images/sidebar-', sample(1:4, 1), '.jpg')
  } else {
    img = NULL
  }

  shiny::tags$div(
    class = 'sidebar',
    `data-color` = color,
    `data-background-color` = background_color,
    `data-image` = img,
    shiny::tags$div(
      class = 'sidebar-wrapper',
      shiny::tags$div(
        class = 'logo',
        shiny::tags$a(
          href = ifelse(is.null(title_url), '#', title_url),
          class = 'simple-text logo-normal',
          title
        )
      ),
      ...
    )
  )
}

#' Create a sidebar menu
#'
#' @param ... Items to put. Typically \code{\link{md_sidebar_menu_item}}s.
#'
#' @export
#'
#' @seealso \code{\link{md_sidebar}} for example usage.
md_sidebar_menu = function(...) {
  shiny::tags$ul(
    class = 'nav',
    shiny::tagList(...)
  )
}

#' Create a sidebar menu item.
#'
#' @param tab_name Identifier that links menu item with \code{\link{md_tab_item}}.
#'     Should correspond exactly to the \code{tab_name} argument given in
#'     \code{\link{md_tab_item}}.
#' @param title Title to identify the menu item.
#' @param icon Icon to identify the menu item.
#'
#' @export
#'
#' @seealso \code{\link{md_sidebar}} for example usage.
md_sidebar_menu_item = function(tab_name,
                                title,
                                icon = md_icon('dashboard')) {
  shiny::tags$li(
    class = 'nav-item ',
    shiny::tags$a(
      class = 'nav-link',
      id = paste0('tab-', tab_name),
      href = paste0('#shiny-tab-', tab_name),
      `data-toggle` = 'tab',
      `data-value` = tab_name,
      icon,
      shiny::tags$p(title)
    )
  )
}

