loop <- function(train_fn, params, metric, train_df, validation_df, iterations, minimize) {
  model_id <- create_model_build(params, minimize = minimize)$id
  message(crayon::green(paste0("Building ", iterations, " models for model build <", model_id, ">:")))
  invisible(lapply(seq_len(iterations), function(idx) {
    iteration <- new_iteration(model_id)
    duration <- as.numeric(system.time(cls <- train_fn(train_df, iteration$params))[3])
    value  <- metric(cls, validation_df, "Sepal.Length")
    report_metric(model_id, iteration$loop_id, value, duration)
    summarize(iteration$params, value, duration, idx)
    list(classifier = cls, metric_value = value, duration = duration)
  }))
}

summarize <- function(params, value, duration, iteration) {
  param_summary <- sapply(names(params), function(x) paste0(crayon::yellow(x),': ',crayon::green(as.character(params[[x]]))) )
  param_summary <- paste0(param_summary, collapse = "; ")
  message(
    "Iteration: ", iteration, "\n",
    "Params: ", param_summary, "\n",
    "Duration: ", duration, "\n",
    "Value: ", value, "\n==========\n"
  )
}
