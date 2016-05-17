context('create model build')

describe('with mocked server context', {
  with_mock(
    post_new_model = function(payload) {
      expect_is(payload, 'json')
      jsonlite::fromJSON(payload)
    },
    test_that('it can parse floats, ints and enums', {
      params = list(
        integer_param = loopr_integer(min = 300, max = 349),
        float_param   = loopr_float(min = 0, max = 1, num_points = 50),
        enum_param    = loopr_enum(options = c('foo', 'bar', 'baz'))
      )
      model_build <- create_model_build(params)
      expect_equal(sort(names(model_build)), sort(c('params', 'minimize')))
      expect_equal(model_build$params$name, names(params))
      expect_equal(model_build$params$type, c('int', 'float', 'enum'))
      expect_false(model_build$minimize)
    })
  )
})
