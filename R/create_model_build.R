#' @export
create_model_build <- function(params, minimize = FALSE) {
  if (!is.list(params) || length(params) == 0) {
    stop('params must be a list of hyperparameters you\'ll use for training.')
  }
}
