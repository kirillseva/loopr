#' @export
report_metric <- function(id, loop_id, value, duration = NULL) {
  result <- post_report_metric(id, loop_id, value, duration)
  report_error(result$exception)
  if (result$status %||% "" != "ok") {
    stop(
      "Something went wrong during metric report with the following parameteres:\n",
      "  id = ",             id,             "\n",
      "  loop_id = ",   loop_id,             "\n",
      "  value = ",       value,             "\n",
      "  duration = ", duration %||% "NULL", "\n",
      "Inspect heroku logs on the server to find out more about it.", call. = FALSE
    )
  } else { invisible(TRUE) }
}

post_report_metric <- function(id, loop_id, value, duration) {
  payload <- jsonlite::toJSON(Filter(Negate(is.null), list(loop_id = loop_id, value = value, duration = duration)), auto_unbox = TRUE)
  res <- POST(
    paste0(LOOP_URL(), REPORT_METRIC_PATH, id),
    body = payload,
    content_type_json()
  )
  content_or_404(res)
}
