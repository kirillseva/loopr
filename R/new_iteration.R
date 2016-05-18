#' @export
new_iteration <- function(id) {
  if (!(is.character(id) && length(id) == 1)) {
    stop(sQuote('id'), ' must be the id returned from one of the previous calls to ', sQuote('create_model_build'), call. = FALSE)
  }
  result <- get_new_iteration(id)
  report_error(result$exception)
  result
}

get_new_iteration <- function(id) {
  res <- GET(paste0(LOOP_URL(), NEW_ITERATION_PATH, id), verbose())
  if (status_code(res) == 404) {
    list(exception = "Server replied with a 404")
  } else { content(res) }
}
