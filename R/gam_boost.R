source("R/train-test-split.R")

library(caret)

nzv <- nearZeroVar(X_train)
X_train_sub <- X_train[, -nzv]

tune_grid <- expand.grid(
  mstop = seq(1000, 2000, by = 100),
  prune = F
)

set.seed(1234)
xg_left_fit <- train(
  x = X_train,
  y = Y_train_left,
  method = "gamboost",
  tuneGrid = tune_grid,
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
  method = "gamboost",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

xg_right_fit
