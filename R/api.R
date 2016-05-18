post_new_model <- function(payload) {
  content(POST(
    paste0(LOOP_URL(), NEW_MODEL_PATH),
    body = payload,
    content_type_json()
  ))
}

post_new_iteration <- function(payload) {
  content(POST(
    paste0(LOOP_URL(), NEW_ITERATION_PATH),
    body = payload,
    content_type_json()
  ))
}

post_report_metric <- function(payload) {
  content(POST(
    paste0(LOOP_URL(), REPORT_METRIC_PATH),
    body = payload,
    content_type_json()
  ))
}
