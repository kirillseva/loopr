get_option <- function(opt) {
  if (is.null(tmp <- getOption(opt))) {
    stop('You must set option ', crayon::red(opt), ' in order to use this package.\n',
      'Please consult with the package readme at https://github.com/avantcredit/loopr',
      call. = FALSE)
  }
  tmp
}

#' @export
loopr_integer <- function(min, max, num_points = NULL) {
  list(min = min, max = max, num_points = num_points %||% NA, type = "int")
}
#' @export
loopr_float   <- function(min, max, num_points) { list(num_points = num_points, min = min, max = max, type = "float") }
#' @export
loopr_enum    <- function(options) {
  if (length(options) < 2) { stop("You need at least two options for loopr_enum", call. = FALSE) }
  list(options = as.character(options), type = "enum")
}

report_error <- function(err) {
  if (is.null(err)) return(invisible(TRUE))
  stop('Remote error occured: ', err, call. = FALSE)
}

content_or_404 <- function(res) {
  if ({code <- status_code(res)} %in% c(404, 500)) {
    list(exception = paste("Server replied with an error code", code))
  } else { content(res) }
}

`%||%` <- function(x, y) { if (is.null(x)) y else x }

loopr_cache <- new.env()

#' @export
latest_params <- function() { loopr_cache$latest_params }
#' @export
latest_grid <- function() { loopr_cache$latest_grid }
