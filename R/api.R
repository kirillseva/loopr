
post_report_metric <- function(id, payload) {
  content(POST(
    paste0(LOOP_URL(), REPORT_METRIC_PATH, id),
    body = payload,
    content_type_json()
  ))
}
