# Add an html dependency, without overwriting existing ones
append_deps = function(x, value) {
  if (inherits(value, 'html_dependency')) {
    value = list(value)
  }

  old = attr(x, 'html_dependencies', TRUE)

  htmltools::htmlDependencies(x) = c(old, value)

  x
}

# Add dashboard dependencies to a tag object
add_deps = function(x) {
  md_version = as.character(utils::packageVersion('shinymd'))

  deps = list(
    htmltools::htmlDependency(
      name = 'googlefonts',
      version = md_version,
      src = c(
        file = system.file(
          'assets/external/css/',
          package = 'shinymd'
        )
      ),
      stylesheet = 'google-fonts.css'
    ),
    htmltools::htmlDependency(
      name = 'font-awesome',
      version = '4.7.0',
      src = c(href = 'https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/'),
      stylesheet = 'font-awesome.min.css'
    ),
    htmltools::htmlDependency(
      name = 'material-dashboard',
      version = '2.1.0',
      src = c(
        file = system.file(
          'assets/external/css/',
          package = 'shinymd'
        )
      ),
      stylesheet = 'material-dashboard.min.css'
    ),
    htmltools::htmlDependency(
      name = 'jquery',
      version = '3.2.1',
      src = c(
        file = system.file(
          'assets/external/js/core/',
          package = 'shinymd'
        )
      ),
      script = 'jquery.min.js'
    ),
    htmltools::htmlDependency(
      name = 'popper',
      version = md_version,
      src = c(
        file = system.file(
          'assets/external/js/core/',
          package = 'shinymd'
        )
      ),
      script = 'popper.min.js'
    ),
    htmltools::htmlDependency(
      name = 'perfect-scrollbar',
      version = '0.6.13',
      src = c(
        file = system.file(
          'assets/external/js/plugins/',
          package = 'shinymd'
        )
      ),
      script = 'perfect-scrollbar.jquery.min.js'
    ),
    htmltools::htmlDependency(
      name = 'bootstrap-material-design',
      version = md_version,
      src = c(
        file = system.file(
          'assets/external/js/core/',
          package = 'shinymd'
        )
      ),
      script = 'bootstrap-material-design.min.js'
    ),
    htmltools::htmlDependency(
      name = 'material-dashboard-js',
      version = '2.1.0',
      src = c(
        file = system.file(
          'assets/external/js/',
          package = 'shinymd'
        )
      ),
      script = 'material-dashboard.min.js'
    ),
    htmltools::htmlDependency(
      name = 'core',
      version = md_version,
      src = c(
        file = system.file(
          'assets/internal/js/',
          package = 'shinymd'
        )
      ),
      script = 'core.js'
    )
  )

  append_deps(x, deps)
}
