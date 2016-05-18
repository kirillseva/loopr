context("new iteration")

describe('with mocked server context', {
  test_that('it errors out on garbage input', {
    with_mock(
      `httr::GET` = function(...) TRUE,
      `httr::status_code` = function(...) 404,
      expect_error(new_iteration('boom'), 'Server replied with a 404')
    )
  })

  test_that('it propagates server-side exceptions', {
    with_mock(
      `httr::GET` = function(...) TRUE,
      `httr::status_code` = function(...) 200,
      `httr::content` = function(...) list(exception = "badabing"),
      expect_error(new_iteration('boom'), 'badabing')
    )
  })

  test_that('happy case', {
    happy = list(params = list(a = 1, b = 2, c = "hello"), loop_id = 42)
    with_mock(
      `get_new_iteration` = function(...) happy,
      expect_equal(new_iteration('boom'), happy),
      .env = "loopr"
    )
  })
})
