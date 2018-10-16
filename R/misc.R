#' Create a Material icon
#'
#' @param name Name of the icon. See \url{https://design.google.com/icons/}
#'     for available icons.
#'
#' @export
md_icon = function(name) {
  shiny::tags$i(
    class = 'material-icons',
    name
  )
}

#' Create a footer
#'
#' @param text Text to display.
#' @param icon Icon to display alongside text. Should be produced by
#'     \code{\link{md_icon}}.
#'
#' @export
md_footer = function(text, icon) {
  shiny::tags$div(
    class = 'card-footer',
    shiny::tags$div(
      class = 'stats',
      icon,
      text
    )
  )
}
