#' @export
create_model_build <- function(params, minimize = FALSE) {
  if (!is.list(params) || length(params) == 0) {
    stop('params must be a list of hyperparameters you\'ll use for training.')
  }
  payload <- jsonlite::toJSON(list(params = reformat_params(params), minimize = minimize), auto_unbox = TRUE)
  post_new_model(payload)
}

reformat_params <- function(params) {
  lapply(names(params), function(nm) { append(list(name = nm), params[[nm]]) })
}
