get_option <- function(opt) {
  if (!nzchar(tmp <- getOption(opt))) {
    stop('You must set option ', crayon::red(opt), ' in order to use this package.\n',
      'Please consult with the package readme at https://github.com/avantcredit/loopr')
  }
  tmp
}

loopr_integer <- function(min, max) { list(min = min, max = max, type = "int") }
loopr_float   <- function(min, max, num_points) { list(num_points = num_points, min = min, max = max, type = "float") }
loopr_enum    <- function(options) { list(options = options, type = "enum") }
