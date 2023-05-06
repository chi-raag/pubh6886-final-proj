source("R/train-test-split.R")

tune_grid <- expand.grid(
  nrounds = 100,
  eta = 0.5,
  max_depth = c(2, 4, 6, 8, 10),
  colsample_bytree = 1,
  subsample = 1,
  gamma = 0,
  min_child_weight = 1
)

set.seed(1234)
xg_left_fit <- train(
  x = X,
  y = Y_left,
  method = "xgbTree",
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
