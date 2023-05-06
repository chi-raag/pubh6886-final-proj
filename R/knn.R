source("R/train-test-split.R")

library(caret)

tune_grid <- expand.grid(
  k = seq(1, 11, by = 2)
)

set.seed(1234)
knn_left_fit <- train(
  x = X,
  y = Y_left,
  method = "knn",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

knn_left_fit

set.seed(1234)
knn_right_fit <- train(
  x = X,
  y = Y_right,
  method = "knn",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

knn_right_fit
