#' @export
new_iteration <- function(id) {
  if (!(is.character(id) && length(id) == 1)) {
    stop(sQuote('id'), ' must be the id returned from one of the previous calls to ', sQuote('create_model_build'), call. = FALSE)
  }
  result <- get_new_iteration(id)
  report_error(result$exception)
  loopr_cache$latest_params <- result
  loopr_cache$latest_params$timestamp <- as.numeric(Sys.time())
  result
}

get_new_iteration <- function(id) {
  content_or_404(GET(paste0(LOOP_URL(), NEW_ITERATION_PATH, id)))
}
