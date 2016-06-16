#' @export
view_grid <- function(id) {
  if (!(is.character(id) && length(id) == 1)) {
    stop(sQuote('id'), ' must be the id returned from one of the previous calls to ', sQuote('create_model_build'), call. = FALSE)
  }
  result <- get_grid(id)
  report_error(result$exception)
  suppressWarnings(grid <- recombinator::recombinator(jsonlite::fromJSON(result$grid)))
  rownames(grid) <- NULL
  loopr_cache$latest_grid <- grid
  list(grid = grid, minimize = isTRUE(result$minimize))
}

get_grid <- function(id) {
  content_or_404(GET(paste0(LOOP_URL(), VIEW_GRID_PATH, id)))
}
