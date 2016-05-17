post_new_model <- function(payload) {
  content(POST(
    paste0(LOOP_URL(), NEW_MODEL_PATH),
    body = payload,
    content_type_json()
  ))
}
