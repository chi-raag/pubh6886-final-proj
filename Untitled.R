source("R/train-test-split.R")

library(caret)

nzv <- nearZeroVar(X_train)
X_train_sub <- X_train[, -nzv]

tune_grid <- data.frame(size = seq(100, 300, by = 20))

set.seed(1234)
xg_fit <- train(
  x = X_train_sub,
  y = Y_train,
  method = "mlp",
  tuneGrid = tune_grid,
  trControl = trainControl(
    method = "CV",
    number = 2,
    verboseIter = T
  )
)

