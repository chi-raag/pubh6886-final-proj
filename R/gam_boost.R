source("R/train-test-split.R")

tune_grid <- expand.grid(
  mstop = seq(500, 1000, by = 100),
  prune = F
)

set.seed(1234)
gamb_left_fit <- train(
  x = X,
  y = Y_left,
  method = "gamboost",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

gamb_left_fit

set.seed(1234)
gamb_right_fit <- train(
  x = X,
  y = Y_right,
  method = "gamboost",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

gamb_right_fit
