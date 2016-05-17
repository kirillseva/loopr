get_option <- function(opt) {
  if (!nzchar(tmp <- getOption(opt))) {
    stop('You must set option ', crayon::red(opt), ' in order to use this package.\n',
      'Please consult with the package readme at https://github.com/avantcredit/loopr')
  }
  tmp
}
