#' Create an info box
#'
#' @param value Value to display. Usually a number or short text.
#' @param width Width of the box.
#' @param status Main color of the box.
#' @param title Title to display.
#' @param title_icon Icon to display alongside title. Should be produced by
#'     \code{\link{md_icon}}.
#' @param footer A footer to include in the box. Should be produced by
#'     \code{\link{md_footer}}.
#'
#' @export
md_info_box = function(value,
                       width = 3,
                       status = 'info',
                       title,
                       title_icon = NULL,
                       footer = NULL) {
  width_class = paste0(
    'col-lg-',
    width
  )

  status_class = paste0(
    'card-header card-header-',
    status,
    ' card-header-icon'
  )

  shiny::tags$div(
    class = width_class,
    shiny::tags$div(
      class = 'card card-stats',
      shiny::tags$div(
        class = status_class,
        shiny::tags$div(
          class = 'card-icon',
          title_icon
        ),
        shiny::tags$p(
          class = 'card-category',
          title
        ),
        shiny::tags$h3(
          class = 'card-title',
          value
        )
      ),
      footer
    )
  )
}

#' Create an info box programmatically (server-side)
#'
#' @param expr Expression that returns an info box.
#'
#' @export
md_render_info_box = function(expr) {
  card_stats_fun = shiny::exprToFunction(expr)

  shiny::renderUI({
    card_stats = card_stats_fun()
    tag_assert(card_stats, type = 'div')
    card_stats$children[[1]]
  })
}

#' Create an info box programmatically (UI-side)
#'
#' @param id Output variable name.
#' @param width Width of the box.
#'
#' @export
md_info_box_output = function(id, width = 3) {
  shiny::uiOutput(id, class = paste0('col-sm-', width))
}

#' Create a chart box
#'
#' @param ... Items to put.
#' @param id Output variable name.
#' @param width Width of the box.
#' @param status Color of the chart area.
#' @param title Title to display.
#' @param subtitle Subtitle to display below title.
#' @param footer A footer to include in the box. Should be produced by
#'     \code{\link{md_footer}}.
#'
#' @export
md_chart_box = function(...,
                        id = NULL,
                        width = 6,
                        status = 'success',
                        title = '',
                        subtitle = '',
                        footer = NULL) {
  match.arg(arg = status, choices = c('primary', 'info', 'success', 'warning', 'danger', 'rose'))

  shiny::tags$div(
    class = paste0('col-md-', width),
    id = id,
    shiny::tags$div(
      class = 'card card-chart',
      shiny::tags$div(
        class = paste0('card-header card-header-', status),
        ...
      ),
      shiny::tags$div(
        class = 'card-body',
        shiny::tags$h4(
          class = 'card-title',
          title
        ),
        shiny::tags$p(
          class = 'card-category',
          subtitle
        )
      ),
      footer
    )
  )
}

#' Create a tabbed box
#'
#' @param ... Items to put. Should be \code{\link{md_tab_panel}}s.
#' @param id Variable output name.
#' @param title Title to display.
#' @param width Width of the box.
#' @param status Color of the box header.
#'
#' @export
md_tab_box = function(...,
                      id = NULL,
                      title = NULL,
                      width = 6,
                      status = 'success') {

  content = shiny::tabsetPanel(
    ...,
    id = id
  )

  header = content$children[[1]]
  body = content$children[[2]]

  n_items = length(list(...))

  for (i in 1:n_items) {
    tab_title = header$children[[1]][[i]]$children[[1]]$children[[2]]
    header$children[[1]][[i]]$children[[1]]$children[[2]] = NULL

    icon_name = body$children[[1]][[i]]$children[[1]]$children[[1]]
    body$children[[1]][[i]]$children[[1]] = NULL

    header$children[[1]][[i]]$attribs$class = 'nav-item'

    if (i == 1) {
      header$children[[1]][[i]]$children[[1]]$attribs$class = 'nav-link active show'
    } else {
      header$children[[1]][[i]]$children[[1]]$attribs$class = 'nav-link'
    }

    header$children[[1]][[i]]$children[[1]]$children[[1]] = shiny::tagList(
      md_icon(icon_name),
      tab_title
      # shiny::tags$div(class = 'ripple-container')
    )
  }

  shiny::tags$div(
    class = paste0('col-sm-', width),
    shiny::tags$div(
      class = 'card',
      shiny::tags$div(
        class = paste0(
          'card-header card-header-tabs card-header-',
          status
        ),
        shiny::tags$div(
          class = 'nav-tabs-navigation',
          shiny::tags$div(
            class = 'nav-tabs-wrapper',
            shiny::tags$span(
              class = 'nav-tabs-title',
              title
            ),
            header
          )
        )
      ),
      shiny::tags$div(
        class = 'card-body',
        body
      )
    )
  )
}

#' Create a tab panel
#'
#' Create a tab panel that can be included within a \code{\link{md_tab_box}}
#'
#' @param title Title to display.
#' @param ... Items to put.
#' @param icon Icon to display alongside title. Should be produced by
#'     \code{\link{md_icon}}
#'
#' @export
md_tab_panel = function(...,
                        title,
                        icon = NULL) {
  div_tag = shiny::tags$div(
    class = 'tab-pane',
    title = title,
    icon,
    ...
  )
}

#' Create a general purpose box
#'
#' @param ... Items to put.
#' @param width Width of the box.
#' @param status Color of the box header.
#' @param title Title to display.
#' @param subtitle Subtitle to display below title.
#'
#' @export
md_box = function(...,
                  width = 6,
                  status = 'success',
                  title = NULL,
                  subtitle = NULL){
  shiny::tags$div(
    class = paste0('col-lg-', width),
    shiny::tags$div(
      class = 'card',
      shiny::tags$div(
        class = paste0('card-header card-header-', status),
        shiny::tags$h4(
          class = 'card-title',
          title
        ),
        shiny::tags$p(
          class = 'card-category',
          subtitle
        )
      ),
      shiny::tags$div(
        class = 'card-body',
        ...
      )
    )
  )
}
