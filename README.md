# shinymd

## Overview

Create Bootstrap 4 Material Design dashboard with Shiny. Based on https://www.creative-tim.com/product/material-dashboard.

## Installation

```r
devtools::install_github('pythonjokeun/shinymd')
```

## Example usage

```r
require(shinymd)
require(highcharter)

ui = md_page(
  header = md_header(
    md_dropdown_menu_output('notification_1_menu'),
    md_dropdown_menu(
      icon = md_icon('shopping_cart'),
      md_dropdown_menu_item('1.1'),
      md_dropdown_menu_item('1.2'),
      md_dropdown_menu_item('1.3')
    )
  ),
  sidebar = md_sidebar(
    title = 'Dashboard Title',
    md_sidebar_menu(
      md_sidebar_menu_item(
        title = 'Sidebar menu 1',
        tab_name = 'sidebar_tab_1',
        icon = md_icon('loyalty')
      ),
      md_sidebar_menu_item(
        title = 'Sidebar menu 2',
        tab_name = 'sidebar_tab_2',
        icon = md_icon('face')
      )
    )
  ),
  body = md_body(
    md_tab_items(
      md_tab_item(
        tab_name = 'sidebar_tab_1',
        fluidRow(
          md_info_box_output('card_stats_1', width = 3),
          md_info_box_output('card_stats_2', width = 3),
          md_info_box_output('card_stats_3', width = 3),
          md_info_box_output('card_stats_4', width = 3)
        ),
        fluidRow(
          md_chart_box(
            width = 6,
            status = 'success',
            title = 'Chart Box 1 Title',
            subtitle = 'Chart box 1 subtitle',
            footer = md_footer(
              text = 'Chart box 1 footer',
              icon = md_icon('access_time')
            ),
            highchartOutput('chart_1', height = '250px')
          )
        )
      ),
      md_tab_item(
        tab_name = 'sidebar_tab_2',
        fluidRow(
          md_tab_box(
            title = 'Tab Box 1',
            width = 6,
            md_tab_panel(
              title = 'Tab 1',
              icon = md_icon('face'),
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus sit amet dictum sit amet justo donec enim.'
            ),
            md_tab_panel(
              title = 'Tab 2',
              icon = md_icon('rowing'),
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mauris pellentesque pulvinar pellentesque habitant. Duis at tellus at urna condimentum mattis pellentesque.'
            )
          ),
          md_box(
            title = 'Box Title',
            subtitle = 'Box subtitle',
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Neque gravida in fermentum et sollicitudin ac orci phasellus. Elit eget gravida cum sociis natoque penatibus et. Turpis massa sed elementum tempus egestas sed sed. Facilisis mauris sit amet massa vitae tortor condimentum lacinia.'
          )
        )
      )
    )
  )
)

server = function(input, output, session) {
  output$notification_1_menu = md_render_dropdown_menu({
    notif = list(
      'Notification 1.1',
      'Notification 1.2',
      'Notification 1.3'
    )

    items = lapply(notif, function(x) {
      md_dropdown_menu_item(x)
    })

    md_dropdown_menu(
      icon = md_icon('notifications'),
      items
    )
  })

  output$notification_2_menu = md_render_dropdown_menu({
    notif = list()

    items = lapply(notif, function(x) {
      md_message_item(x)
    })

    md_dropdown_menu(
      icon = md_icon('shopping_cart'),
      items
    )
  })

  output$card_stats_1 = md_render_info_box({
    md_info_box(
      100,
      status = 'info',
      title = 'Card stats 1 title',
      title_icon = md_icon('rowing'),
      footer = md_footer(
        text = 'Card stats 1 footer',
        icon = md_icon('cached')
      )
    )
  })

  output$card_stats_2 = md_render_info_box({
    md_info_box(
      200,
      status = 'success',
      title = 'Card stats 2 title',
      title_icon = md_icon('group'),
      footer = md_footer(
        text = 'Card stats 2 footer',
        icon = md_icon('priority_high')
      )
    )
  })

  output$card_stats_3 = md_render_info_box({
    md_info_box(
      300,
      status = 'danger',
      title = 'Card stats 3 title',
      title_icon = md_icon('face'),
      footer = md_footer(
        text = 'Card stats 3 footer',
        icon = NULL
      )
    )
  })

  output$card_stats_4 = md_render_info_box({
    md_info_box(
      300,
      status = 'warning',
      title = 'Card stats 4 title',
      title_icon = md_icon('domain'),
      footer = md_footer(
        text = 'Card stats 4 footer',
        icon = NULL
      )
    )
  })

  output$chart_1 = renderHighchart({
    chart = hchart(ggplot2::diamonds$cut, colorByPoint = TRUE, name = 'Cut')
    chart = hc_add_theme(chart, hc_theme_google())
    chart
  })
}

shinyApp(ui, server)
```
