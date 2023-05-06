source("R/train-test-split.R")

tune_grid <- expand.grid(
  mtry = c(floor(log2(ncol(X))),
           floor(sqrt(ncol(X))),
           floor(ncol(X) / 3)),
  splitrule = "variance",
  min.node.size = 5
)

set.seed(1234)
rf_left_fit <- train(
  x = X,
  y = Y_left,
  method = "ranger",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

rf_left_fit

set.seed(1234)
rf_right_fit <- train(
  x = X,
  y = Y_right,
  method = "ranger",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

rf_right_fit
