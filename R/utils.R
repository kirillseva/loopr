get_option <- function(opt) {
  if (is.null(tmp <- getOption(opt))) {
    stop('You must set option ', crayon::red(opt), ' in order to use this package.\n',
      'Please consult with the package readme at https://github.com/avantcredit/loopr',
      call. = FALSE)
  }
  tmp
}

#' @export
loopr_integer <- function(min, max) { list(min = min, max = max, type = "int") }
#' @export
loopr_float   <- function(min, max, num_points) { list(num_points = num_points, min = min, max = max, type = "float") }
#' @export
loopr_enum    <- function(options) { list(options = options, type = "enum") }

report_error <- function(err) {
  if (is.null(err)) return(invisible(TRUE))
  stop('Remote error occured: ', err, call. = FALSE)
}
