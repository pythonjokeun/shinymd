# Assert that a tag has specified properties
tag_assert = function(tag, type = NULL, class = NULL, allow_ui = TRUE) {
  if (!inherits(tag, 'shiny.tag')) {
    print(tag)
    stop('Expected an object with class \'shiny.tag\'.')
  }

  if (allow_ui &&
      (has_css_class(tag, 'shiny-html-output') ||
       has_css_class(tag, 'shinydashboard-menu-output'))) {
    return()
  }

  if (!is.null(type) && tag$name != type) {
    stop('Expected tag to be of type ', type)
  }

  if (!is.null(class)) {
    if (is.null(tag$attribs$class)) {
      stop('Expected tag to have class \'', class, '\'')

    } else {
      tag_classes = strsplit(tag$attribs$class, ' ')[[1]]
      if (!(class %in% tag_classes)) {
        stop('Expected tag to have class \'', class, '\'')
      }
    }
  }
}

# Return TRUE if a shiny.tag object has a CSS class, FALSE otherwise.
has_css_class = function(tag, class) {
  if (is.null(tag$attribs) || is.null(tag$attribs$class))
    return(FALSE)

  classes = strsplit(tag$attribs$class, ' +')[[1]]

  return(class %in% classes)
}
