source("R/train-test-split.R")

library(caret)

tune_grid <- expand.grid(
  nrounds = seq(100, 400, by = 100),
  eta = .3,
  lambda = 0,
  alpha = 1
)

set.seed(1234)
xg_left_fit <- train(
  x = X_train,
  y = Y_train_left,
  method = "xgbLinear",
  tuneGrid = tune_grid,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)
xg_left_fit

set.seed(1234)
xg_right_fit <- train(
  x = X_train,
  y = Y_train_right,
  method = "xgbLinear",
  tuneGrid = tune_grid,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

xg_right_fit
