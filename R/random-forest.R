source("R/train-test-split.R")

library(caret)

nzv <- nearZeroVar(X_train)
X_train <- X_train[,-nzv]

tune_grid <- expand.grid(
  mtry = c(floor(log2(ncol(X_train))),
           floor(sqrt(ncol(X_train))),
           floor(ncol(X_train) / 3)),
  splitrule = "variance",
  min.node.size = 5
)

set.seed(1234)
rf_left_fit <- train(
  x = X_train,
  y = Y_train_left,
  method = "ranger",
  tuneGrid = tune_grid,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

rf_left_fit

set.seed(1234)
rf_right_fit <- train(
  x = X_train,
  y = Y_train_right,
  method = "ranger",
  tuneGrid = tune_grid,
  preProcess = c("center", "scale"),
  trControl = trainControl(
    method = "CV",
    number = 10,
    verboseIter = T
  )
)

rf_right_fit

pred <- predict(rf_fit$finalModel, data = X_test)
RMSE(pred = pred$predictions, obs = Y_test)

plot(pred$predictions - Y_test)

full_data
