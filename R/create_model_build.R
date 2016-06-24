#' @export
create_model_build <- function(params, minimize = FALSE, name = NULL, chooser = NULL) {
  if (!is.list(params) || length(params) == 0) {
    stop('params must be a list of hyperparameters you\'ll use for training.')
  }
  payload <- list(params = reformat_params(params), minimize = minimize, name = name, chooser = chooser)
  payload <- jsonlite::toJSON(Filter(Negate(is.null), payload), auto_unbox = TRUE, digits = 10)
  post_new_model(payload)
}

reformat_params <- function(params) {
  lapply(names(params), function(nm) { append(list(name = nm), params[[nm]]) })
}

post_new_model <- function(payload) {
  content(POST(
    paste0(LOOP_URL(), NEW_MODEL_PATH),
    body = payload,
    content_type_json()
  ))
}
