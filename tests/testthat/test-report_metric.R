context("report metric")

describe('with mocked server context', {
  test_that('it returns true if everything is fine', {
    with_mock(
      `httr::POST` = function(...) TRUE,
      `httr::status_code` = function(...) 200,
      `httr::content` = function(...) list(status = "ok"),
      expect_true(report_metric('boom', 1, 1))
    )
  })

  test_that('it returns a big error in case we don\'t get an "ok"', {
    with_mock(
      `httr::POST` = function(...) TRUE,
      `httr::status_code` = function(...) 200,
      `httr::content` = function(...) list(something = "wrong"),
      expect_error(report_metric('boom', 1, 1, 2), "Something went wrong during metric report with the following parameteres:")
    )
  })
})
