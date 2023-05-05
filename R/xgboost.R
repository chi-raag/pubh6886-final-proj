source("R/train-test-split.R")

library(caret)

tune_grid <- expand.grid(
  nrounds = seq(100, 200, by = 50),
  eta = .3,
  lambda = c(0, .5),
  alpha = c(.5, 1)
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
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

xg_right_fit
