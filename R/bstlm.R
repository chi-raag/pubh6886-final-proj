source("R/train-test-split.R")

tune_grid <- expand.grid(
  mstop = seq(100, 1000, by = 100),
  nu = c(.01, .05, .1, .2, .5, .7, .9)
)

set.seed(1234)
bstlm_left_fit <- train(
  x = X,
  y = Y_left,
  method = "BstLm",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

bstlm_left_fit

set.seed(1234)
bstlm_right_fit <- train(
  x = X,
  y = Y_right,
  method = "BstLm",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

bstlm_right_fit
