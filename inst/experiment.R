load_all(); library(mlbench); data(Shuttle); library(glmnet)

df <- Shuttle
df$dep_var <- as.numeric(df$Class == "Rad.Flow")
df$Class <- NULL
train_df <- head(df, 40000)
validation_df <- df[40001:58000, ]

loop(
  train_fn = function(dataframe, params) {
    df <- dataframe[, setdiff(names(dataframe), 'dep_var'), drop = FALSE]
    x  <- model.matrix(formula('~.'), data = df)
    y  <- dataframe[['dep_var']]
    cls <- glmnet::cv.glmnet(x, y, nfolds = 5, family = "binomial", alpha = params$alpha)
    list(predict = function(df) {
      df$dep_var <- NULL
      x <- model.matrix(formula('~.'), data = df)
      y  <- glmnet::predict.cv.glmnet(cls, x, s = "lambda.min", type = "response")
      as.numeric(y)
    })
  },
  params = list(
    alpha = loopr_float(min = 0, max = 1, num_points = 1000)
  ),
  metric = function(cls, validation, dep_var = "dep_var") {
    rmse_metric <- function(actual, predicted) { sqrt(mean((actual - predicted)^2)) }
    as.numeric(rmse_metric(validation$dep_var, cls$predict(validation)))
  },
  validation_df = validation_df,
  train_df      = train_df,
  iterations    = 50,
  minimize      = TRUE
) -> evaluation
