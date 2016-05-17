context('create model build')

test_that('it can parse floats, ints and enums', {
  model_build <- create_model_build(
    params = list(
      integer_param = loopr_integer(min = 300, max = 349),
      float_param   = loopr_float(min = 0, max = 1, num_points = 50),
      enum_param    = loopr_enum(options = c('foo', 'bar', 'baz'))
    )
  )
})
